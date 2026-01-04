using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.DataAccess.Abstractions;
using GuessMyMessServer.Utilities;
using GuessMyMessServer.Utilities.Email;
using GuessMyMessServer.Utilities.Email.Templates;
using log4net;

namespace GuessMyMessServer.BusinessLogic
{
    public class UserProfileLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(UserProfileLogic));
        private static readonly Random _random = new Random();

        private readonly IPlayerRepository _playerRepository;
        private readonly IAvatarRepository _avatarRepository;
        private readonly ISocialNetworkRepository _socialRepository;
        private readonly IEmailService _emailService;

        private const string UserNotFoundMessage = "User not found.";
        private const int CodeLowerLimit = 100000;
        private const int CodeUpperLimit = 999999;

        public UserProfileLogic(
            IPlayerRepository playerRepository,
            IAvatarRepository avatarRepository,
            ISocialNetworkRepository socialRepository,
            IEmailService emailService)
        {
            _playerRepository = playerRepository;
            _avatarRepository = avatarRepository;
            _socialRepository = socialRepository;
            _emailService = emailService;
        }

        private static string GenerateCode() => _random.Next(CodeLowerLimit, CodeUpperLimit).ToString("D6");

        public async Task<UserProfileDto> GetUserProfileAsync(string username)
        {
            try
            {
                var player = await _playerRepository.GetPlayerProfileDataAsync(username);

                if (player == null)
                {
                    _log.WarnFormat("GetUserProfile failed: User '{0}' not found.", username);
                    ThrowServiceFault(ServiceErrorType.NotFound, UserNotFoundMessage);
                }

                var socialNetworksList = player.SocialNetwork.Select(sn => new SocialNetworkDto
                {
                    NetworkType = sn.TypeSocialNetwork.type,
                    UserLink = sn.userLink
                }).ToList();

                return new UserProfileDto
                {
                    Username = player.username,
                    FirstName = player.name,
                    LastName = player.lastName,
                    Email = player.email,
                    GenderId = player.Gender_idGender.GetValueOrDefault(),
                    AvatarId = player.Avatar_idAvatar.GetValueOrDefault(),
                    socialNetworks = socialNetworksList
                };
            }
            catch (Exception ex) when (!(ex is FaultException<ServiceFaultDto>))
            {
                _log.Error($"Error retrieving profile for '{username}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not retrieve user profile.");
                return null;
            }
        }

        public async Task<OperationResultDto> UpdateProfileAsync(string username, UserProfileDto profileData)
        {
            if (profileData == null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.OperationFailed, Message = "Invalid data"
                };
            }

            if (profileData.AvatarId > 0)
            {
                var avatar = await _avatarRepository.GetAvatarByIdAsync(profileData.AvatarId);
                if (avatar == null)
                {
                    return new OperationResultDto
                    {
                        Success = false, ErrorCode = ServiceErrorType.NotFound, Message = "Avatar not found"
                    };
                }
            }

            var playerToUpdate = await _playerRepository.GetPlayerByUsernameAsync(username);

            if (playerToUpdate == null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.NotFound, Message = UserNotFoundMessage
                };
            }

            playerToUpdate.name = profileData.FirstName;
            playerToUpdate.lastName = profileData.LastName;
            playerToUpdate.Gender_idGender = profileData.GenderId;

            if (profileData.AvatarId > 0)
            {
                playerToUpdate.Avatar_idAvatar = profileData.AvatarId;
            }

            try
            {
                await _playerRepository.SaveChangesAsync();
                _log.InfoFormat("Profile updated successfully for user '{0}'.", username);
                return new OperationResultDto
                {
                    Success = true, ErrorCode = ServiceErrorType.None, Message = "Profile updated successfully."
                };
            }
            catch (Exception ex)
            {
                _log.Error($"Database error updating profile for '{username}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not update profile.");
                return null;
            }
        }

        public async Task<OperationResultDto> AddOrUpdateSocialNetworkAsync(string username, SocialNetworkDto socialNetworkDto)
        {
            if (socialNetworkDto == null || string.IsNullOrWhiteSpace(socialNetworkDto.UserLink))
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.OperationFailed, Message = "Invalid data"
                };
            }

            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (player == null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.NotFound, Message = UserNotFoundMessage
                };
            }

            var networkType = await _socialRepository.GetTypeByNameAsync(socialNetworkDto.NetworkType);
            if (networkType == null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.OperationFailed, Message = "Invalid Network Type"
                };
            }

            var existingSocial = await _socialRepository.GetPlayerSocialNetworkAsync(player.idPlayer, networkType.idTypeSocialNetwork);

            if (existingSocial != null)
            {
                existingSocial.userLink = socialNetworkDto.UserLink.Trim();
            }
            else
            {
                var newSocial = new SocialNetwork
                {
                    Player_idPlayer = player.idPlayer,
                    TypeSocialNetwork_idTypeSocialNetwork = networkType.idTypeSocialNetwork,
                    userLink = socialNetworkDto.UserLink.Trim()
                };
                _socialRepository.AddSocialNetwork(newSocial);
            }

            try
            {
                await _socialRepository.SaveChangesAsync();
                return new OperationResultDto
                {
                    Success = true, ErrorCode = ServiceErrorType.None, Message = "Social profile updated."
                };
            }
            catch (Exception ex)
            {
                _log.Error($"Error saving social network for '{username}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not save social network.");
                return null;
            }
        }

        public async Task<List<AvatarDto>> GetAvailableAvatarsAsync()
        {
            var avatarsDtoList = new List<AvatarDto>();
            string basePath = AppDomain.CurrentDomain.BaseDirectory;

            try
            {
                var avatarsFromDb = await _avatarRepository.GetAllAvatarsAsync();

                foreach (var avatarRecord in avatarsFromDb)
                {
                    byte[] imageData = null;
                    if (!string.IsNullOrEmpty(avatarRecord.avatarUrl))
                    {
                        string filePath = Path.Combine(basePath, avatarRecord.avatarUrl);
                        imageData = await ReadFileAsync(filePath);
                    }

                    avatarsDtoList.Add(new AvatarDto
                    {
                        IdAvatar = avatarRecord.idAvatar,
                        AvatarName = avatarRecord.avatarName,
                        AvatarData = imageData
                    });
                }
            }
            catch (Exception ex)
            {
                _log.Error("Error retrieving avatar list.", ex);
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Could not retrieve avatars.");
            }

            return avatarsDtoList;
        }

        public async Task<OperationResultDto> RequestChangePasswordAsync(string username)
        {
            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (player == null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.NotFound, Message = UserNotFoundMessage
                };
            }

            string code = GenerateCode();
            player.temp_code = code;
            player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10);

            try
            {
                await _playerRepository.SaveChangesAsync();

                var emailTemplate = new PasswordChangeVerificationEmailTemplate(player.username, code);
                await _emailService.SendEmailAsync(player.email, player.username, emailTemplate);

                return new OperationResultDto
                {
                    Success = true, ErrorCode = ServiceErrorType.None, Message = "Verification code sent."
                };
            }
            catch (Exception ex)
            {
                _log.Error($"Error in RequestChangePassword for '{username}'.", ex);
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Could not process request.");
                return null;
            }
        }

        public async Task<OperationResultDto> ConfirmChangePasswordAsync(string username, string newPassword, string verificationCode)
        {
            if (!InputValidator.IsPasswordSecure(newPassword))
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.InvalidPasswordFormat, Message = "Insecure password"
                };
            }

            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (player == null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.NotFound, Message = UserNotFoundMessage
                };
            }

            if (player.temp_code != verificationCode || player.temp_code_expiry < DateTime.UtcNow)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.InvalidCredentials, Message = "Invalid code"
                };
            }

            player.password = PasswordHasher.HashPassword(newPassword);
            player.temp_code = null;
            player.temp_code_expiry = null;

            try
            {
                await _playerRepository.SaveChangesAsync();
                return new OperationResultDto
                {
                    Success = true, ErrorCode = ServiceErrorType.None, Message = "Password updated successfully."
                };
            }
            catch (Exception ex)
            {
                _log.Error($"Database error changing password for '{username}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not update password.");
                return null;
            }
        }

        public async Task<OperationResultDto> RequestChangeEmailAsync(string username, string newEmail)
        {
            if (!InputValidator.IsValidEmail(newEmail))
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.InvalidEmailFormat, Message = "Invalid email"
                };
            }

            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (player == null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.NotFound, Message = UserNotFoundMessage
                };
            }

            var existingUser = await _playerRepository.GetPlayerByEmailAsync(newEmail);
            if (existingUser != null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.EmailAlreadyRegistered, Message = "Email exists"
                };
            }

            string code = GenerateCode();
            player.temp_code = code;
            player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10);
            player.new_email_pending = newEmail;

            try
            {
                await _playerRepository.SaveChangesAsync();

                var emailTemplate = new EmailChangeVerificationEmailTemplate(player.username, code);
                await _emailService.SendEmailAsync(player.email, player.username, emailTemplate);

                return new OperationResultDto
                {
                    Success = true, ErrorCode = ServiceErrorType.None, Message = "Verification code sent."
                };
            }
            catch (Exception ex)
            {
                _log.Error($"Error requesting email change for '{username}'.", ex);
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Could not process request.");
                return null;
            }
        }

        public async Task<OperationResultDto> ConfirmChangeEmailAsync(string username, string verificationCode)
        {
            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (player == null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.NotFound, Message = UserNotFoundMessage
                };
            }

            if (string.IsNullOrEmpty(player.new_email_pending))
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.OperationFailed, Message = "No pending request"
                };
            }

            if (player.temp_code != verificationCode || player.temp_code_expiry < DateTime.UtcNow)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.InvalidCredentials, Message = "Invalid code"
                };
            }

            var collisionUser = await _playerRepository.GetPlayerByEmailAsync(player.new_email_pending);
            if (collisionUser != null && collisionUser.idPlayer != player.idPlayer)
            {
                player.temp_code = null;
                player.new_email_pending = null;
                try
                {
                    await _playerRepository.SaveChangesAsync();
                }
                catch (Exception ex)
                {
                    _log.Warn("Error clearing pending email after collision", ex);
                }

                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.EmailAlreadyRegistered, Message = "Email taken"
                };
            }

            player.email = player.new_email_pending;
            player.temp_code = null;
            player.temp_code_expiry = null;
            player.new_email_pending = null;

            try
            {
                await _playerRepository.SaveChangesAsync();
                return new OperationResultDto
                {
                    Success = true, ErrorCode = ServiceErrorType.None, Message = "Email updated successfully."
                };
            }
            catch (Exception ex)
            {
                _log.Error($"Error confirming email change for '{username}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not update email.");
                return null;
            }
        }

        public async Task<List<PlayerScoreDto>> GetGlobalRankingAsync()
        {
            try
            {
                return await _playerRepository.GetGlobalRankingAsync();
            }
            catch (Exception ex)
            {
                _log.Error("Error generating global ranking.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not retrieve global ranking.");
                return null;
            }
        }

        private static async Task<byte[]> ReadFileAsync(string filePath)
        {
            if (!File.Exists(filePath))
            {
                return null;
            }

            try
            {
                using (FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read, 4096, true))
                {
                    byte[] buffer = new byte[stream.Length];
                    int totalBytesRead = 0;
                    int bytesRead;

                    while (totalBytesRead < buffer.Length &&
                           (bytesRead = await stream.ReadAsync(buffer, totalBytesRead, buffer.Length - totalBytesRead)) > 0)
                    {
                        totalBytesRead += bytesRead;
                    }

                    return totalBytesRead == buffer.Length ? buffer : null;
                }
            }
            catch (Exception ex)
            {
                _log.WarnFormat("Error reading file {0}. Exception: {1}", filePath, ex.Message);
                return null;
            }
        }

        private static void ThrowServiceFault(ServiceErrorType type, string message)
        {
            var fault = new ServiceFaultDto(type, message);
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason(message));
        }
    }
}