using System;
using System.Collections.Generic;
using System.ServiceModel; 
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess; 
using GuessMyMessServer.DataAccess.Abstractions; 
using GuessMyMessServer.Utilities;
using GuessMyMessServer.Utilities.Email;
using log4net;

namespace GuessMyMessServer.BusinessLogic
{
    public class AuthenticationLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(AuthenticationLogic));
        private static readonly Random _random = new Random();

        private readonly IPlayerRepository _playerRepository;
        private readonly IMatchRepository _matchRepository; 
        private readonly IEmailService _emailService;

        public AuthenticationLogic(
            IPlayerRepository playerRepository,
            IMatchRepository matchRepository,
            IEmailService emailService)
        {
            _playerRepository = playerRepository;
            _matchRepository = matchRepository;
            _emailService = emailService;
        }

        public async Task<OperationResultDto> LoginAsync(string emailOrUsername, string password)
        {
            if (string.IsNullOrWhiteSpace(emailOrUsername) || string.IsNullOrWhiteSpace(password))
            {
                ThrowServiceFault(ServiceErrorType.InvalidCredentials, "Username/Email and password are required.");
            }

            Player player;
            if (InputValidator.IsValidEmail(emailOrUsername))
            {
                player = await _playerRepository.GetPlayerByEmailAsync(emailOrUsername);
            }
            else
            {
                player = await _playerRepository.GetPlayerByUsernameAsync(emailOrUsername);
            }

            if (player == null)
            {
                _log.Info($"Failed login attempt: User '{emailOrUsername}' not found.");
                ThrowServiceFault(ServiceErrorType.InvalidCredentials, "Incorrect credentials.");
            }

            if (player.is_verified == 0)
            {
                _log.Info($"Login denied: User '{player.username}' account is not verified.");
                ThrowServiceFault(ServiceErrorType.AccountNotVerified, "The account has not been verified.");
            }

            if (!PasswordHasher.VerifyPassword(password, player.password))
            {
                _log.Info($"Failed login attempt: Incorrect credentials for user '{player.username}'.");
                ThrowServiceFault(ServiceErrorType.InvalidCredentials, "Incorrect credentials.");
            }

            const int StatusOnline = 2;
            player.UserStatus_idUserStatus = StatusOnline;

            try
            {
                await _playerRepository.SaveChangesAsync();
                _log.Info($"User '{player.username}' logged in successfully.");
                return new OperationResultDto { Success = true, Message = player.username };
            }
            catch (Exception ex)
            {
                _log.Error($"Database error updating status for user '{player.username}'", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "An error occurred while logging in.");
                return null; 
            }
        }

        public async Task<OperationResultDto> RegisterPlayerAsync(UserProfileDto userProfile, string password)
        {
            ValidateRegistrationInput(userProfile, password);
            await CheckUserExistenceAsync(userProfile);

            string verificationCode = _random.Next(100000, 999999).ToString("D6");

            await SendVerificationEmailAsync(userProfile, verificationCode);

            return await CreateAndSavePlayerAsync(userProfile, password, verificationCode);
        }

        public async Task<OperationResultDto> VerifyAccountAsync(string email, string code)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(code))
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Email and code are required.");
            }

            var player = await _playerRepository.GetPlayerByEmailAsync(email);

            if (player == null)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "No account was found for this email.");
            }

            if (player.is_verified == 1)
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "This account is already verified.");
            }

            if (player.verification_code != code || player.code_expiry_date < DateTime.UtcNow)
            {
                ThrowServiceFault(ServiceErrorType.InvalidCredentials, "Invalid or expired verification code.");
            }

            player.is_verified = 1;
            player.verification_code = null;
            player.code_expiry_date = null;
            player.UserStatus_idUserStatus = 2; 

            try
            {
                await _playerRepository.SaveChangesAsync();
                _log.Info($"Account verified successfully: '{player.username}'.");
                return new OperationResultDto { Success = true, Message = "Account verified successfully. Welcome!" };
            }
            catch (Exception ex)
            {
                _log.Error($"Database error verifying account '{player.username}'", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Error updating verification status.");
                return null;
            }
        }

        public async Task<OperationResultDto> LoginAsGuestAsync(string email, string code)
        {
            if (GuestInviteManager.ValidateInvite(email, code, out string matchIdStr))
            {
                string uniqueSessionId = $"Guest_{Guid.NewGuid().ToString().Substring(0, 8)}";
                bool isPrivate = false;

                if (int.TryParse(matchIdStr, out int matchId))
                {
                    isPrivate = await _matchRepository.IsMatchPrivateAsync(matchId);
                }

                return new OperationResultDto
                {
                    Success = true,
                    Message = uniqueSessionId,
                    Data = new Dictionary<string, string>
                    {
                        { "MatchId", matchIdStr },
                        { "IsGuest", "true" },
                        { "IsPrivate", isPrivate.ToString() }
                    }
                };
            }
            else
            {
                ThrowServiceFault(ServiceErrorType.InvalidCredentials, "Invalid invitation code or email.");
                return null;
            }
        }

        public async Task LogOutAsync(string username)
        {
            const int StatusOffline = 1;
            try
            {
                var player = await _playerRepository.GetPlayerByUsernameAsync(username);
                if (player != null)
                {
                    player.UserStatus_idUserStatus = StatusOffline;
                    await _playerRepository.SaveChangesAsync();
                    _log.Info($"User '{username}' logged out.");
                }
            }
            catch (Exception ex)
            {
                _log.Warn($"Error processing Logout for user '{username}'", ex);
            }
        }

        private void ValidateRegistrationInput(UserProfileDto userProfile, string password)
        {
            if (userProfile == null || string.IsNullOrWhiteSpace(password))
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "User profile and password are required.");
            }

            if (string.IsNullOrWhiteSpace(userProfile.Username) ||
                string.IsNullOrWhiteSpace(userProfile.Email) ||
                string.IsNullOrWhiteSpace(userProfile.FirstName) ||
                string.IsNullOrWhiteSpace(userProfile.LastName))
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "All fields are required.");
            }

            if (!InputValidator.IsValidEmail(userProfile.Email))
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Invalid email format.");
            }

            if (!InputValidator.IsPasswordSecure(password))
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Password does not meet security requirements.");
            }
        }

        private async Task CheckUserExistenceAsync(UserProfileDto userProfile)
        {
            var existingUser = await _playerRepository.GetPlayerByUsernameAsync(userProfile.Username);
            if (existingUser != null)
            {
                ThrowServiceFault(ServiceErrorType.UserAlreadyExists, "The username is already in use.");
            }

            var existingEmail = await _playerRepository.GetPlayerByEmailAsync(userProfile.Email);
            if (existingEmail != null)
            {
                ThrowServiceFault(ServiceErrorType.EmailAlreadyRegistered, "The email is already registered.");
            }
        }

        private async Task SendVerificationEmailAsync(UserProfileDto userProfile, string code)
        {
            try
            {
                var emailTemplate = new VerificationEmailTemplate(userProfile.Username, code);
                await _emailService.SendEmailAsync(userProfile.Email, userProfile.Username, emailTemplate);
            }
            catch (Exception ex)
            {
                _log.Error($"Error sending email to '{userProfile.Email}'", ex);
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Could not send verification email. Please try again later.");
            }
        }

        private async Task<OperationResultDto> CreateAndSavePlayerAsync(UserProfileDto userProfile, string password, string code)
        {
            const int StatusOffline = 1;
            const int EmailCodeTimeExpiration = 15;

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
                is_verified = 0,
                verification_code = code,
                code_expiry_date = DateTime.UtcNow.AddMinutes(EmailCodeTimeExpiration)
            };

            _playerRepository.AddPlayer(newPlayer);

            try
            {
                await _playerRepository.SaveChangesAsync();
                _log.Info($"New user registered: '{userProfile.Username}'.");
                return new OperationResultDto
                {
                    Success = true,
                    Message = "Registration successful."
                };
            }
            catch (Exception ex)
            {
                _log.Error($"Database error saving user '{userProfile.Username}'", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Error registering user in database.");
                return null;
            }
        }

        private void ThrowServiceFault(ServiceErrorType type, string message)
        {
            var fault = new ServiceFaultDto(type, message);
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason(message));
        }
    }
}