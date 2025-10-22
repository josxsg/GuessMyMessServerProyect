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
        private readonly AuthenticationLogic _authenticationLogic;

        public AuthenticationService()
        {
            _authenticationLogic = new AuthenticationLogic(new SmtpEmailService());
        }

        public async Task<OperationResultDto> LoginAsync(string emailOrUsername, string password)
        {
            try
            {
                return await _authenticationLogic.loginAsync(emailOrUsername, password);
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
                return await _authenticationLogic.registerPlayerAsync(userProfile, password);
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<OperationResultDto> VerifyAccountAsync(string email, string code)
        {
            try
            {
                return await _authenticationLogic.verifyAccountAsync(email, code);
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
                _authenticationLogic.logOut(username);
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
