using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities;
using GuessMyMessServer.Utilities.Email;
using System.Data.Entity;
using System.IO;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class UserProfileService : IUserProfileService
    {
        private readonly UserProfileLogic profileLogic;

        public UserProfileService()
        {
            this.profileLogic = new UserProfileLogic(new SmtpEmailService());
        }

        public async Task<UserProfileDto> GetUserProfileAsync(string username)
        {
            try
            {
                return await profileLogic.GetUserProfileAsync(username);
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<OperationResultDto> UpdateProfileAsync(string username, UserProfileDto profileData)
        {
            try
            {
                return await profileLogic.UpdateProfileAsync(username, profileData);
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<OperationResultDto> RequestChangeEmailAsync(string username, string newEmail)
        {
            try
            {
                return await profileLogic.RequestChangeEmailAsync(username, newEmail);
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<OperationResultDto> ConfirmChangeEmailAsync(string username, string verificationCode)
        {
            try
            {
                return await profileLogic.ConfirmChangeEmailAsync(username, verificationCode);
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<OperationResultDto> RequestChangePasswordAsync(string username)
        {
            try
            {
                return await profileLogic.RequestChangePasswordAsync(username);
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<OperationResultDto> ConfirmChangePasswordAsync(string username, string newPassword, string verificationCode)
        {
            try
            {
                return await profileLogic.ConfirmChangePasswordAsync(username, newPassword, verificationCode);
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<List<AvatarDto>> GetAvailableAvatarsAsync()
        {
            try
            {
                return await profileLogic.GetAvailableAvatarsAsync();
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }
    }
}