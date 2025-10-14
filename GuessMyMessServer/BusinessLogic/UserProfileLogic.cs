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

        public async Task<OperationResultDto> RequestChangePasswordAsync(string username)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = context.Player.FirstOrDefault(p => p.username == username);

                if (player == null)
                {
                    return new OperationResultDto { success = false, message = "Usuario no encontrado." };
                }

                string code = GenerateCode();
                player.temp_code = code;
                player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10);

                await context.SaveChangesAsync();

                var emailTemplate = new VerificationEmailTemplate(player.username, code);
                await emailService.sendEmailAsync(player.email, player.username, emailTemplate);

                return new OperationResultDto { success = true, message = "Se ha enviado un código de verificación a tu correo registrado para confirmar el cambio." };
            }
        }

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

                if (context.Player.Any(p => p.email == newEmail))
                {
                    return new OperationResultDto { success = false, message = "El nuevo correo ya está registrado." };
                }

                string code = GenerateCode();
                player.temp_code = code;
                player.temp_code_expiry = DateTime.UtcNow.AddMinutes(10);
                player.new_email_pending = newEmail;

                await context.SaveChangesAsync();

                var emailTemplate = new VerificationEmailTemplate(player.username, code);
                await emailService.sendEmailAsync(player.email, player.username, emailTemplate);

                return new OperationResultDto { success = true, message = $"Se ha enviado un código de verificación a tu correo actual ({player.email}) para confirmar el cambio." };
            }
        }
    }
}
