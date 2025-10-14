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
        OperationResultDto Login(string email, string password);

        [OperationContract] 
        OperationResultDto Register(UserProfileDto userProfile, string password);

        [OperationContract] 
        OperationResultDto VerifyAccount(string email, string verificationCode);

        [OperationContract] 
        OperationResultDto LoginAsGuest(string username, string avatarPath);

        [OperationContract(IsOneWay = true)] 
        void LogOut(string username);

        [OperationContract]
        OperationResultDto SendPasswordRecoveryCode(string email);

        [OperationContract]
        OperationResultDto ResetPasswordWithCode(string email, string code, string newPassword);
    }
}
