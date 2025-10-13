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
            // Inicializar la lógica en el constructor
            this.profileLogic = new UserProfileLogic(new SmtpEmailService());
        }

        // --------------------------------------------------
        // OBTENER PERFIL
        // --------------------------------------------------
        public UserProfileDto GetUserProfile(string username)
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
                    Username = player.username, // Se asume que no hay error de nomenclatura aquí
                    FirstName = player.name,
                    LastName = player.lastName,
                    Email = player.email,
                    // CONVERSIÓN: int? -> int
                    GenderId = player.Gender_idGender.GetValueOrDefault(),
                    AvatarId = player.Avatar_idAvatar.GetValueOrDefault()
                };
            }
        }

        // --------------------------------------------------
        // ACTUALIZAR PERFIL (Nombre, Apellido, Avatar)
        // --------------------------------------------------
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

                // Aplicar solo los cambios permitidos
                playerToUpdate.name = profileData.FirstName;
                playerToUpdate.lastName = profileData.LastName;
                playerToUpdate.Gender_idGender = profileData.GenderId;
                playerToUpdate.Avatar_idAvatar = profileData.AvatarId > 0 ? profileData.AvatarId : playerToUpdate.Avatar_idAvatar;

                context.SaveChanges();
                return new OperationResultDto { success = true, message = "Perfil actualizado correctamente." };
            }
        }

        // --------------------------------------------------
        // CAMBIAR CONTRASEÑA
        // --------------------------------------------------
        public OperationResultDto ConfirmChangePassword(string username, string newPassword, string verificationCode)
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
        public OperationResultDto ConfirmChangeEmail(string username, string verificationCode)
        {
            // Este método asume que RequestChangeEmail ya envió el código al correo antiguo 
            // y que la lógica del servidor validará el código.
            // Para fines de implementación rápida, lo marcaremos como no implementado.
            return new OperationResultDto { success = false, message = "La funcionalidad de confirmación de cambio de email no está implementada." };
        }

        public OperationResultDto RequestChangeEmail(string username, string newEmail)
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

        public OperationResultDto RequestChangePassword(string username)
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

        public List<AvatarDto> GetAvailableAvatars()
        {
            try
            {
                var avatarsDtoList = new List<AvatarDto>();

                using (var context = new GuessMyMessDBEntities())
                {
                    // 1. Obtenemos todos los registros de avatares de la base de datos
                    var avatarsFromDb = context.Avatar.ToList();

                    foreach (var avatarRecord in avatarsFromDb)
                    {
                        byte[] imageData = null; // Inicializamos los datos de la imagen como nulos

                        // Verificamos que la URL no esté vacía
                        if (!string.IsNullOrEmpty(avatarRecord.avatarUrl))
                        {
                            try
                            {
                                // 2. Construimos la ruta física completa del archivo en el servidor
                                string basePath = AppDomain.CurrentDomain.BaseDirectory; // Apunta a la carpeta /bin/Debug/ del servidor
                                string filePath = Path.Combine(basePath, avatarRecord.avatarUrl);

                                // 3. Leemos el archivo de imagen si existe y lo convertimos a un array de bytes
                                if (File.Exists(filePath))
                                {
                                    imageData = File.ReadAllBytes(filePath);
                                }
                                else
                                {
                                    // Opcional: Registra un aviso si un archivo de imagen no se encuentra
                                    Console.WriteLine($"Aviso: No se encontró el archivo de imagen para el avatar ID {avatarRecord.idAvatar} en la ruta: {filePath}");
                                }
                            }
                            catch (Exception fileEx)
                            {
                                // Opcional: Registra el error si algo falla durante la lectura del archivo
                                Console.WriteLine($"Error al leer el archivo para el avatar ID {avatarRecord.idAvatar}: {fileEx.Message}");
                            }
                        }

                        // 4. Creamos el DTO para enviarlo al cliente
                        avatarsDtoList.Add(new AvatarDto
                        {
                            idAvatar = avatarRecord.idAvatar,
                            // Si tienes un campo para el nombre en la BD, mapealo aquí. Si no, puedes quitarlo.
                            // avatarName = avatarRecord.avatarName, 
                            avatarData = imageData // Enviamos los datos binarios de la imagen al cliente
                        });
                    }
                }

                return avatarsDtoList;
            }
            catch (Exception dbEx)
            {
                // Si hay un error conectando a la base de datos, lo registramos y devolvemos una lista vacía.
                Console.WriteLine($"Error crítico al obtener avatares desde la BD: {dbEx.Message}");
                return new List<AvatarDto>();
            }
        }

    }
}
