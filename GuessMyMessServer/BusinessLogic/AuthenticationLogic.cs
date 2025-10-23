using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
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

        public async Task<OperationResultDto> loginAsync(string emailOrUsername, string password)
        {
            if (string.IsNullOrWhiteSpace(emailOrUsername) || string.IsNullOrWhiteSpace(password))
            {
                throw new Exception("Usuario/Correo y contraseña son obligatorios.");
            }

            const int STATUS_ONLINE = 2;

            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player.FirstOrDefaultAsync(p =>
                    p.username == emailOrUsername || p.email == emailOrUsername);

                if (player == null)
                {
                    throw new Exception("Credenciales incorrectas.");
                }

                if (player.is_verified == (byte)0)
                {
                    throw new Exception("La cuenta no ha sido verificada. Por favor, revisa tu correo.");
                }

                if (!PasswordHasher.verifyPassword(password, player.password))
                {
                    throw new Exception("Credenciales incorrectas.");
                }

                player.UserStatus_idUserStatus = STATUS_ONLINE;
                await context.SaveChangesAsync();

                return new OperationResultDto { success = true, message = player.username };
            }
        }

        public async Task<OperationResultDto> registerPlayerAsync(UserProfileDto userProfile, string password)
        {

            if (userProfile == null || string.IsNullOrWhiteSpace(password))
            {
                throw new Exception("El perfil de usuario y la contraseña son obligatorios.");
            }

            if (string.IsNullOrWhiteSpace(userProfile.Username) ||
                string.IsNullOrWhiteSpace(userProfile.Email) ||
                string.IsNullOrWhiteSpace(userProfile.FirstName) ||
                string.IsNullOrWhiteSpace(userProfile.LastName))
            {
                throw new Exception("Todos los campos (Usuario, Nombre, Apellido, Email) son obligatorios.");
            }

            if (!InputValidator.IsValidEmail(userProfile.Email))
            {
                throw new Exception("El formato del correo electrónico no es válido. (Ej: usuario@dominio.com)");
            }

            if (!InputValidator.IsPasswordSecure(password))
            {
                throw new Exception("La contraseña no es segura. Debe tener:\n" +
                                    "- Mínimo 8 caracteres\n" +
                                    "- Al menos una mayúscula (A-Z)\n" +
                                    "- Al menos una minúscula (a-z)\n" +
                                    "- Al menos un número (0-9)\n" +
                                    "- Al menos un caracter especial (ej: @, $, !, %)");
            }


            const int STATUS_OFFLINE = 1;
            string verificationCode = random.Next(100000, 999999).ToString("D6");

            using (var context = new GuessMyMessDBEntities())
            {
                if (await context.Player.AnyAsync(p => p.username == userProfile.Username))
                {
                    throw new Exception("El nombre de usuario ya está en uso.");
                }
                if (await context.Player.AnyAsync(p => p.email == userProfile.Email))
                {
                    throw new Exception("El correo electrónico ya está registrado.");
                }

                try
                {
                    var emailTemplate = new VerificationEmailTemplate(userProfile.Username, verificationCode);
                    await emailService.sendEmailAsync(userProfile.Email, userProfile.Username, emailTemplate);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"\n¡ERROR DE ENVÍO DE CORREO!: {ex.Message}");

                    throw new Exception("No se pudo enviar el correo de verificación. " +
                                        "Por favor, revisa que el correo proporcionado sea correcto y exista.");
                }


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
                    throw new Exception("Error al guardar el usuario. Es posible que el avatar o el género seleccionado no sea válido.");
                }

                return new OperationResultDto { success = true, message = "Registro exitoso. Se ha enviado un código de verificación a tu correo." };
            }
        }

        public async Task<OperationResultDto> verifyAccountAsync(string email, string code)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(code))
            {
                throw new Exception("El correo y el código son obligatorios.");
            }

            using (var context = new GuessMyMessDBEntities())
            {
                var playerToVerify = await context.Player.FirstOrDefaultAsync(p => p.email == email);

                if (playerToVerify == null)
                {
                    throw new Exception("No se encontró una cuenta para este correo.");
                }

                if (playerToVerify.is_verified == (byte)1)
                {
                    throw new Exception("Esta cuenta ya está verificada.");
                }

                if (playerToVerify.verification_code != code || playerToVerify.code_expiry_date < DateTime.UtcNow)
                {
                    throw new Exception("Código de verificación inválido o expirado.");
                }

                playerToVerify.is_verified = (byte)1;
                playerToVerify.verification_code = null;
                playerToVerify.code_expiry_date = null;
                playerToVerify.UserStatus_idUserStatus = 2; 

                await context.SaveChangesAsync();

                return new OperationResultDto { success = true, message = "Cuenta verificada con éxito. ¡Bienvenido!" };
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
    }
}