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
        private readonly string _host;
        private readonly int _port;
        private readonly string _user;
        private readonly string _pass;
        private readonly string _senderName;

        public SmtpEmailService()
        {
            _host = ConfigurationManager.AppSettings["SmtpHost"];
            _port = Convert.ToInt32(ConfigurationManager.AppSettings["SmtpPort"]);
            _user = ConfigurationManager.AppSettings["SmtpUser"];
            _pass = ConfigurationManager.AppSettings["SmtpPass"];
            _senderName = ConfigurationManager.AppSettings["SenderName"] ?? "Guess My Mess Team";

            if (string.IsNullOrEmpty(_host) || string.IsNullOrEmpty(_user) || string.IsNullOrEmpty(_pass))
            {
                throw new InvalidOperationException("Email settings (SmtpHost, SmtpUser, SmtpPass) are missing or invalid in App.config.");
            }
        }

        public async Task SendEmailAsync(string recipientEmail, string recipientName, IEmailTemplate template)
        {
            var message = new MimeMessage();
            message.From.Add(new MailboxAddress(_senderName, _user));
            message.To.Add(new MailboxAddress(recipientName, recipientEmail));
            message.Subject = template.Subject;

            var bodyBuilder = new BodyBuilder
            {
                HtmlBody = template.HtmlBody
            };
            message.Body = bodyBuilder.ToMessageBody();

            using (var client = new SmtpClient())
            {
                await client.ConnectAsync(_host, _port, SecureSocketOptions.StartTls);
                await client.AuthenticateAsync(_user, _pass);
                await client.SendAsync(message);
                await client.DisconnectAsync(true);
            }
        }
    }
}
