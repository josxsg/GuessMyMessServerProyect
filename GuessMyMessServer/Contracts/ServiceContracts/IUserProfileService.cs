using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;

namespace GuessMyMessServer.Contracts.ServiceContracts
{
    [ServiceContract]
    public interface IUserProfileService
    {
        [OperationContract]
        [FaultContract(typeof(string))]
        Task<UserProfileDto> GetUserProfileAsync(string username);

        [OperationContract]
        [FaultContract(typeof(string))]
        Task<OperationResultDto> UpdateProfileAsync(string username, UserProfileDto profileData);

        [OperationContract]
        [FaultContract(typeof(string))]
        Task<OperationResultDto> RequestChangeEmailAsync(string username, string newEmail);

        [OperationContract]
        [FaultContract(typeof(string))]
        Task<OperationResultDto> ConfirmChangeEmailAsync(string username, string verificationCode);

        [OperationContract]
        [FaultContract(typeof(string))]
        Task<OperationResultDto> RequestChangePasswordAsync(string username);

        [OperationContract]
        [FaultContract(typeof(string))]
        Task<OperationResultDto> ConfirmChangePasswordAsync(string username, string newPassword, string verificationCode);

        [OperationContract]
        [FaultContract(typeof(string))]
        Task<List<AvatarDto>> GetAvailableAvatarsAsync();
    }
}