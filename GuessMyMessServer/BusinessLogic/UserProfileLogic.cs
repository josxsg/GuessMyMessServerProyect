using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities.Email;

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

        // --------------------------------------------------
        // SOLICITUD DE CAMBIO DE CONTRASEÑA
        // --------------------------------------------------
        public async Task<OperationResultDto> RequestChangePasswordAsync(string username)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = context.Player.FirstOrDefault(p => p.username == username);

                if (player == null)
                {
                    return new OperationResultDto { success = false, message = "Usuario no encontrado." };
                }

                // 1. Generar código y fecha de expiración
                string code = GenerateCode();
                player.temp_code = code;
                player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10); // Código válido por 10 minutos

                // 2. Guardar el código en la BD
                await context.SaveChangesAsync();

                // 3. Enviar correo de verificación al correo ACTUAL
                var emailTemplate = new VerificationEmailTemplate(player.username, code);
                // NOTA: Reusa la plantilla de verificación de cuenta para el código
                await emailService.sendEmailAsync(player.email, player.username, emailTemplate);

                return new OperationResultDto { success = true, message = "Se ha enviado un código de verificación a tu correo registrado para confirmar el cambio." };
            }
        }

        // --------------------------------------------------
        // SOLICITUD DE CAMBIO DE CORREO
        // --------------------------------------------------
        public async Task<OperationResultDto> RequestChangeEmailAsync(string username, string newEmail)
        {
            if (string.IsNullOrWhiteSpace(newEmail) || !newEmail.Contains("@"))
            {
                return new OperationResultDto { success = false, message = "Formato de nuevo correo electrónico inválido." };
            }

            using (var context = new GuessMyMessDBEntities())
            {
                var player = context.Player.FirstOrDefault(p => p.username == username);

                if (player == null)
                {
                    return new OperationResultDto { success = false, message = "Usuario no encontrado." };
                }

                // 1. Validar unicidad del NUEVO correo
                if (context.Player.Any(p => p.email == newEmail))
                {
                    return new OperationResultDto { success = false, message = "El nuevo correo ya está registrado." };
                }

                // 2. Generar código, guardar código y NUEVO correo pendiente
                string code = GenerateCode();
                player.temp_code = code;
                player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10);
                player.new_email_pending = newEmail; // Guarda el nuevo email

                await context.SaveChangesAsync();

                // 3. Enviar correo de verificación al CORREO ACTUAL para verificar al usuario
                var emailTemplate = new VerificationEmailTemplate(player.username, code);
                await emailService.sendEmailAsync(player.email, player.username, emailTemplate);

                return new OperationResultDto { success = true, message = $"Se ha enviado un código de verificación a tu correo actual ({player.email}) para confirmar el cambio." };
            }
        }
    }
}
