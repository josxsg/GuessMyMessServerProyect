using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities;
using GuessMyMessServer.Utilities.Email;

namespace GuessMyMessServer.BusinessLogic
{
    public class AuthenticationLogic
    {
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
                throw new ArgumentException("Username/Email and password are required.");
            }

            const int StatusOnline = 2;

            var player = await _context.Player.FirstOrDefaultAsync(p =>
                p.username == emailOrUsername || p.email == emailOrUsername);

            if (player == null)
            {
                throw new InvalidOperationException("Incorrect credentials.");
            }

            if (player.is_verified == (byte)0)
            {
                throw new InvalidOperationException("The account has not been verified. Please, check your email.");
            }

            if (!PasswordHasher.VerifyPassword(password, player.password))
            {
                throw new InvalidOperationException("Incorrect credentials.");
            }

            player.UserStatus_idUserStatus = StatusOnline;
            await _context.SaveChangesAsync();

            return new OperationResultDto { Success = true, Message = player.username };
        }

        public async Task<OperationResultDto> RegisterPlayerAsync(UserProfileDto userProfile, string password)
        {
            if (userProfile == null || string.IsNullOrWhiteSpace(password))
            {
                throw new ArgumentNullException(nameof(userProfile), "User profile and password are required.");
            }

            if (string.IsNullOrWhiteSpace(userProfile.Username) ||
                string.IsNullOrWhiteSpace(userProfile.Email) ||
                string.IsNullOrWhiteSpace(userProfile.FirstName) ||
                string.IsNullOrWhiteSpace(userProfile.LastName))
            {
                throw new ArgumentException("All fields (Username, First Name, Last Name, Email) are required.");
            }

            if (!InputValidator.IsValidEmail(userProfile.Email))
            {
                throw new ArgumentException("The email format is not valid. (Ex: user@domain.com)");
            }

            if (!InputValidator.IsPasswordSecure(password))
            {
                throw new ArgumentException("The password does not meet the security requirements.");
            }

            const int StatusOffline = 1;
            string verificationCode = _random.Next(100000, 999999).ToString("D6");

            if (await _context.Player.AnyAsync(p => p.username == userProfile.Username))
            {
                throw new InvalidOperationException("The username is already in use.");
            }
            if (await _context.Player.AnyAsync(p => p.email == userProfile.Email))
            {
                throw new InvalidOperationException("The email is already registered.");
            }

            try
            {
                var emailTemplate = new VerificationEmailTemplate(userProfile.Username, verificationCode);
                await _emailService.SendEmailAsync(userProfile.Email, userProfile.Username, emailTemplate);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"\nEMAIL SENDING ERROR!: {ex.Message}");
                throw new InvalidOperationException("Could not send verification email. Please check if the email is correct.", ex);
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
            }
            catch (DbUpdateException dbEx)
            {
                Console.WriteLine($"DATABASE ERROR: {dbEx.InnerException?.Message ?? dbEx.Message}");
                throw new InvalidOperationException("Error saving the user. Please verify the provided data.", dbEx);
            }

            return new OperationResultDto { Success = true, Message = "Registration successful. A verification code has been sent to your email." };
        }
        public async Task<OperationResultDto> VerifyAccountAsync(string email, string code)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(code))
            {
                throw new ArgumentException("Email and code are required.");
            }

            var playerToVerify = await _context.Player.FirstOrDefaultAsync(p => p.email == email);

            if (playerToVerify == null)
            {
                throw new InvalidOperationException("No account was found for this email.");
            }

            if (playerToVerify.is_verified == (byte)1)
            {
                throw new InvalidOperationException("This account is already verified.");
            }

            if (playerToVerify.verification_code != code || playerToVerify.code_expiry_date < DateTime.UtcNow)
            {
                throw new InvalidOperationException("Invalid or expired verification code.");
            }

            playerToVerify.is_verified = (byte)1;
            playerToVerify.verification_code = null;
            playerToVerify.code_expiry_date = null;
            playerToVerify.UserStatus_idUserStatus = 2;

            await _context.SaveChangesAsync();

            return new OperationResultDto { Success = true, Message = "Account verified successfully. Welcome!" };
        }
        public void LogOut(string username)
        {
            const int StatusOffline = 1;

            var player = _context.Player.FirstOrDefault(p => p.username == username);
            if (player != null)
            {
                player.UserStatus_idUserStatus = StatusOffline;
                _context.SaveChanges();
            }
        }
    }
}