using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core; 
using System.Data.Entity.Infrastructure; 
using System.IO;
using System.Linq;
using System.Net.Mail; 
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities;
using GuessMyMessServer.Utilities.Email;
using GuessMyMessServer.Utilities.Email.Templates;
using log4net;

namespace GuessMyMessServer.BusinessLogic
{
    public class UserProfileLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(UserProfileLogic));
        private readonly IEmailService _emailService;
        private readonly GuessMyMessDBEntities _context;
        private static readonly Random _random = new Random();

        public UserProfileLogic(IEmailService emailService, GuessMyMessDBEntities context)
        {
            _emailService = emailService;
            _context = context;
        }

        private string GenerateCode() => _random.Next(100000, 999999).ToString("D6");

        public async Task<UserProfileDto> GetUserProfileAsync(string username)
        {
            try
            {
                var player = await _context.Player
                    .AsNoTracking()
                    .Include(p => p.Gender)
                    .Include(p => p.Avatar)
                    .FirstOrDefaultAsync(p => p.username == username);

                if (player == null)
                {
                    _log.Warn($"GetUserProfile failed: User '{username}' not found.");
                    throw new InvalidOperationException("User not found.");
                }

                return new UserProfileDto
                {
                    Username = player.username,
                    FirstName = player.name,
                    LastName = player.lastName,
                    Email = player.email,
                    GenderId = player.Gender_idGender.GetValueOrDefault(),
                    AvatarId = player.Avatar_idAvatar.GetValueOrDefault()
                };
            }
            catch (EntityException ex)
            {
                _log.Error($"Database connection error retrieving profile for '{username}'.", ex);
                throw;
            }
        }

        public async Task<OperationResultDto> UpdateProfileAsync(string username, UserProfileDto profileData)
        {
            if (profileData == null)
            {
                _log.Warn("UpdateProfile failed: Null profile data received.");
                throw new ArgumentNullException(nameof(profileData), "Invalid profile data.");
            }

            try
            {
                var playerToUpdate = await _context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (playerToUpdate == null)
                {
                    _log.Warn($"UpdateProfile failed: User '{username}' not found in DB.");
                    throw new InvalidOperationException("User not found.");
                }

                playerToUpdate.name = profileData.FirstName;
                playerToUpdate.lastName = profileData.LastName;
                playerToUpdate.Gender_idGender = profileData.GenderId;
                playerToUpdate.Avatar_idAvatar = profileData.AvatarId > 0 ? profileData.AvatarId : playerToUpdate.Avatar_idAvatar;

                await _context.SaveChangesAsync();

                _log.Info($"Profile updated successfully for user '{username}'.");
                return new OperationResultDto { Success = true, Message = "Profile updated successfully." };
            }
            catch (DbUpdateException dbEx)
            {
                _log.Error($"Database error updating profile for '{username}'.", dbEx);
                throw new InvalidOperationException("Could not update profile due to a database error.", dbEx);
            }
        }

        public async Task<List<AvatarDto>> GetAvailableAvatarsAsync()
        {
            var avatarsDtoList = new List<AvatarDto>();
            string basePath = AppDomain.CurrentDomain.BaseDirectory;

            try
            {
                var avatarsFromDb = await _context.Avatar.AsNoTracking().ToListAsync();

                foreach (var avatarRecord in avatarsFromDb)
                {
                    byte[] imageData = null;
                    if (!string.IsNullOrEmpty(avatarRecord.avatarUrl))
                    {
                        string filePath = Path.Combine(basePath, avatarRecord.avatarUrl);

                        if (File.Exists(filePath))
                        {
                            try
                            {
                                using (FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read, bufferSize: 4096, useAsync: true))
                                {
                                    imageData = new byte[stream.Length];
                                    int totalBytesRead = 0;
                                    int bytesRead;
                                    while (totalBytesRead < imageData.Length &&
                                          (bytesRead = await stream.ReadAsync(imageData, totalBytesRead, imageData.Length - totalBytesRead)) > 0)
                                    {
                                        totalBytesRead += bytesRead;
                                    }

                                    if (totalBytesRead != imageData.Length)
                                    {
                                        Array.Resize(ref imageData, totalBytesRead);
                                        _log.Warn($"Read mismatch for avatar {filePath}. Expected {stream.Length}, got {totalBytesRead}.");
                                    }
                                }
                            }
                            catch (IOException ioEx)
                            {
                                _log.Warn($"IO Error reading avatar file '{filePath}'. Skipping.", ioEx);
                                continue; 
                            }
                            catch (UnauthorizedAccessException authEx)
                            {
                                _log.Warn($"Access denied reading avatar file '{filePath}'.", authEx);
                                continue;
                            }
                        }
                        else
                        {
                            _log.Warn($"Avatar file missing at path: {filePath}");
                        }
                    }

                    avatarsDtoList.Add(new AvatarDto
                    {
                        IdAvatar = avatarRecord.idAvatar,
                        AvatarName = avatarRecord.avatarName,
                        AvatarData = imageData
                    });
                }
            }
            catch (EntityException ex)
            {
                _log.Error("Database error retrieving avatar list.", ex);
                throw;
            }
            catch (Exception ex)
            {
                _log.Error("Unexpected error processing avatar list.", ex);
                throw;
            }

            return avatarsDtoList;
        }

        public async Task<OperationResultDto> RequestChangePasswordAsync(string username)
        {
            try
            {
                var player = await _context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null)
                {
                    _log.Warn($"RequestChangePassword failed: User '{username}' not found.");
                    throw new InvalidOperationException("User not found.");
                }

                string code = GenerateCode();
                player.temp_code = code;
                player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10);

                await _context.SaveChangesAsync();

                try
                {
                    var emailTemplate = new PasswordChangeVerificationEmailTemplate(player.username, code);
                    await _emailService.SendEmailAsync(player.email, player.username, emailTemplate);
                    _log.Info($"Password change code sent to user '{username}'.");
                }
                catch (Exception emailEx)
                {
                    _log.Error($"Failed to send password change email to '{player.email}'.", emailEx);
                    throw new InvalidOperationException("Could not send verification email. Please try again later.", emailEx);
                }

                return new OperationResultDto { Success = true, Message = "A verification code has been sent to your registered email." };
            }
            catch (DbUpdateException dbEx)
            {
                _log.Error($"Database error requesting password change for '{username}'.", dbEx);
                throw;
            }
        }

        public async Task<OperationResultDto> RequestChangeEmailAsync(string username, string newEmail)
        {
            if (string.IsNullOrWhiteSpace(newEmail) || !InputValidator.IsValidEmail(newEmail))
            {
                _log.Warn($"RequestChangeEmail failed: Invalid email format '{newEmail}'.");
                throw new ArgumentException("Invalid new email format.", nameof(newEmail));
            }

            try
            {
                var player = await _context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null)
                {
                    _log.Warn($"RequestChangeEmail failed: User '{username}' not found.");
                    throw new InvalidOperationException("User not found.");
                }

                if (await _context.Player.AnyAsync(p => p.email == newEmail))
                {
                    _log.Info($"RequestChangeEmail denied: Email '{newEmail}' is already taken.");
                    throw new InvalidOperationException("The new email is already registered.");
                }

                string code = GenerateCode();
                player.temp_code = code;
                player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10);
                player.new_email_pending = newEmail;

                await _context.SaveChangesAsync();

                try
                {
                    var emailTemplate = new EmailChangeVerificationEmailTemplate(player.username, code);
                    await _emailService.SendEmailAsync(player.email, player.username, emailTemplate);
                    _log.Info($"Email change code sent to '{player.email}' for user '{username}'.");
                }
                catch (Exception emailEx)
                {
                    _log.Error($"Failed to send email change verification to '{player.email}'.", emailEx);
                    throw new InvalidOperationException("Could not send verification email.", emailEx);
                }

                return new OperationResultDto { Success = true, Message = $"A code has been sent to your current email ({player.email}) to confirm." };
            }
            catch (DbUpdateException dbEx)
            {
                _log.Error($"Database error requesting email change for '{username}'.", dbEx);
                throw;
            }
        }

        public async Task<OperationResultDto> ConfirmChangePasswordAsync(string username, string newPassword, string verificationCode)
        {
            if (!InputValidator.IsPasswordSecure(newPassword))
            {
                _log.Warn($"ConfirmChangePassword failed: Password insecure for '{username}'.");
                throw new ArgumentException("The new password does not meet the security requirements.", nameof(newPassword));
            }

            try
            {
                var player = await _context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null)
                {
                    throw new InvalidOperationException("User not found.");
                }

                if (player.temp_code != verificationCode || player.temp_code_expiry < DateTime.UtcNow)
                {
                    _log.Info($"ConfirmChangePassword failed: Invalid/Expired code for '{username}'.");
                    throw new InvalidOperationException("Invalid or expired verification code.");
                }

                player.password = PasswordHasher.HashPassword(newPassword);
                player.temp_code = null;
                player.temp_code_expiry = null;

                await _context.SaveChangesAsync();

                _log.Info($"Password successfully changed for user '{username}'.");
                return new OperationResultDto { Success = true, Message = "Password updated successfully." };
            }
            catch (DbUpdateException dbEx)
            {
                _log.Error($"Database error confirming password change for '{username}'.", dbEx);
                throw;
            }
        }

        public async Task<OperationResultDto> ConfirmChangeEmailAsync(string username, string verificationCode)
        {
            try
            {
                var player = await _context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null)
                {
                    throw new InvalidOperationException("User not found.");
                }

                if (string.IsNullOrEmpty(player.new_email_pending))
                {
                    _log.Warn($"ConfirmChangeEmail failed: No pending email change for '{username}'.");
                    throw new InvalidOperationException("There is no pending email change.");
                }

                if (player.temp_code != verificationCode || player.temp_code_expiry < DateTime.UtcNow)
                {
                    _log.Info($"ConfirmChangeEmail failed: Invalid/Expired code for '{username}'.");
                    throw new InvalidOperationException("Invalid or expired verification code.");
                }

                if (await _context.Player.AnyAsync(p => p.email == player.new_email_pending && p.idPlayer != player.idPlayer))
                {
                    _log.Warn($"ConfirmChangeEmail aborted: Pending email '{player.new_email_pending}' was taken by another user.");

                    player.temp_code = null;
                    player.temp_code_expiry = null;
                    player.new_email_pending = null;
                    await _context.SaveChangesAsync();

                    throw new InvalidOperationException("The new email is already registered by another user.");
                }

                player.email = player.new_email_pending;
                player.temp_code = null;
                player.temp_code_expiry = null;
                player.new_email_pending = null;

                await _context.SaveChangesAsync();

                _log.Info($"Email updated successfully for user '{username}'.");
                return new OperationResultDto { Success = true, Message = "Email updated successfully." };
            }
            catch (DbUpdateException dbEx)
            {
                _log.Error($"Database error confirming email change for '{username}'.", dbEx);
                throw;
            }
        }
    }
}