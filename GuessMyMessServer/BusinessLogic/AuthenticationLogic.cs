using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
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

        public async Task<OperationResultDto> registerPlayerAsync(UserProfileDto userProfile, string password)
        {
            if (userProfile == null || string.IsNullOrWhiteSpace(password))
            {
                return new OperationResultDto { success = false, message = "El perfil de usuario y la contraseña son obligatorios." };
            }

            const int STATUS_OFFLINE = 1;

            using (var context = new GuessMyMessDBEntities())
            {
                if (context.Player.Any(p => p.username == userProfile.Username))
                {
                    return new OperationResultDto { success = false, message = "El nombre de usuario ya está en uso." };
                }
                if (context.Player.Any(p => p.email == userProfile.Email))
                {
                    return new OperationResultDto { success = false, message = "El correo electrónico ya está registrado." };
                }

                string verificationCode = random.Next(100000, 999999).ToString("D6");

                var newPlayer = new Player
                {
                    username = userProfile.Username,
                    email = userProfile.Email,
                    password = PasswordHasher.hashPassword(password),
                    name = userProfile.FirstName,
                    lastName = userProfile.LastName,
                    Gender_idGender = userProfile.GenderId,
                    Avatar_idAvatar = userProfile.AvatarId > 0 ? userProfile.AvatarId : 1,
                    UserStatus_idUserStatus = STATUS_OFFLINE,
                    is_verified = (byte)0,
                    verification_code = verificationCode,
                    code_expiry_date = DateTime.UtcNow.AddMinutes(15)
                };

                context.Player.Add(newPlayer);
                try
                {
                    await context.SaveChangesAsync();
                }
                catch (DbUpdateException dbEx)
                {
                    Console.WriteLine($"ERROR DE BASE DE DATOS: {dbEx.InnerException?.Message ?? dbEx.Message}");
                    return new OperationResultDto { success = false, message = "Error al guardar el usuario. Es posible que el avatar o el género seleccionado no sea válido." };
                }

                try
                {
                    var emailTemplate = new VerificationEmailTemplate(newPlayer.username, verificationCode);
                    await emailService.sendEmailAsync(newPlayer.email, newPlayer.username, emailTemplate);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"\n¡ERROR DE CORREO CRÍTICO!: {ex.Message}");
                    Console.WriteLine("Por favor, verifica tus credenciales de SmtpPass y SmtpUser en App.config.");
                    return new OperationResultDto { success = true, message = "Registro exitoso, pero el correo de verificación falló al enviarse. Revisa la consola del servidor." };
                }

                return new OperationResultDto { success = true, message = "Registro exitoso. Se ha enviado un código de verificación a tu correo." };
            }
        }

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

                if (playerToVerify.verification_code != code || playerToVerify.code_expiry_date < DateTime.UtcNow)
                {
                    return new OperationResultDto { success = false, message = "Código de verificación inválido o expirado." };
                }

                playerToVerify.is_verified = (byte)1;
                playerToVerify.verification_code = null;
                playerToVerify.code_expiry_date = null;
                playerToVerify.UserStatus_idUserStatus = 2;

                context.SaveChanges();

                return new OperationResultDto { success = true, message = "Cuenta verificada con éxito. ¡Bienvenido!" };
            }
        }

        public OperationResultDto login(string emailOrUsername, string password)
        {
            if (string.IsNullOrWhiteSpace(emailOrUsername) || string.IsNullOrWhiteSpace(password))
            {
                return new OperationResultDto { success = false, message = "Usuario/Correo y contraseña son obligatorios." };
            }

            const int STATUS_ONLINE = 2;

            using (var context = new GuessMyMessDBEntities())
            {
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

                if (!PasswordHasher.verifyPassword(password, player.password))
                {
                    return new OperationResultDto { success = false, message = "Credenciales incorrectas." };
                }

                player.UserStatus_idUserStatus = STATUS_ONLINE;
                context.SaveChanges();

                return new OperationResultDto { success = true, message = player.username };
            }
        }

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
