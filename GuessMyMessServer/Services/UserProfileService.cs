using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.Utilities.Email;


namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class UserProfileService : IUserProfileService
    {
        private readonly UserProfileLogic _profileLogic;

        public UserProfileService()
        {
            _profileLogic = new UserProfileLogic(new SmtpEmailService());
        }

        public async Task<UserProfileDto> GetUserProfileAsync(string username)
        {
            try
            {
                return await _profileLogic.GetUserProfileAsync(username);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al obtener el perfil de usuario: {ex.Message}");
            }
        }

        public async Task<OperationResultDto> UpdateProfileAsync(string username, UserProfileDto profileData)
        {
            try
            {
                return await _profileLogic.UpdateProfileAsync(username, profileData);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al actualizar el perfil: {ex.Message}");
            }
        }

        public async Task<OperationResultDto> RequestChangeEmailAsync(string username, string newEmail)
        {
            try
            {
                return await _profileLogic.RequestChangeEmailAsync(username, newEmail);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al solicitar cambio de correo: {ex.Message}");
            }
        }

        public async Task<OperationResultDto> ConfirmChangeEmailAsync(string username, string verificationCode)
        {
            try
            {
                return await _profileLogic.ConfirmChangeEmailAsync(username, verificationCode);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al confirmar cambio de correo: {ex.Message}");
            }
        }

        public async Task<OperationResultDto> RequestChangePasswordAsync(string username)
        {
            try
            {
                return await _profileLogic.RequestChangePasswordAsync(username);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al solicitar cambio de contraseña: {ex.Message}");
            }
        }

        public async Task<OperationResultDto> ConfirmChangePasswordAsync(string username, string newPassword, string verificationCode)
        {
            try
            {
                return await _profileLogic.ConfirmChangePasswordAsync(username, newPassword, verificationCode);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al confirmar cambio de contraseña: {ex.Message}");
            }
        }

        public async Task<List<AvatarDto>> GetAvailableAvatarsAsync()
        {
            try
            {
                return await _profileLogic.GetAvailableAvatarsAsync();
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al obtener avatares disponibles: {ex.Message}");
            }
        }
    }
}