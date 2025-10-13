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
        UserProfileDto getUserProfile(string username);

        [OperationContract] // UpdateUserProfile [cite: 707]
        OperationResultDto updateProfile(string username, UserProfileDto profileData);

        [OperationContract] // RequestChangeEmail [cite: 708]
        OperationResultDto requestChangeEmail(string username, string newEmail);

        [OperationContract] // ConfirmChangeEmail [cite: 709]
        OperationResultDto confirmChangeEmail(string username, string verificationCode);

        [OperationContract] // RequestChange Password [cite: 710]
        OperationResultDto requestChangePassword(string username);

        [OperationContract] // ConfirmChange Password [cite: 711]
        OperationResultDto confirmChangePassword(string username, string newPassword, string verificationCode);

        // En IUserProfileService.cs
        [OperationContract]
        List<AvatarDto> getAvailableAvatars();

    }
}
