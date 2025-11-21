using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;

namespace GuessMyMessServer.Contracts.ServiceContracts
{
    [ServiceContract]
    public interface IUserProfileService
    {
        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<UserProfileDto> GetUserProfileAsync(string username);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<OperationResultDto> UpdateProfileAsync(string username, UserProfileDto profileData);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<OperationResultDto> RequestChangeEmailAsync(string username, string newEmail);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<OperationResultDto> ConfirmChangeEmailAsync(string username, string verificationCode);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<OperationResultDto> RequestChangePasswordAsync(string username);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<OperationResultDto> ConfirmChangePasswordAsync(string username, string newPassword, string verificationCode);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<List<AvatarDto>> GetAvailableAvatarsAsync();
    }
}