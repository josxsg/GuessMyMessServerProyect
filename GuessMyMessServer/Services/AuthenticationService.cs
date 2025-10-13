using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.Utilities.Email;

namespace GuessMyMessServer.Services
{
    // Usa PerCall para operaciones sin estado como autenticación
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class AuthenticationService : IAuthenticationService
    {
        private readonly AuthenticationLogic authenticationLogic;

        public AuthenticationService()
        {
            // Inicialización con el servicio de email
            authenticationLogic = new AuthenticationLogic(new SmtpEmailService());
        }

        public OperationResultDto login(string emailOrUsername, string password)
        {
            try
            {
                return authenticationLogic.login(emailOrUsername, password);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error de Login: {ex}");
                return new OperationResultDto { success = false, message = "Error inesperado del servidor." };
            }
        }

        public OperationResultDto register(UserProfileDto userProfile, string password)
        {
            try
            {
                return authenticationLogic.registerPlayerAsync(userProfile, password).Result;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error de Registro: {ex}");
                return new OperationResultDto { success = false, message = "Error inesperado del servidor durante el registro." };
            }
        }

        public OperationResultDto verifyAccount(string email, string code)
        {
            try
            {
                return authenticationLogic.verifyAccount(email, code);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error de Verificación: {ex}");
                return new OperationResultDto { success = false, message = "Error inesperado del servidor durante la verificación." };
            }
        }

        public void logOut(string username)
        {
            try
            {
                authenticationLogic.logOut(username);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error de LogOut: {ex}");
                // No devuelve nada, solo registra el error
            }
        }

        // ... (otros métodos de IAuthenticationService) ...
        public OperationResultDto loginAsGuest(string username, string avatarPath) { throw new NotImplementedException(); }
        public OperationResultDto sendPasswordRecoveryCode(string email) { throw new NotImplementedException(); }
        public OperationResultDto resetPasswordWithCode(string email, string code, string newPassword) { throw new NotImplementedException(); }
    }
}
