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

        private string GenerateCode() => _random.Next(100000, 999999).ToString("D6");

        public async Task<UserProfileDto> GetUserProfileAsync(string username)
        {
            try
            {
                var player = await _playerRepository.GetPlayerProfileDataAsync(username);

                if (player == null)
                {
                    _log.Warn($"GetUserProfile failed: User '{username}' not found.");
                    ThrowServiceFault(ServiceErrorType.NotFound, "User not found.");
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
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Invalid profile data.");
            }

            if (profileData.AvatarId > 0)
            {
                var avatar = await _avatarRepository.GetAvatarByIdAsync(profileData.AvatarId);
                if (avatar == null)
                {
                    ThrowServiceFault(ServiceErrorType.OperationFailed, "Selected avatar does not exist.");
                }
            }

            var playerToUpdate = await _playerRepository.GetPlayerByUsernameAsync(username);

            if (playerToUpdate == null)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "User not found.");
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
                _log.Info($"Profile updated successfully for user '{username}'.");
                return new OperationResultDto { Success = true, Message = "Profile updated successfully." };
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
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Invalid social network data.");
            }

            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (player == null)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "User not found.");
            }

            var networkType = await _socialRepository.GetTypeByNameAsync(socialNetworkDto.NetworkType);
            if (networkType == null)
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, $"Invalid social network type: {socialNetworkDto.NetworkType}");
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
                return new OperationResultDto { Success = true, Message = "Social profile updated." };
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
                ThrowServiceFault(ServiceErrorType.NotFound, "User not found.");
            }

            string code = GenerateCode();
            player.temp_code = code;
            player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10);

            try
            {
                await _playerRepository.SaveChangesAsync();

                var emailTemplate = new PasswordChangeVerificationEmailTemplate(player.username, code);
                await _emailService.SendEmailAsync(player.email, player.username, emailTemplate);

                return new OperationResultDto { Success = true, Message = "Verification code sent." };
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
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Password does not meet security requirements.");
            }

            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (player == null)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "User not found.");
            }

            if (player.temp_code != verificationCode || player.temp_code_expiry < DateTime.UtcNow)
            {
                ThrowServiceFault(ServiceErrorType.InvalidCredentials, "Invalid or expired code.");
            }

            player.password = PasswordHasher.HashPassword(newPassword);
            player.temp_code = null;
            player.temp_code_expiry = null;

            try
            {
                await _playerRepository.SaveChangesAsync();
                return new OperationResultDto { Success = true, Message = "Password updated successfully." };
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
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Invalid email format.");
            }

            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (player == null)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "User not found.");
            }

            var existingUser = await _playerRepository.GetPlayerByEmailAsync(newEmail);
            if (existingUser != null)
            {
                ThrowServiceFault(ServiceErrorType.EmailAlreadyRegistered, "The email is already registered.");
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

                return new OperationResultDto { Success = true, Message = "Verification code sent to your current email." };
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
                ThrowServiceFault(ServiceErrorType.NotFound, "User not found.");
            }

            if (string.IsNullOrEmpty(player.new_email_pending))
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "No pending email change request.");
            }

            if (player.temp_code != verificationCode || player.temp_code_expiry < DateTime.UtcNow)
            {
                ThrowServiceFault(ServiceErrorType.InvalidCredentials, "Invalid or expired code.");
            }

            var collisionUser = await _playerRepository.GetPlayerByEmailAsync(player.new_email_pending);
            if (collisionUser != null && collisionUser.idPlayer != player.idPlayer)
            {
                player.temp_code = null;
                player.new_email_pending = null;
                await _playerRepository.SaveChangesAsync();

                ThrowServiceFault(ServiceErrorType.EmailAlreadyRegistered, "Email already taken by another user.");
            }

            player.email = player.new_email_pending;
            player.temp_code = null;
            player.temp_code_expiry = null;
            player.new_email_pending = null;

            try
            {
                await _playerRepository.SaveChangesAsync();
                return new OperationResultDto { Success = true, Message = "Email updated successfully." };
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

        private async Task<byte[]> ReadFileAsync(string filePath)
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
                    await stream.ReadAsync(buffer, 0, buffer.Length);
                    return buffer;
                }
            }
            catch (Exception ex)
            {
                _log.Warn($"Error reading file {filePath}", ex);
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
