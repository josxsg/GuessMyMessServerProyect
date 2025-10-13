using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;

namespace GuessMyMessServer.Contracts.ServiceContracts
{
    [ServiceContract(CallbackContract = typeof(ISocialServiceCallback))] // [cite: 712]
    public interface ISocialService
    {
        [OperationContract] // GetFriendsList [cite: 714]
        List<FriendDto> getFriendsList(string username);

        [OperationContract] // Necesario para gestionar solicitudes
        List<FriendRequestInfoDto> getFriendRequests(string username);

        [OperationContract] // Search Users [cite: 715]
        List<UserProfileDto> searchUsers(string searchUsername);

        [OperationContract(IsOneWay = true)] // Send Friend Request [cite: 716]
        void sendFriendRequest(string requesterUsername, string targetUsername);

        [OperationContract(IsOneWay = true)] // Manage Friend Request [cite: 717]
        void respondToFriendRequest(string targetUsername, string requesterUsername, bool accepted);

        [OperationContract(IsOneWay = true)]
        void removeFriend(string username, string friendToRemove);

        [OperationContract] // Invite FriendToGameByEmail [cite: 718]
        OperationResultDto inviteFriendToGameByEmail(string fromUsername, string friendEmail, string matchCode);
    }

    [ServiceContract]
    public interface ISocialServiceCallback
    {
        [OperationContract(IsOneWay = true)]
        void notifyFriendRequest(string fromUsername);

        [OperationContract(IsOneWay = true)]
        void notifyFriendResponse(string fromUsername, bool accepted);

        [OperationContract(IsOneWay = true)] // Notifica cambio de estado (online, in game, offline)
        void notifyFriendStatusChanged(string friendUsername, bool isOnline);
    }
}
