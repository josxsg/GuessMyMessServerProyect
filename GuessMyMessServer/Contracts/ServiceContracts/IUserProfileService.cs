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
        UserProfileDto GetUserProfile(string username);

        [OperationContract] 
        OperationResultDto UpdateProfile(string username, UserProfileDto profileData);

        [OperationContract] 
        OperationResultDto RequestChangeEmail(string username, string newEmail);

        [OperationContract] 
        OperationResultDto ConfirmChangeEmail(string username, string verificationCode);

        [OperationContract] 
        OperationResultDto RequestChangePassword(string username);

        [OperationContract] 
        OperationResultDto ConfirmChangePassword(string username, string newPassword, string verificationCode);

        [OperationContract]
        List<AvatarDto> GetAvailableAvatars();

    }
}
