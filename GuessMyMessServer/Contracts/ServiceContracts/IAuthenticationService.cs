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
        [OperationContract] // LogIn [cite: 698]
        OperationResultDto Login(string email, string password);

        [OperationContract] // SignUp [cite: 699]
        OperationResultDto Register(UserProfileDto userProfile, string password);

        [OperationContract] // Verify Account [cite: 701]
        OperationResultDto VerifyAccount(string email, string verificationCode);

        [OperationContract] // LoginAsGuest [cite: 702]
        OperationResultDto LoginAsGuest(string username, string avatarPath);

        [OperationContract(IsOneWay = true)] // LogOut [cite: 703]
        void LogOut(string username);

        // Funciones de MindWeave para recuperación de contraseña
        [OperationContract]
        OperationResultDto SendPasswordRecoveryCode(string email);

        [OperationContract]
        OperationResultDto ResetPasswordWithCode(string email, string code, string newPassword);
    }
}
