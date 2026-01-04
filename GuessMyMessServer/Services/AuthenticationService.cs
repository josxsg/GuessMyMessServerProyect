using System;
using System.ServiceModel;
using System.Threading.Tasks;
using Autofac; // Necesario para .Resolve
using GuessMyMessServer.AppStart; // Necesario para Bootstrapper
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using log4net;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class AuthenticationService : IAuthenticationService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(AuthenticationService));

        // CAMBIO CLAVE: Usamos una propiedad para resolver una nueva instancia de la lógica
        // (y un nuevo DbContext) cada vez que se accede. Esto evita problemas de concurrencia.
        private static AuthenticationLogic Logic => Bootstrapper.Container.Resolve<AuthenticationLogic>();

        public AuthenticationService()
        {
            // Aseguramos que el contenedor esté inicializado al crear el servicio
            Bootstrapper.Init();
        }

        public async Task<OperationResultDto> LoginAsync(string emailOrUsername, string password)
        {
            _log.InfoFormat("Login request received for: {0}", emailOrUsername);
            return await Logic.LoginAsync(emailOrUsername, password);
        }

        public async Task<OperationResultDto> RegisterAsync(UserProfileDto userProfile, string password)
        {
            _log.InfoFormat("Registration request received for: {0}", userProfile?.Username ?? "Unknown");
            return await Logic.RegisterPlayerAsync(userProfile, password);
        }

        public async Task<OperationResultDto> VerifyAccountAsync(string email, string verificationCode)
        {
            _log.InfoFormat("Account verification request for: {0}", email);
            return await Logic.VerifyAccountAsync(email, verificationCode);
        }

        public async Task<OperationResultDto> LoginAsGuestAsync(string email, string code)
        {
            _log.InfoFormat("Guest login request for match code: {0}", code);
            return await Logic.LoginAsGuestAsync(email, code);
        }

        public async void LogOut(string username)
        {
            // Nota: LogOut suele ser void/OneWay, así que usamos async void y capturamos excepciones internamente si fuera necesario,
            // pero AuthenticationLogic.LogOutAsync ya maneja excepciones internamente.
            await Logic.LogOutAsync(username);
        }

        public Task<OperationResultDto> SendPasswordRecoveryCodeAsync(string email)
        {
            var fault = new ServiceFaultDto(ServiceErrorType.OperationFailed, "Password recovery not implemented yet.");
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason("Not Implemented"));
        }

        public Task<OperationResultDto> ResetPasswordWithCodeAsync(string email, string code, string newPassword)
        {
            var fault = new ServiceFaultDto(ServiceErrorType.OperationFailed, "Password reset not implemented yet.");
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason("Not Implemented"));
        }
    }
}