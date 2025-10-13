using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities;
using GuessMyMessServer.Utilities.Email;

namespace GuessMyMessServer.BusinessLogic
{
    public class AuthenticationLogic
    {
        private readonly IEmailService emailService;
        private static readonly Random random = new Random();

        public AuthenticationLogic(IEmailService emailService)
        {
            this.emailService = emailService;
        }

        // --------------------------------------------------
        // REGISTRO DE USUARIO
        // --------------------------------------------------
        public async Task<OperationResultDto> registerPlayerAsync(UserProfileDto userProfile, string password)
        {
            if (userProfile == null || string.IsNullOrWhiteSpace(password))
            {
                return new OperationResultDto { success = false, message = "El perfil de usuario y la contraseña son obligatorios." };
            }

            // Usaremos el ID 1 para 'offline' y el ID 1 para el Avatar si no se especifica.
            const int STATUS_OFFLINE = 1;

            using (var context = new GuessMyMessDBEntities())
            {
                // 1. Validar unicidad (Username y Email)
                if (context.Player.Any(p => p.username == userProfile.username))
                {
                    return new OperationResultDto { success = false, message = "El nombre de usuario ya está en uso." };
                }
                if (context.Player.Any(p => p.email == userProfile.email))
                {
                    return new OperationResultDto { success = false, message = "El correo electrónico ya está registrado." };
                }

                // 2. Generar código de verificación
                string verificationCode = random.Next(100000, 999999).ToString("D6");

                // 3. Crear el nuevo registro de Player
                var newPlayer = new Player
                {
                    username = userProfile.username,
                    email = userProfile.email,
                    password = PasswordHasher.hashPassword(password), // Usamos el hash de BCrypt
                    name = userProfile.firstName,
                    lastName = userProfile.lastName,

                    // Claves Foráneas
                    Gender_idGender = userProfile.genderId, // Asumimos que la UI asegura un valor
                    Avatar_idAvatar = userProfile.avatarId > 0 ? userProfile.avatarId : 1, // Usar ID del avatar o ID 1 por defecto
                    UserStatus_idUserStatus = STATUS_OFFLINE, // Estado inicial: offline

                    // Campos de verificación
                    is_verified = (byte)0,
                    verification_code = verificationCode,
                    code_expiry_date = DateTime.UtcNow.AddMinutes(15) // Código válido por 15 minutos
                };

                context.Player.Add(newPlayer);
                await context.SaveChangesAsync();

                // 4. Enviar correo de verificación
                try
                {
                    var emailTemplate = new VerificationEmailTemplate(newPlayer.username, verificationCode);
                    await emailService.sendEmailAsync(newPlayer.email, newPlayer.username, emailTemplate);

                    // Si el correo se envía con éxito, continuar.

                }
                catch (Exception ex)
                {
                    // Captura cualquier excepción de MailKit (credenciales, conexión, TLS)
                    Console.WriteLine($"\n¡ERROR DE CORREO CRÍTICO!: {ex.Message}");
                    Console.WriteLine("Por favor, verifica tus credenciales de SmtpPass y SmtpUser en App.config.");
                    // Retornamos éxito porque la cuenta YA se guardó en la BD.
                    return new OperationResultDto { success = true, message = "Registro exitoso, pero el correo de verificación falló al enviarse. Revisa la consola del servidor." };
                }

                return new OperationResultDto { success = true, message = "Registro exitoso. Se ha enviado un código de verificación a tu correo." };
            }
        }

        // --------------------------------------------------
        // VERIFICACIÓN DE CUENTA
        // --------------------------------------------------
        public OperationResultDto verifyAccount(string email, string code)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(code))
            {
                return new OperationResultDto { success = false, message = "El correo y el código son obligatorios." };
            }

            using (var context = new GuessMyMessDBEntities())
            {
                var playerToVerify = context.Player.FirstOrDefault(p => p.email == email);

                if (playerToVerify == null)
                {
                    return new OperationResultDto { success = false, message = "No se encontró una cuenta para este correo." };
                }

                if (playerToVerify.verification_code != code || playerToVerify.code_expiry_date < DateTime.UtcNow)
                {
                    return new OperationResultDto { success = false, message = "Esta cuenta ya está verificada." };
                }

                // Validar código y tiempo de expiración
                if (playerToVerify.verification_code != code || playerToVerify.code_expiry_date < DateTime.UtcNow)
                {
                    return new OperationResultDto { success = false, message = "Código de verificación inválido o expirado." };
                }

                // Marcar como verificado y limpiar campos
                playerToVerify.is_verified = (byte)1;
                playerToVerify.verification_code = null;
                playerToVerify.code_expiry_date = null;
                playerToVerify.UserStatus_idUserStatus = 2; // Marcar como 'online' al verificar

                context.SaveChanges();

                return new OperationResultDto { success = true, message = "Cuenta verificada con éxito. ¡Bienvenido!" };
            }
        }

        // --------------------------------------------------
        // INICIO DE SESIÓN
        // --------------------------------------------------
        public OperationResultDto login(string emailOrUsername, string password)
        {
            if (string.IsNullOrWhiteSpace(emailOrUsername) || string.IsNullOrWhiteSpace(password))
            {
                return new OperationResultDto { success = false, message = "Usuario/Correo y contraseña son obligatorios." };
            }

            const int STATUS_ONLINE = 2;

            using (var context = new GuessMyMessDBEntities())
            {
                // Buscar por username o email
                var player = context.Player.FirstOrDefault(p =>
                    p.username == emailOrUsername || p.email == emailOrUsername);

                if (player == null)
                {
                    return new OperationResultDto { success = false, message = "Credenciales incorrectas." };
                }

                if (player.is_verified == (byte)0) 
                {
                    return new OperationResultDto { success = false, message = "La cuenta no ha sido verificada. Por favor, revisa tu correo." };
                }

                // Verificar contraseña
                if (!PasswordHasher.verifyPassword(password, player.password))
                {
                    return new OperationResultDto { success = false, message = "Credenciales incorrectas." };
                }

                // Actualizar estado a 'online'
                player.UserStatus_idUserStatus = STATUS_ONLINE;
                context.SaveChanges();

                return new OperationResultDto { success = true, message = player.username }; // Devuelve el username para la sesión
            }
        }

        // --------------------------------------------------
        // CIERRE DE SESIÓN
        // --------------------------------------------------
        public void logOut(string username)
        {
            const int STATUS_OFFLINE = 1;

            using (var context = new GuessMyMessDBEntities())
            {
                var player = context.Player.FirstOrDefault(p => p.username == username);
                if (player != null)
                {
                    player.UserStatus_idUserStatus = STATUS_OFFLINE;
                    context.SaveChanges();
                }
            }
        }

        public OperationResultDto loginAsGuest(string username, string avatarPath)
        {
            // Lógica para crear un perfil temporal si es necesario y asignar estado 'online'
            return new OperationResultDto { success = true, message = "GuestLogin success (Placeholder)." };
        }

        public OperationResultDto sendPasswordRecoveryCode(string email)
        {
            throw new NotImplementedException();
        }

        public OperationResultDto resetPasswordWithCode(string email, string code, string newPassword)
        {
            throw new NotImplementedException();
        }
    }
}
