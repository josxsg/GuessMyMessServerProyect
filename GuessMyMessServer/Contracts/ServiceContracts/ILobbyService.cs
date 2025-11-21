using System.ServiceModel;
using GuessMyMessServer.Contracts.DataContracts;

namespace GuessMyMessServer.Contracts.ServiceContracts
{
    [ServiceContract(CallbackContract = typeof(ILobbyServiceCallback))]
    public interface ILobbyService
    {
        [OperationContract(IsOneWay = true)]
        void ConnectToLobby(string username, string matchId);

        [OperationContract(IsOneWay = true)]
        void SendLobbyMessage(string senderUsername, string matchId, string message);

        [OperationContract(IsOneWay = true)]
        void StartGame(string hostUsername, string matchId);

        [OperationContract(IsOneWay = true)]
        void LeaveLobby(string username, string matchId);

        [OperationContract(IsOneWay = true)]
        void KickPlayer(string hostUsername, string playerToKickUsername, string matchId);

        [OperationContract(IsOneWay = true)]
        void StartKickVote(string voterUsername, string targetUsername, string matchId);

        [OperationContract(IsOneWay = true)]
        void SubmitKickVote(string voterUsername, string targetUsername, string matchId, bool vote);
    }

    [ServiceContract]
    public interface ILobbyServiceCallback
    {
        [OperationContract(IsOneWay = true)]
        void UpdateLobbyState(LobbyStateDto lobbyStateDto);

        [OperationContract(IsOneWay = true)]
        void ReceiveLobbyMessage(ChatMessageDto messageDto);

        [OperationContract(IsOneWay = true)]
        void OnGameStarting(int countdownSeconds);

        [OperationContract(IsOneWay = true)]
        void OnGameStarted();

        [OperationContract(IsOneWay = true)]
        void KickedFromLobby(string reason);

        [OperationContract(IsOneWay = true)]
        void UpdateKickVote(string targetUsername, int currentVotes, int votesNeeded);
    }
}