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
using System.Data.Entity.Infrastructure;

namespace GuessMyMessServer.BusinessLogic
{
    public class UserProfileLogic
    {
        private readonly IEmailService emailService;
        private static readonly Random random = new Random();

        public UserProfileLogic(IEmailService emailService)
        {
            this.emailService = emailService;
        }

        private string GenerateCode() => random.Next(100000, 999999).ToString("D6");

        public async Task<UserProfileDto> GetUserProfileAsync(string username)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player
                    .AsNoTracking() // Optimización para solo lectura
                    .Include(p => p.Gender)
                    .Include(p => p.Avatar)
                    .FirstOrDefaultAsync(p => p.username == username);

                if (player == null) throw new Exception("Usuario no encontrado.");

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
        }

        public async Task<OperationResultDto> UpdateProfileAsync(string username, UserProfileDto profileData)
        {
            if (profileData == null) throw new Exception("Datos de perfil inválidos.");

            using (var context = new GuessMyMessDBEntities())
            {
                var playerToUpdate = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (playerToUpdate == null) throw new Exception("Usuario no encontrado.");

                playerToUpdate.name = profileData.FirstName;
                playerToUpdate.lastName = profileData.LastName;
                playerToUpdate.Gender_idGender = profileData.GenderId;
                playerToUpdate.Avatar_idAvatar = profileData.AvatarId > 0 ? profileData.AvatarId : playerToUpdate.Avatar_idAvatar;

                await context.SaveChangesAsync();
                return new OperationResultDto { success = true, message = "Perfil actualizado correctamente." };
            }
        }

        public async Task<List<AvatarDto>> GetAvailableAvatarsAsync()
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var avatarsFromDb = await context.Avatar.AsNoTracking().ToListAsync();
                var avatarsDtoList = new List<AvatarDto>();

                foreach (var avatarRecord in avatarsFromDb)
                {
                    byte[] imageData = null;
                    if (!string.IsNullOrEmpty(avatarRecord.avatarUrl))
                    {
                        string basePath = AppDomain.CurrentDomain.BaseDirectory;
                        string filePath = Path.Combine(basePath, avatarRecord.avatarUrl);

                        if (File.Exists(filePath))
                        {
                            // ----- INICIO DE LA CORRECCIÓN -----
                            // Reemplazamos File.ReadAllBytes(filePath) por su versión asíncrona
                            using (FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read, bufferSize: 4096, useAsync: true))
                            {
                                imageData = new byte[stream.Length];
                                await stream.ReadAsync(imageData, 0, imageData.Length);
                            }
                            // ----- FIN DE LA CORRECCIÓN -----
                        }
                        else
                        {
                            Console.WriteLine($"ADVERTENCIA: No se encontró el archivo de avatar en la ruta: {filePath}");
                        }
                    }
                    avatarsDtoList.Add(new AvatarDto
                    {
                        idAvatar = avatarRecord.idAvatar,
                        avatarName = avatarRecord.avatarName,
                        avatarData = imageData
                    });
                }
                return avatarsDtoList;
            }
        }

        // --- RESTO DE TUS MÉTODOS ASÍNCRONOS (YA ESTABAN BIEN) ---

        public async Task<OperationResultDto> RequestChangePasswordAsync(string username)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null) throw new Exception("Usuario no encontrado.");

                string code = GenerateCode();
                player.temp_code = code;
                player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10);
                await context.SaveChangesAsync();

                var emailTemplate = new VerificationEmailTemplate(player.username, code);
                await emailService.sendEmailAsync(player.email, player.username, emailTemplate);

                return new OperationResultDto { success = true, message = "Se ha enviado un código de verificación a tu correo registrado." };
            }
        }

        public async Task<OperationResultDto> RequestChangeEmailAsync(string username, string newEmail)
        {
            if (string.IsNullOrWhiteSpace(newEmail) || !newEmail.Contains("@"))
                throw new Exception("Formato de nuevo correo electrónico inválido.");

            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null) throw new Exception("Usuario no encontrado.");
                if (await context.Player.AnyAsync(p => p.email == newEmail))
                    throw new Exception("El nuevo correo ya está registrado.");

                string code = GenerateCode();
                player.temp_code = code;
                player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10);
                player.new_email_pending = newEmail;
                await context.SaveChangesAsync();

                var emailTemplate = new VerificationEmailTemplate(player.username, code);
                await emailService.sendEmailAsync(player.email, player.username, emailTemplate);

                return new OperationResultDto { success = true, message = $"Se ha enviado un código a tu correo actual ({player.email}) para confirmar." };
            }
        }

        public async Task<OperationResultDto> ConfirmChangePasswordAsync(string username, string newPassword, string verificationCode)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null) throw new Exception("Usuario no encontrado.");
                if (player.temp_code != verificationCode || player.temp_code_expiry < DateTime.UtcNow)
                    throw new Exception("Código de verificación inválido o expirado.");

                player.password = PasswordHasher.hashPassword(newPassword);
                player.temp_code = null;
                player.temp_code_expiry = null;
                await context.SaveChangesAsync();

                return new OperationResultDto { success = true, message = "Contraseña actualizada con éxito." };
            }
        }

        public async Task<OperationResultDto> ConfirmChangeEmailAsync(string username, string verificationCode)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null) throw new Exception("Usuario no encontrado.");
                if (string.IsNullOrEmpty(player.new_email_pending)) throw new Exception("No hay un cambio de email pendiente.");
                if (player.temp_code != verificationCode || player.temp_code_expiry < DateTime.UtcNow)
                    throw new Exception("Código de verificación inválido o expirado.");

                player.email = player.new_email_pending;
                player.temp_code = null;
                player.temp_code_expiry = null;
                player.new_email_pending = null;
                await context.SaveChangesAsync();

                return new OperationResultDto { success = true, message = "Email actualizado con éxito." };
            }
        }
    }
}