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

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class UserProfileService : IUserProfileService
    {
        private readonly UserProfileLogic profileLogic;

        public UserProfileService()
        {
            // Inicializar la lógica en el constructor
            this.profileLogic = new UserProfileLogic(new SmtpEmailService());
        }

        // --------------------------------------------------
        // OBTENER PERFIL
        // --------------------------------------------------
        public UserProfileDto getUserProfile(string username)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = context.Player
                    .Include(p => p.Gender)
                    .Include(p => p.Avatar)
                    .FirstOrDefault(p => p.username == username);

                if (player == null) return null;

                // Mapeo con GetValueOrDefault() para manejar int? de la BD
                return new UserProfileDto
                {
                    username = player.username, // Se asume que no hay error de nomenclatura aquí
                    firstName = player.name,
                    lastName = player.lastName,
                    email = player.email,
                    // CONVERSIÓN: int? -> int
                    genderId = player.Gender_idGender.GetValueOrDefault(),
                    avatarId = player.Avatar_idAvatar.GetValueOrDefault()
                };
            }
        }

        // --------------------------------------------------
        // ACTUALIZAR PERFIL (Nombre, Apellido, Avatar)
        // --------------------------------------------------
        public OperationResultDto updateProfile(string username, UserProfileDto profileData)
        {
            if (profileData == null) return new OperationResultDto { success = false, message = "Datos de perfil inválidos." };

            using (var context = new GuessMyMessDBEntities())
            {
                var playerToUpdate = context.Player.FirstOrDefault(p => p.username == username);

                if (playerToUpdate == null)
                {
                    return new OperationResultDto { success = false, message = "Usuario no encontrado." };
                }

                // Aplicar solo los cambios permitidos
                playerToUpdate.name = profileData.firstName;
                playerToUpdate.lastName = profileData.lastName;
                playerToUpdate.Gender_idGender = profileData.genderId;
                playerToUpdate.Avatar_idAvatar = profileData.avatarId > 0 ? profileData.avatarId : playerToUpdate.Avatar_idAvatar;

                context.SaveChanges();
                return new OperationResultDto { success = true, message = "Perfil actualizado correctamente." };
            }
        }

        // --------------------------------------------------
        // CAMBIAR CONTRASEÑA
        // --------------------------------------------------
        public OperationResultDto confirmChangePassword(string username, string newPassword, string verificationCode)
        {
            // Este método asume que el RequestChangePassword ya ha sido llamado y el código ya fue validado en el servidor.
            using (var context = new GuessMyMessDBEntities())
            {
                var player = context.Player.FirstOrDefault(p => p.username == username);

                if (player == null) return new OperationResultDto { success = false, message = "Usuario no encontrado." };

                // En una implementación real, aquí se validaría el código de verificación por correo
                // y el tiempo de expiración ANTES de cambiar la contraseña.

                // Hashing de la nueva contraseña
                player.password = PasswordHasher.hashPassword(newPassword);
                context.SaveChanges();

                return new OperationResultDto { success = true, message = "Contraseña actualizada con éxito." };
            }
        }

        // --------------------------------------------------
        // CAMBIAR CORREO ELECTRÓNICO
        // --------------------------------------------------
        public OperationResultDto confirmChangeEmail(string username, string verificationCode)
        {
            // Este método asume que RequestChangeEmail ya envió el código al correo antiguo 
            // y que la lógica del servidor validará el código.
            // Para fines de implementación rápida, lo marcaremos como no implementado.
            return new OperationResultDto { success = false, message = "La funcionalidad de confirmación de cambio de email no está implementada." };
        }

        public OperationResultDto requestChangeEmail(string username, string newEmail)
        {
            try
            {
                // Llama al método asíncrono de la lógica y espera el resultado
                return profileLogic.RequestChangeEmailAsync(username, newEmail).Result;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error RequestChangeEmail: {ex}");
                return new OperationResultDto { success = false, message = "Error inesperado al solicitar el cambio de correo." };
            }
        }

        public OperationResultDto requestChangePassword(string username)
        {
            try
            {
                // Llama al método asíncrono de la lógica y espera el resultado
                return profileLogic.RequestChangePasswordAsync(username).Result;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error RequestChangePassword: {ex}");
                return new OperationResultDto { success = false, message = "Error inesperado al solicitar el cambio de contraseña." };
            }
        }

        public List<AvatarDto> getAvailableAvatars()
        {
            try
            {
                // **IMPLEMENTACIÓN DE LECTURA DE BASE DE DATOS**
                // Reemplaza 'GuessMyMessDBEntities' con el nombre real de tu clase DbContext 
                // si es diferente, y asegúrate de que 'Avatar' sea la tabla correcta.

                
                using (var context = new GuessMyMessDBEntities()) 
                {
                    var avatars = context.Avatar // Accede a la tabla Avatars
                        .Select(a => new AvatarDto 
                        {
                            // Mapea directamente los campos de la entidad a tu DTO
                            idAvatar = a.idAvatar,
                            avatarName = a.avatarName,
                            avatarData = a.avatarData // El byte[] se transfiere por WCF
                        })
                        .ToList();

                    return avatars;
                }
                /*

                // --- MOCK FUNCIONAL TEMPORAL para pruebas sin DB ---
                // Si la línea de 'using (var context...' te da error, usa este MOCK:
                // Crea un array de bytes vacío para simular una imagen
                byte[] emptyImage = new byte[0];
                return new List<AvatarDto>
            {
                new AvatarDto { idAvatar = 1, avatarName = "Default Male", avatarData = emptyImage },
                new AvatarDto { idAvatar = 2, avatarName = "Default Female", avatarData = emptyImage },
                new AvatarDto { idAvatar = 3, avatarName = "Generic Bot", avatarData = emptyImage }
            };
                // ----------------------------------------------------
                */
            }
            catch (Exception ex)
            {
                // Nota: Es crucial NO lanzar la excepción aquí, sino encapsularla, para que WCF no falle.
                Console.WriteLine($"Error al obtener avatares desde la BD: {ex.Message}");
                // Devuelve una lista vacía en caso de error de BD.
                return new List<AvatarDto>();
            }
        }

    }
}
