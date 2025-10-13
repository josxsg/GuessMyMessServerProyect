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
        [OperationContract] // GetUserProfile [cite: 706]
        UserProfileDto GetUserProfile(string username);

        [OperationContract] // UpdateUserProfile [cite: 707]
        OperationResultDto UpdateProfile(string username, UserProfileDto profileData);

        [OperationContract] // RequestChangeEmail [cite: 708]
        OperationResultDto RequestChangeEmail(string username, string newEmail);

        [OperationContract] // ConfirmChangeEmail [cite: 709]
        OperationResultDto ConfirmChangeEmail(string username, string verificationCode);

        [OperationContract] // RequestChange Password [cite: 710]
        OperationResultDto RequestChangePassword(string username);

        [OperationContract] // ConfirmChange Password [cite: 711]
        OperationResultDto ConfirmChangePassword(string username, string newPassword, string verificationCode);

        // En IUserProfileService.cs
        [OperationContract]
        List<AvatarDto> GetAvailableAvatars();

    }
}
