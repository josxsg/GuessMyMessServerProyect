using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure; 
using System.Data.Entity.Validation;      
using System.Net.Mail;                    
using System.Threading.Tasks;
using System.Linq;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities;
using GuessMyMessServer.Utilities.Email;
using log4net;

namespace GuessMyMessServer.BusinessLogic
{
    public class AuthenticationLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(AuthenticationLogic));

        private readonly GuessMyMessDBEntities _context;
        private readonly IEmailService _emailService;
        private static readonly Random _random = new Random();

        public AuthenticationLogic(IEmailService emailService, GuessMyMessDBEntities context)
        {
            _emailService = emailService;
            _context = context;
        }

        public async Task<OperationResultDto> LoginAsync(string emailOrUsername, string password)
        {
            if (string.IsNullOrWhiteSpace(emailOrUsername) || string.IsNullOrWhiteSpace(password))
            {
                _log.Info("Failed login attempt: Empty fields provided.");
                throw new ArgumentException("Username/Email and password are required.");
            }

            const int StatusOnline = 2;

            var player = await _context.Player.FirstOrDefaultAsync(p =>
                p.username == emailOrUsername || p.email == emailOrUsername);

            if (player == null)
            {
                _log.Info($"Failed login attempt: User '{emailOrUsername}' not found.");
                throw new InvalidOperationException("Incorrect credentials.");
            }

            if (player.is_verified == (byte)0)
            {
                _log.Info($"Login denied: User '{player.username}' account is not verified.");
                throw new InvalidOperationException("The account has not been verified. Please, check your email.");
            }

            if (!PasswordHasher.VerifyPassword(password, player.password))
            {
                _log.Info($"Failed login attempt: Incorrect credentials for user '{player.username}'.");
                throw new InvalidOperationException("Incorrect credentials.");
            }

            player.UserStatus_idUserStatus = StatusOnline;

            try
            {
                await _context.SaveChangesAsync();
                _log.Info($"User '{player.username}' logged in successfully.");

                return new OperationResultDto { Success = true, Message = player.username };
            }
            catch (DbUpdateException dbEx)
            {
                _log.Warn($"Database error updating Online status for user '{player.username}'", dbEx);
                throw new InvalidOperationException("A database error occurred while logging in.", dbEx);
            }
        }

        public async Task<OperationResultDto> RegisterPlayerAsync(UserProfileDto userProfile, string password)
        {
            if (userProfile == null || string.IsNullOrWhiteSpace(password))
            {
                _log.Info("Registration failed: Null data provided.");
                throw new ArgumentNullException(nameof(userProfile), "User profile and password are required.");
            }

            if (string.IsNullOrWhiteSpace(userProfile.Username) ||
                string.IsNullOrWhiteSpace(userProfile.Email) ||
                string.IsNullOrWhiteSpace(userProfile.FirstName) ||
                string.IsNullOrWhiteSpace(userProfile.LastName))
            {
                _log.Info($"Registration failed: Incomplete fields for user '{userProfile.Username ?? "Unknown"}'.");
                throw new ArgumentException("All fields (Username, First Name, Last Name, Email) are required.");
            }

            if (!InputValidator.IsValidEmail(userProfile.Email))
            {
                _log.Info($"Registration failed: Invalid email format '{userProfile.Email}'.");
                throw new ArgumentException("The email format is not valid. (Ex: user@domain.com)");
            }

            if (!InputValidator.IsPasswordSecure(password))
            {
                _log.Info($"Registration failed: Insecure password for user '{userProfile.Username}'.");
                throw new ArgumentException("The password does not meet the security requirements.");
            }

            const int StatusOffline = 1;
            string verificationCode = _random.Next(100000, 999999).ToString("D6");

            if (await _context.Player.AnyAsync(p => p.username == userProfile.Username))
            {
                _log.Info($"Registration failed: Username '{userProfile.Username}' already exists.");
                throw new InvalidOperationException("The username is already in use.");
            }
            if (await _context.Player.AnyAsync(p => p.email == userProfile.Email))
            {
                _log.Info($"Registration failed: Email '{userProfile.Email}' is already registered.");
                throw new InvalidOperationException("The email is already registered.");
            }

            try
            {
                var emailTemplate = new VerificationEmailTemplate(userProfile.Username, verificationCode);
                await _emailService.SendEmailAsync(userProfile.Email, userProfile.Username, emailTemplate);
                _log.Info($"Verification email sent to '{userProfile.Email}'.");
            }
            catch (SmtpException smtpEx)
            {
                _log.Warn($"SMTP error sending email to '{userProfile.Email}'", smtpEx);
                throw new InvalidOperationException("Could not send verification email due to a mail server error.", smtpEx);
            }
            catch (TimeoutException timeoutEx)
            {
                _log.Warn($"Timeout sending email to '{userProfile.Email}'", timeoutEx);
                throw new InvalidOperationException("The email service timed out.", timeoutEx);
            }
            catch (Exception ex)
            {
                // JUSTIFICACIÓN: Errores de red impredecibles o fallos internos de la librería de correo
                // que no derivan de SmtpException (ej. SocketException encapsulada).
                _log.Error($"Unexpected error sending email to '{userProfile.Email}'", ex);
                throw new InvalidOperationException("Could not send verification email. Please try again later.", ex);
            }

            var newPlayer = new Player
            {
                username = userProfile.Username,
                email = userProfile.Email,
                password = PasswordHasher.HashPassword(password),
                name = userProfile.FirstName,
                lastName = userProfile.LastName,
                Gender_idGender = userProfile.GenderId,
                Avatar_idAvatar = userProfile.AvatarId > 0 ? userProfile.AvatarId : 1,
                UserStatus_idUserStatus = StatusOffline,
                is_verified = (byte)0,
                verification_code = verificationCode,
                code_expiry_date = DateTime.UtcNow.AddMinutes(15)
            };

            _context.Player.Add(newPlayer);

            try
            {
                await _context.SaveChangesAsync();
                _log.Info($"New user registered successfully: '{userProfile.Username}'.");
            }
            catch (DbUpdateException dbEx)
            {
                _log.Warn($"Database error registering user '{userProfile.Username}'", dbEx);
                throw new InvalidOperationException("Error saving the user to the database.", dbEx);
            }
            catch (DbEntityValidationException valEx)
            {
                _log.Warn($"Data validation error registering user '{userProfile.Username}'", valEx);
                throw new ArgumentException("Provided data does not match database requirements.", valEx);
            }
            return new OperationResultDto { Success = true, Message = "Registration successful. A verification code has been sent to your email." };
        }

        public async Task<OperationResultDto> VerifyAccountAsync(string email, string code)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(code))
            {
                _log.Info("Verification failed: Email or code required.");
                throw new ArgumentException("Email and code are required.");
            }

            var playerToVerify = await _context.Player.FirstOrDefaultAsync(p => p.email == email);

            if (playerToVerify == null)
            {
                _log.Info($"Verification failed: No account found for email '{email}'.");
                throw new InvalidOperationException("No account was found for this email.");
            }

            if (playerToVerify.is_verified == (byte)1)
            {
                _log.Info($"Redundant verification: Account '{playerToVerify.username}' is already verified.");
                throw new InvalidOperationException("This account is already verified.");
            }

            if (playerToVerify.verification_code != code || playerToVerify.code_expiry_date < DateTime.UtcNow)
            {
                _log.Info($"Verification failed for '{playerToVerify.username}': Invalid or expired code.");
                throw new InvalidOperationException("Invalid or expired verification code.");
            }

            playerToVerify.is_verified = (byte)1;
            playerToVerify.verification_code = null;
            playerToVerify.code_expiry_date = null;
            playerToVerify.UserStatus_idUserStatus = 2;

            try
            {
                await _context.SaveChangesAsync();
                _log.Info($"Account verified successfully: '{playerToVerify.username}'.");
            }
            catch (DbUpdateException dbEx)
            {
                _log.Warn($"Database error verifying account '{playerToVerify.username}'", dbEx);
                throw new InvalidOperationException("A database error occurred during verification.", dbEx);
            }

            return new OperationResultDto { Success = true, Message = "Account verified successfully. Welcome!" };
        }

        public void LogOut(string username)
        {
            const int StatusOffline = 1;

            try
            {
                var player = _context.Player.FirstOrDefault(p => p.username == username);
                if (player != null)
                {
                    player.UserStatus_idUserStatus = StatusOffline;
                    _context.SaveChanges();

                    _log.Info($"User '{username}' logged out.");
                }
                else
                {
                    _log.Info($"Logout attempt for unknown user: '{username}'.");
                }
            }
            catch (DbUpdateException dbEx)
            {
                _log.Warn($"Database error processing Logout for user '{username}'", dbEx);
            }
        }
    }
}