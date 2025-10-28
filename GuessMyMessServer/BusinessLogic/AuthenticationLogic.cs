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
        private readonly GuessMyMessDBEntities _context;
        private readonly IEmailService _emailService;
        private static readonly Random _random = new Random();
        public AuthenticationLogic(IEmailService emailService, GuessMyMessDBEntities context)
        {
            _emailService = emailService;
            _context = context; 
        }

        public async Task<OperationResultDto> LoginAsync(string emailOrUsername, string password)
        {
            if (string.IsNullOrWhiteSpace(emailOrUsername) || string.IsNullOrWhiteSpace(password))
            {
                throw new Exception("Usuario/Correo y contraseña son obligatorios.");
            }

            const int StatusOnline = 2;

            var player = await _context.Player.FirstOrDefaultAsync(p =>
                p.username == emailOrUsername || p.email == emailOrUsername);

            if (player == null)
            {
                throw new Exception("Credenciales incorrectas.");
            }

            if (player.is_verified == (byte)0)
            {
                throw new Exception("La cuenta no ha sido verificada. Por favor, revisa tu correo.");
            }

            if (!PasswordHasher.VerifyPassword(password, player.password))
            {
                throw new Exception("Credenciales incorrectas.");
            }

            player.UserStatus_idUserStatus = StatusOnline;
            await _context.SaveChangesAsync(); 

            return new OperationResultDto { Success = true, Message = player.username };
        }

        public async Task<OperationResultDto> RegisterPlayerAsync(UserProfileDto userProfile, string password)
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
                throw new Exception("La contraseña no cumple con los requisitos de seguridad.");
            }

            const int StatusOffline = 1;
            string verificationCode = _random.Next(100000, 999999).ToString("D6");

            if (await _context.Player.AnyAsync(p => p.username == userProfile.Username)) 
            {
                throw new Exception("El nombre de usuario ya está en uso.");
            }
            if (await _context.Player.AnyAsync(p => p.email == userProfile.Email)) 
            {
                throw new Exception("El correo electrónico ya está registrado.");
            }

            try
            {
                var emailTemplate = new VerificationEmailTemplate(userProfile.Username, verificationCode);
                await _emailService.SendEmailAsync(userProfile.Email, userProfile.Username, emailTemplate);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"\n¡ERROR DE ENVÍO DE CORREO!: {ex.Message}");
                throw new Exception("No se pudo enviar el correo de verificación. Revisa que el correo sea correcto.");
            }

            var newPlayer = new Player
            {
                username = userProfile.Username,
                email = userProfile.Email,
                password = PasswordHasher.HashPassword(password), 
                name = userProfile.FirstName,
                lastName = userProfile.LastName,
                Gender_idGender = userProfile.GenderId,
                Avatar_idAvatar = userProfile.AvatarId > 0 ? userProfile.AvatarId : 1,
                UserStatus_idUserStatus = StatusOffline,
                is_verified = (byte)0,
                verification_code = verificationCode,
                code_expiry_date = DateTime.UtcNow.AddMinutes(15)
            };

            _context.Player.Add(newPlayer); 
            try
            {
                await _context.SaveChangesAsync(); 
            }
            catch (DbUpdateException dbEx)
            {
                Console.WriteLine($"ERROR DE BASE DE DATOS: {dbEx.InnerException?.Message ?? dbEx.Message}");
                throw new Exception("Error al guardar el usuario. Verifica los datos proporcionados.");
            }

            return new OperationResultDto { Success = true, Message = "Registro exitoso. Se ha enviado un código de verificación a tu correo." };
        }

        public async Task<OperationResultDto> VerifyAccountAsync(string email, string code)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(code))
            {
                throw new Exception("El correo y el código son obligatorios.");
            }

            var playerToVerify = await _context.Player.FirstOrDefaultAsync(p => p.email == email); 

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

            await _context.SaveChangesAsync(); 

            return new OperationResultDto { Success = true, Message = "Cuenta verificada con éxito. ¡Bienvenido!" };
        }

        public void LogOut(string username)
        {
            const int StatusOffline = 1;

            var player = _context.Player.FirstOrDefault(p => p.username == username);
            if (player != null)
            {
                player.UserStatus_idUserStatus = StatusOffline;
                _context.SaveChanges(); 
            }
        }
    }
}