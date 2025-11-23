using System.ServiceModel;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;

namespace GuessMyMessServer.Contracts.ServiceContracts
{
    [ServiceContract]
    public interface IAuthenticationService
    {
        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<OperationResultDto> LoginAsync(string emailOrUsername, string password);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<OperationResultDto> RegisterAsync(UserProfileDto userProfile, string password);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<OperationResultDto> VerifyAccountAsync(string email, string verificationCode);

        [OperationContract(IsOneWay = true)]
        void LogOut(string username);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<OperationResultDto> LoginAsGuestAsync(string email, string code);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<OperationResultDto> SendPasswordRecoveryCodeAsync(string email);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<OperationResultDto> ResetPasswordWithCodeAsync(string email, string code, string newPassword);
    }
}