﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Utilities.Email.Templates 
{
    public class PasswordChangeVerificationEmailTemplate : IEmailTemplate
    {
        public string Subject => "Guess My Mess - Código para Cambio de Contraseña";

        public string HtmlBody { get; }

        public PasswordChangeVerificationEmailTemplate(string username, string verificationCode)
        {
            HtmlBody = $@"
                <div style='font-family: Arial, sans-serif; text-align: center; color: #333;'>
                    <div style='max-width: 600px; margin: auto; border: 1px solid #ddd; padding: 20px; background-color: #f9f9f9; border-radius: 10px;'>
                        <h2 style='color: #4A6E92;'>Hola {username},</h2> 
                        <p>Recibimos una solicitud para cambiar tu contraseña en Guess My Mess.</p>
                        <p>Usa el siguiente código para confirmar el cambio:</p>
                        
                        <div style='background-color: #4A6E92; color: white; border-radius: 8px; padding: 15px 25px; margin: 30px auto; display: inline-block;'>
                            <h1 style='font-size: 36px; letter-spacing: 5px; margin: 0;'>{verificationCode}</h1>
                        </div>
                        <p style='font-size: 14px; color: #555;'>Este código caducará en 15 minutos.</p>
                        <hr style='border: none; border-top: 1px solid #eee; margin-top: 20px;' />
                        <p style='font-size: 12px; color: #888;'>Si no solicitaste este cambio, puedes ignorar este correo.</p>
                    </div>
                </div>";
        }

    }
}
