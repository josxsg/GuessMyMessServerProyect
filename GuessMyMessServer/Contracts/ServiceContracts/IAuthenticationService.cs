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
    public interface IAuthenticationService
    {
        [OperationContract]
        Task<OperationResultDto> LoginAsync(string emailOrUsername, string password);

        [OperationContract]
        Task<OperationResultDto> RegisterAsync(UserProfileDto userProfile, string password);

        [OperationContract]
        Task<OperationResultDto> VerifyAccountAsync(string email, string verificationCode);

        [OperationContract(IsOneWay = true)]
        void LogOut(string username);

        [OperationContract]
        Task<OperationResultDto> LoginAsGuestAsync(string username, string avatarPath);

        [OperationContract]
        Task<OperationResultDto> SendPasswordRecoveryCodeAsync(string email);

        [OperationContract]
        Task<OperationResultDto> ResetPasswordWithCodeAsync(string email, string code, string newPassword);
    }
}
