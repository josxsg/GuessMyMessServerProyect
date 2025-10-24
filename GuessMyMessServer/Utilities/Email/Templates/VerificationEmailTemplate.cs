using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Utilities.Email
{
    public class VerificationEmailTemplate : IEmailTemplate
    {
        public string Subject => "Tu Código de Verificación para Guess My Mess!";
        public string HtmlBody { get; }

        public VerificationEmailTemplate(string username, string verificationCode)
        {
            HtmlBody = $@"
                <div style='font-family: Arial, sans-serif; text-align: center; color: #333;'>
                    <div style='max-width: 600px; margin: auto; border: 1px solid #ddd; padding: 20px; background-color: #f9f9f9; border-radius: 10px;'>
                        <h2 style='color: #FFD5A100;'>¡Bienvenido a Guess My Mess, {username}!</h2>
                        <p>Gracias por registrarte. Por favor, usa el siguiente código para activar tu cuenta:</p>
                        <div style='background-color: #4A6E92; color: white; border-radius: 8px; padding: 15px 25px; margin: 30px auto; display: inline-block;'>
                            <h1 style='font-size: 36px; letter-spacing: 5px; margin: 0;'>{verificationCode}</h1>
                        </div>
                        <p style='font-size: 14px; color: #555;'>Este código caducará en 15 minutos.</p>
                        <hr style='border: none; border-top: 1px solid #eee; margin-top: 20px;' />
                        <p style='font-size: 12px; color: #888;'>Si no creaste esta cuenta, puedes ignorar este correo de forma segura.</p>
                    </div>
                </div>";
        }
    }
}
