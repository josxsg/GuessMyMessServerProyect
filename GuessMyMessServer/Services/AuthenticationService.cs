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
using GuessMyMessServer.DataAccess; // <-- CAMBIO 1: Añadimos 'using' de DataAccess
using GuessMyMessServer.Utilities.Email;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class AuthenticationService : IAuthenticationService
    {
        // --- CAMBIO 2: Eliminamos el campo _authenticationLogic y el constructor ---

        public async Task<OperationResultDto> LoginAsync(string emailOrUsername, string password)
        {
            try
            {
                // --- CAMBIO 3: Creamos las dependencias AQUÍ ---
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();

                    // "Inyectamos" las dependencias en la lógica
                    var logic = new AuthenticationLogic(emailService, context);

                    // Llamamos a la lógica local
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
                // --- CAMBIO 3: Creamos las dependencias AQUÍ ---
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

        public async Task<OperationResultDto> VerifyAccountAsync(string email, string code)
        {
            try
            {
                // --- CAMBIO 3: Creamos las dependencias AQUÍ ---
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new AuthenticationLogic(emailService, context);
                    return await logic.VerifyAccountAsync(email, code);
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
                // --- CAMBIO 3: Creamos las dependencias AQUÍ ---
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

        // --- MÉTODOS NO IMPLEMENTADOS ---
        public Task<OperationResultDto> LoginAsGuestAsync(string username, string avatarPath) { throw new NotImplementedException(); }
        public Task<OperationResultDto> SendPasswordRecoveryCodeAsync(string email) { throw new NotImplementedException(); }
        public Task<OperationResultDto> ResetPasswordWithCodeAsync(string email, string code, string newPassword) { throw new NotImplementedException(); }
    }
}