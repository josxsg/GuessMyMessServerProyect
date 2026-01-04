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
        private int StatusOffline = 1;

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
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.InvalidCredentials, Message = "Empty credentials"
                };
            }

            Player player;
            try
            {
                if (InputValidator.IsValidEmail(emailOrUsername))
                {
                    player = await _playerRepository.GetPlayerByEmailAsync(emailOrUsername);
                }
                else
                {
                    player = await _playerRepository.GetPlayerByUsernameAsync(emailOrUsername);
                }
            }
            catch (Exception ex)
            {
                _log.Error("Database error during Login fetch", ex);
                ThrowSystemError(ServiceErrorType.DatabaseError, "Error fetching user data");
                return null;
            }

            if (player == null)
            {
                _log.InfoFormat("Failed login: User '{0}' not found.", emailOrUsername);
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.InvalidCredentials, Message = "User not found"
                };
            }

            if (player.is_verified == 0)
            {
                _log.InfoFormat("Login denied: User '{0}' account not verified.", player.username);
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.AccountNotVerified, Message = "Account not verified"
                };
            }

            if (!PasswordHasher.VerifyPassword(password, player.password))
            {
                _log.InfoFormat("Failed login: Incorrect password for '{0}'.", player.username);
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.InvalidCredentials, Message = "Wrong password"
                };
            }

            const int StatusOnline = 2;
            const int StatusInGame = 3;

            if (player.UserStatus_idUserStatus == StatusOnline || player.UserStatus_idUserStatus == StatusInGame)
            {
                _log.WarnFormat("Login denied: User '{0}' is already logged in.", player.username);
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.OperationFailed, Message = "UserAlreadyLoggedIn"
                };
            }

            player.UserStatus_idUserStatus = StatusOnline;

            try
            {
                await _playerRepository.SaveChangesAsync();
                _log.InfoFormat("User '{0}' logged in successfully.", player.username);

                return new OperationResultDto
                {
                    Success = true,
                    ErrorCode = ServiceErrorType.None,
                    Message = player.username 
                };
            }
            catch (Exception ex)
            {
                _log.Error($"Database error updating status for '{player.username}'", ex);
                ThrowSystemError(ServiceErrorType.DatabaseError, "Error logging in");
                return null;
            }
        }

        public async Task<OperationResultDto> RegisterPlayerAsync(UserProfileDto userProfile, string password)
        {
            const int CodeLowerLimit = 100000;
            const int CodeUpperLimit = 999999;
            var validationResult = ValidateRegistrationInput(userProfile, password);
            if (validationResult != ServiceErrorType.None)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = validationResult, Message = "Validation Failed"
                };
            }

            var existenceCheck = await CheckUserExistenceAsync(userProfile);
            if (existenceCheck != ServiceErrorType.None)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = existenceCheck, Message = "User/Email exists"
                };
            }

            string verificationCode = _random.Next(CodeLowerLimit, CodeUpperLimit).ToString("D6");

            try
            {
                var emailTemplate = new VerificationEmailTemplate(userProfile.Username, verificationCode);
                await _emailService.SendEmailAsync(userProfile.Email, userProfile.Username, emailTemplate);
            }
            catch (Exception ex)
            {
                _log.Error($"Error sending email to '{userProfile.Email}'", ex);
                ThrowSystemError(ServiceErrorType.OperationFailed, "Could not send verification email");
            }

            return await CreateAndSavePlayerAsync(userProfile, password, verificationCode);
        }

        public async Task<OperationResultDto> VerifyAccountAsync(string email, string code)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(code))
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.OperationFailed, Message = "Missing data"
                };
            }

            Player player = await _playerRepository.GetPlayerByEmailAsync(email);

            if (player == null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.NotFound, Message = "Email not found"
                };
            }

            if (player.is_verified == 1)
            {
                return new OperationResultDto
                {
                    Success = true, ErrorCode = ServiceErrorType.None, Message = "Already verified"
                };
            }

            if (player.verification_code != code || player.code_expiry_date < DateTime.UtcNow)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.InvalidCredentials, Message = "Invalid/Expired Code"
                };
            }

            player.is_verified = 1;
            player.verification_code = null;
            player.code_expiry_date = null;
            player.UserStatus_idUserStatus = 2; 

            try
            {
                await _playerRepository.SaveChangesAsync();
                _log.InfoFormat("Account verified: '{0}'.", player.username);
                return new OperationResultDto { Success = true, ErrorCode = ServiceErrorType.None, Message = "Verified" };
            }
            catch (Exception ex)
            {
                _log.Error($"Database error verifying '{player.username}'", ex);
                ThrowSystemError(ServiceErrorType.DatabaseError, "DB update failed");
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
                    try
                    {
                        isPrivate = await _matchRepository.IsMatchPrivateAsync(matchId);
                    }
                    catch (Exception ex)
                    {
                        _log.Error("DB Error checking match privacy", ex);
                        ThrowSystemError(ServiceErrorType.DatabaseError, "Check match failed");
                    }
                }

                return new OperationResultDto
                {
                    Success = true,
                    ErrorCode = ServiceErrorType.None,
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
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.InvalidCredentials, Message = "Invalid Guest Invite"
                };
            }
        }

        public async Task LogOutAsync(string username)
        {
            try
            {
                var player = await _playerRepository.GetPlayerByUsernameAsync(username);
                if (player != null)
                {
                    player.UserStatus_idUserStatus = StatusOffline;
                    await _playerRepository.SaveChangesAsync();
                    _log.InfoFormat("User '{0}' logged out.", username);
                }
            }
            catch (Exception ex)
            {
                _log.Warn($"Error processing Logout for user '{username}'", ex);
            }
        }

        private ServiceErrorType ValidateRegistrationInput(UserProfileDto userProfile, string password)
        {
            if (userProfile == null || string.IsNullOrWhiteSpace(password))
            {
                return ServiceErrorType.OperationFailed;
            }

            if (string.IsNullOrWhiteSpace(userProfile.Username))
            {
                return ServiceErrorType.OperationFailed;
            }

            if (!InputValidator.IsValidEmail(userProfile.Email))
            {
                return ServiceErrorType.InvalidEmailFormat;
            }

            if (!InputValidator.IsPasswordSecure(password))
            {
                return ServiceErrorType.InvalidPasswordFormat;
            }

            return ServiceErrorType.None;
        }

        private async Task<ServiceErrorType> CheckUserExistenceAsync(UserProfileDto userProfile)
        {
            try
            {
                var existingUser = await _playerRepository.GetPlayerByUsernameAsync(userProfile.Username);
                if (existingUser != null)
                {
                    return ServiceErrorType.UserAlreadyExists;
                }

                var existingEmail = await _playerRepository.GetPlayerByEmailAsync(userProfile.Email);
                if (existingEmail != null)
                {
                    return ServiceErrorType.EmailAlreadyRegistered;
                }

                return ServiceErrorType.None;
            }
            catch (Exception ex)
            {
                _log.Error("Database error checking existence", ex);
                ThrowSystemError(ServiceErrorType.DatabaseError, "Checking user failed");
                return ServiceErrorType.DatabaseError;
            }
        }

        private async Task<OperationResultDto> CreateAndSavePlayerAsync(UserProfileDto userProfile, string password, string code)
        {
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

            try
            {
                _playerRepository.AddPlayer(newPlayer);
                await _playerRepository.SaveChangesAsync();

                _log.InfoFormat("New user registered: '{0}'.", userProfile.Username);
                return new OperationResultDto
                {
                    Success = true,
                    ErrorCode = ServiceErrorType.None,
                    Message = "Registration successful."
                };
            }
            catch (Exception ex)
            {
                _log.Error($"Database error saving user '{userProfile.Username}'", ex);
                ThrowSystemError(ServiceErrorType.DatabaseError, "Save failed");
                return null;
            }
        }

        private static void ThrowSystemError(ServiceErrorType type, string debugMessage)
        {
            var fault = new ServiceFaultDto(type, debugMessage);
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason("Server Error"));
        }
    }
}