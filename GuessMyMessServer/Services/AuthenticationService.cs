using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess; 
using GuessMyMessServer.Utilities.Email;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class AuthenticationService : IAuthenticationService
    {

        public async Task<OperationResultDto> LoginAsync(string emailOrUsername, string password)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();

                    var logic = new AuthenticationLogic(emailService, context);

                    return await logic.LoginAsync(emailOrUsername, password);
                }
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<OperationResultDto> RegisterAsync(UserProfileDto userProfile, string password)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new AuthenticationLogic(emailService, context);
                    return await logic.RegisterPlayerAsync(userProfile, password);
                }
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<OperationResultDto> VerifyAccountAsync(string email, string verificationCode)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new AuthenticationLogic(emailService, context);
                    return await logic.VerifyAccountAsync(email, verificationCode);
                }
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public void LogOut(string username)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new AuthenticationLogic(emailService, context);
                    logic.LogOut(username);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en LogOut (OneWay): {ex.Message}");
            }
        }

        public Task<OperationResultDto> LoginAsGuestAsync(string username, string avatarPath) { throw new NotImplementedException(); }
        public Task<OperationResultDto> SendPasswordRecoveryCodeAsync(string email) { throw new NotImplementedException(); }
        public Task<OperationResultDto> ResetPasswordWithCodeAsync(string email, string code, string newPassword) { throw new NotImplementedException(); }
    }
}