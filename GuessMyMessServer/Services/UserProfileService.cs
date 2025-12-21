using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;
using Autofac;
using GuessMyMessServer.AppStart;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using log4net;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class UserProfileService : IUserProfileService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(UserProfileService));

        // Propiedad para resolver la lógica bajo demanda (Nuevo DbContext por llamada)
        private UserProfileLogic Logic => Bootstrapper.Container.Resolve<UserProfileLogic>();

        // Constructor para WCF
        public UserProfileService()
        {
            Bootstrapper.Init();
        }

        // Constructor para Inyección
        public UserProfileService(UserProfileLogic profileLogic)
        {
            // No asignamos nada para forzar el uso de la propiedad Logic y el contenedor
        }

        public async Task<UserProfileDto> GetUserProfileAsync(string username)
        {
            _log.Info($"Request GetUserProfile for: {username}");
            return await Logic.GetUserProfileAsync(username);
        }

        public async Task<OperationResultDto> UpdateProfileAsync(string username, UserProfileDto profileData)
        {
            _log.Info($"Request UpdateProfile for: {username}");
            return await Logic.UpdateProfileAsync(username, profileData);
        }

        public async Task<OperationResultDto> AddOrUpdateSocialNetworkAsync(string username, SocialNetworkDto socialNetwork)
        {
            _log.Info($"Request Add/Update SocialNetwork ({socialNetwork?.NetworkType}) for: {username}");
            return await Logic.AddOrUpdateSocialNetworkAsync(username, socialNetwork);
        }

        public async Task<List<AvatarDto>> GetAvailableAvatarsAsync()
        {
            return await Logic.GetAvailableAvatarsAsync();
        }

        public async Task<OperationResultDto> RequestChangeEmailAsync(string username, string newEmail)
        {
            _log.Info($"Request ChangeEmail for: {username}");
            return await Logic.RequestChangeEmailAsync(username, newEmail);
        }

        public async Task<OperationResultDto> ConfirmChangeEmailAsync(string username, string verificationCode)
        {
            _log.Info($"Request ConfirmChangeEmail for: {username}");
            return await Logic.ConfirmChangeEmailAsync(username, verificationCode);
        }

        public async Task<OperationResultDto> RequestChangePasswordAsync(string username)
        {
            _log.Info($"Request ChangePassword for: {username}");
            return await Logic.RequestChangePasswordAsync(username);
        }

        public async Task<OperationResultDto> ConfirmChangePasswordAsync(string username, string newPassword, string verificationCode)
        {
            _log.Info($"Request ConfirmChangePassword for: {username}");
            return await Logic.ConfirmChangePasswordAsync(username, newPassword, verificationCode);
        }
    }
}