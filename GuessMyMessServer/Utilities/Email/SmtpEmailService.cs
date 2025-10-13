using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MailKit.Security;
using MimeKit;
using MailKit.Net.Smtp;
using System.Configuration;

namespace GuessMyMessServer.Utilities.Email
{
    public class SmtpEmailService : IEmailService
    {
        private readonly string host;
        private readonly int port;
        private readonly string user;
        private readonly string pass;
        private readonly string senderName;

        public SmtpEmailService()
        {
            // Nota: Configuración extraída del App.config de MindWeave. Debe copiarlas a su App.config.
            host = ConfigurationManager.AppSettings["SmtpHost"];
            port = Convert.ToInt32(ConfigurationManager.AppSettings["SmtpPort"]);
            user = ConfigurationManager.AppSettings["SmtpUser"];
            pass = ConfigurationManager.AppSettings["SmtpPass"];
            senderName = ConfigurationManager.AppSettings["SenderName"] ?? "Guess My Mess Team";

            if (string.IsNullOrEmpty(host) || string.IsNullOrEmpty(user) || string.IsNullOrEmpty(pass))
            {
                throw new InvalidOperationException("Email settings (SmtpHost, SmtpUser, SmtpPass) are missing in App.config.");
            }
        }

        public async Task sendEmailAsync(string recipientEmail, string recipientName, IEmailTemplate template)
        {
            var message = new MimeMessage();
            message.From.Add(new MailboxAddress(senderName, user));
            message.To.Add(new MailboxAddress(recipientName, recipientEmail));
            message.Subject = template.subject;

            var bodyBuilder = new BodyBuilder
            {
                HtmlBody = template.htmlBody
            };
            message.Body = bodyBuilder.ToMessageBody();

            using (var client = new SmtpClient())
            {
                await client.ConnectAsync(host, port, SecureSocketOptions.StartTls);
                await client.AuthenticateAsync(user, pass);
                await client.SendAsync(message);
                await client.DisconnectAsync(true);
            }
        }
    }
}
