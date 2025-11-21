using GuessMyMessServer.Contracts.DataContracts;
using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.ServiceContracts
{
    [ServiceContract(CallbackContract = typeof(ISocialServiceCallback))]
    public interface ISocialService
    {
        [OperationContract(IsOneWay = true)]
        void Connect(string username);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<List<FriendDto>> GetFriendsListAsync(string username);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<List<FriendRequestInfoDto>> GetFriendRequestsAsync(string username);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<List<UserProfileDto>> SearchUsersAsync(string searchUsername, string requesterUsername);

        [OperationContract(IsOneWay = true)]
        void SendFriendRequest(string requesterUsername, string targetUsername);

        [OperationContract(IsOneWay = true)]
        void RespondToFriendRequest(string targetUsername, string requesterUsername, bool accepted);

        [OperationContract(IsOneWay = true)]
        void RemoveFriend(string username, string friendToRemove);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<OperationResultDto> InviteFriendToGameByEmailAsync(string fromUsername, string friendEmail, string matchCode);

        [OperationContract(IsOneWay = true)]
        void SendDirectMessage(DirectMessageDto message);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        Task<List<FriendDto>> GetConversationsAsync(string username);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))] 
        Task<List<DirectMessageDto>> GetConversationHistoryAsync(string user1, string user2);

        [OperationContract(IsOneWay = true)]
        void Disconnect(string username);
    }

    [ServiceContract]
    public interface ISocialServiceCallback
    {
        [OperationContract(IsOneWay = true)]
        void NotifyFriendRequest(string fromUsername);

        [OperationContract(IsOneWay = true)]
        void NotifyFriendResponse(string fromUsername, bool accepted);

        [OperationContract(IsOneWay = true)]
        void NotifyFriendStatusChanged(string friendUsername, string status);

        [OperationContract(IsOneWay = true)]
        void NotifyMessageReceived(DirectMessageDto message);
    }
}