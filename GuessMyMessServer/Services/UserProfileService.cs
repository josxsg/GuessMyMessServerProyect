using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities;
using GuessMyMessServer.Utilities.Email;
using System.Data.Entity;
using System.IO;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class UserProfileService : IUserProfileService
    {
        private readonly UserProfileLogic profileLogic;

        public UserProfileService()
        {
            this.profileLogic = new UserProfileLogic(new SmtpEmailService());
        }

        public UserProfileDto GetUserProfile(string username)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = context.Player
                    .Include(p => p.Gender)
                    .Include(p => p.Avatar)
                    .FirstOrDefault(p => p.username == username);

                if (player == null) return null;

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

        public OperationResultDto UpdateProfile(string username, UserProfileDto profileData)
        {
            if (profileData == null) return new OperationResultDto { success = false, message = "Datos de perfil inválidos." };

            using (var context = new GuessMyMessDBEntities())
            {
                var playerToUpdate = context.Player.FirstOrDefault(p => p.username == username);

                if (playerToUpdate == null)
                {
                    return new OperationResultDto { success = false, message = "Usuario no encontrado." };
                }

                playerToUpdate.name = profileData.FirstName;
                playerToUpdate.lastName = profileData.LastName;
                playerToUpdate.Gender_idGender = profileData.GenderId;
                playerToUpdate.Avatar_idAvatar = profileData.AvatarId > 0 ? profileData.AvatarId : playerToUpdate.Avatar_idAvatar;

                context.SaveChanges();
                return new OperationResultDto { success = true, message = "Perfil actualizado correctamente." };
            }
        }

        public OperationResultDto ConfirmChangePassword(string username, string newPassword, string verificationCode)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = context.Player.FirstOrDefault(p => p.username == username);

                if (player == null) return new OperationResultDto { success = false, message = "Usuario no encontrado." };

                player.password = PasswordHasher.hashPassword(newPassword);
                context.SaveChanges();

                return new OperationResultDto { success = true, message = "Contraseña actualizada con éxito." };
            }
        }

        public OperationResultDto ConfirmChangeEmail(string username, string verificationCode)
        {
            return new OperationResultDto { success = false, message = "La funcionalidad de confirmación de cambio de email no está implementada." };
        }

        public OperationResultDto RequestChangeEmail(string username, string newEmail)
        {
            try
            {
                return profileLogic.RequestChangeEmailAsync(username, newEmail).Result;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error RequestChangeEmail: {ex}");
                return new OperationResultDto { success = false, message = "Error inesperado al solicitar el cambio de correo." };
            }
        }

        public OperationResultDto RequestChangePassword(string username)
        {
            try
            {
                return profileLogic.RequestChangePasswordAsync(username).Result;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error RequestChangePassword: {ex}");
                return new OperationResultDto { success = false, message = "Error inesperado al solicitar el cambio de contraseña." };
            }
        }

        public List<AvatarDto> GetAvailableAvatars()
        {
            var avatarsDtoList = new List<AvatarDto>();
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var avatarsFromDb = context.Avatar.ToList();

                    foreach (var avatarRecord in avatarsFromDb)
                    {
                        byte[] imageData = null;

                        if (!string.IsNullOrEmpty(avatarRecord.avatarUrl))
                        {
                            string basePath = AppDomain.CurrentDomain.BaseDirectory;
                            string filePath = Path.Combine(basePath, avatarRecord.avatarUrl);

                            if (File.Exists(filePath))
                            {
                                imageData = File.ReadAllBytes(filePath);
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
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al obtener avatares: {ex.Message}");
                return new List<AvatarDto>();
            }
            return avatarsDtoList;
        }
    }
}
