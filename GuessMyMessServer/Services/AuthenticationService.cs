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
        private AuthenticationLogic Logic => Bootstrapper.Container.Resolve<AuthenticationLogic>();

        public AuthenticationService()
        {
            // Aseguramos que el contenedor esté inicializado al crear el servicio
            Bootstrapper.Init();
        }

        public async Task<OperationResultDto> LoginAsync(string emailOrUsername, string password)
        {
            _log.Info($"Login request received for: {emailOrUsername}");
            return await Logic.LoginAsync(emailOrUsername, password);
        }

        public async Task<OperationResultDto> RegisterAsync(UserProfileDto userProfile, string password)
        {
            _log.Info($"Registration request received for: {userProfile?.Username ?? "Unknown"}");
            return await Logic.RegisterPlayerAsync(userProfile, password);
        }

        public async Task<OperationResultDto> VerifyAccountAsync(string email, string verificationCode)
        {
            _log.Info($"Account verification request for: {email}");
            return await Logic.VerifyAccountAsync(email, verificationCode);
        }

        public async Task<OperationResultDto> LoginAsGuestAsync(string email, string code)
        {
            _log.Info($"Guest login request for match code: {code}");
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