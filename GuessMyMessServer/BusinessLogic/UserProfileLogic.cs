using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities;
using GuessMyMessServer.Utilities.Email;
using GuessMyMessServer.Utilities.Email.Templates;

namespace GuessMyMessServer.BusinessLogic
{
    public class UserProfileLogic
    {
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
            var player = await _context.Player
                .AsNoTracking()
                .Include(p => p.Gender)
                .Include(p => p.Avatar)
                .FirstOrDefaultAsync(p => p.username == username);

            if (player == null)
            {
                throw new Exception("Usuario no encontrado.");
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

        public async Task<OperationResultDto> UpdateProfileAsync(string username, UserProfileDto profileData)
        {
            if (profileData == null)
            {
                throw new ArgumentNullException(nameof(profileData), "Datos de perfil inválidos.");
            }

            var playerToUpdate = await _context.Player.FirstOrDefaultAsync(p => p.username == username);
            if (playerToUpdate == null)
            {
                throw new Exception("Usuario no encontrado.");
            }

            playerToUpdate.name = profileData.FirstName;
            playerToUpdate.lastName = profileData.LastName;
            playerToUpdate.Gender_idGender = profileData.GenderId;
            playerToUpdate.Avatar_idAvatar = profileData.AvatarId > 0 ? profileData.AvatarId : playerToUpdate.Avatar_idAvatar;

            await _context.SaveChangesAsync();
            return new OperationResultDto { Success = true, Message = "Perfil actualizado correctamente." };
        }

        public async Task<List<AvatarDto>> GetAvailableAvatarsAsync()
        {
            var avatarsFromDb = await _context.Avatar.AsNoTracking().ToListAsync();
            var avatarsDtoList = new List<AvatarDto>();
            string basePath = AppDomain.CurrentDomain.BaseDirectory;

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
                                await stream.ReadAsync(imageData, 0, imageData.Length);
                            }
                        }
                        catch (IOException ioEx)
                        {
                            Console.WriteLine($"ERROR al leer archivo de avatar {filePath}: {ioEx.Message}");
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"ERROR inesperado al procesar avatar {filePath}: {ex.Message}");
                        }
                    }
                    else
                    {
                        Console.WriteLine($"ADVERTENCIA: No se encontró el archivo de avatar en la ruta: {filePath}");
                    }
                }
                avatarsDtoList.Add(new AvatarDto
                {
                    IdAvatar = avatarRecord.idAvatar,
                    AvatarName = avatarRecord.avatarName,
                    AvatarData = imageData
                });
            }
            return avatarsDtoList;
        }

        public async Task<OperationResultDto> RequestChangePasswordAsync(string username)
        {
            var player = await _context.Player.FirstOrDefaultAsync(p => p.username == username);
            if (player == null)
            {
                throw new Exception("Usuario no encontrado.");
            }

            string code = GenerateCode();
            player.temp_code = code;
            player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10);
            await _context.SaveChangesAsync();

            var emailTemplate = new PasswordChangeVerificationEmailTemplate(player.username, code);
            await _emailService.SendEmailAsync(player.email, player.username, emailTemplate);

            return new OperationResultDto { Success = true, Message = "Se ha enviado un código de verificación a tu correo registrado." };
        }

        public async Task<OperationResultDto> RequestChangeEmailAsync(string username, string newEmail)
        {
            if (string.IsNullOrWhiteSpace(newEmail) || !InputValidator.IsValidEmail(newEmail))
            {
                throw new Exception("Formato de nuevo correo electrónico inválido.");
            }

            var player = await _context.Player.FirstOrDefaultAsync(p => p.username == username);
            if (player == null)
            {
                throw new Exception("Usuario no encontrado.");
            }
            if (await _context.Player.AnyAsync(p => p.email == newEmail))
            {
                throw new Exception("El nuevo correo ya está registrado.");
            }

            string code = GenerateCode();
            player.temp_code = code;
            player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10);
            player.new_email_pending = newEmail;
            await _context.SaveChangesAsync();

            var emailTemplate = new EmailChangeVerificationEmailTemplate(player.username, code);
            await _emailService.SendEmailAsync(player.email, player.username, emailTemplate);

            return new OperationResultDto { Success = true, Message = $"Se ha enviado un código a tu correo actual ({player.email}) para confirmar." };
        }

        public async Task<OperationResultDto> ConfirmChangePasswordAsync(string username, string newPassword, string verificationCode)
        {
            if (!InputValidator.IsPasswordSecure(newPassword))
            {
                throw new Exception("La nueva contraseña no cumple con los requisitos de seguridad.");
            }

            var player = await _context.Player.FirstOrDefaultAsync(p => p.username == username);
            if (player == null)
            {
                throw new Exception("Usuario no encontrado.");
            }
            if (player.temp_code != verificationCode || player.temp_code_expiry < DateTime.UtcNow)
            {
                throw new Exception("Código de verificación inválido o expirado.");
            }

            player.password = PasswordHasher.HashPassword(newPassword);
            player.temp_code = null;
            player.temp_code_expiry = null;
            await _context.SaveChangesAsync();

            return new OperationResultDto { Success = true, Message = "Contraseña actualizada con éxito." };
        }

        public async Task<OperationResultDto> ConfirmChangeEmailAsync(string username, string verificationCode)
        {
            var player = await _context.Player.FirstOrDefaultAsync(p => p.username == username);
            if (player == null)
            {
                throw new Exception("Usuario no encontrado.");
            }
            if (string.IsNullOrEmpty(player.new_email_pending))
            {
                throw new Exception("No hay un cambio de email pendiente.");
            }
            if (player.temp_code != verificationCode || player.temp_code_expiry < DateTime.UtcNow)
            {
                throw new Exception("Código de verificación inválido o expirado.");
            }

            if (await _context.Player.AnyAsync(p => p.email == player.new_email_pending && p.idPlayer != player.idPlayer))
            {
                player.temp_code = null;
                player.temp_code_expiry = null;
                player.new_email_pending = null;
                await _context.SaveChangesAsync();
                throw new Exception("El nuevo correo electrónico ya fue registrado por otro usuario.");
            }

            player.email = player.new_email_pending;
            player.temp_code = null;
            player.temp_code_expiry = null;
            player.new_email_pending = null;
            await _context.SaveChangesAsync();

            return new OperationResultDto { Success = true, Message = "Email actualizado con éxito." };
        }
    }
}