using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;

namespace GuessMyMessServer.Contracts.ServiceContracts
{
    [ServiceContract(CallbackContract = typeof(ILobbyServiceCallback))] 
    public interface ILobbyService
    {
        [OperationContract(IsOneWay = true)] 
        void connectToLobby(string username, string matchId);

        [OperationContract(IsOneWay = true)] 
        void sendLobbyMessage(string senderUsername, string matchId, string message);

        [OperationContract(IsOneWay = true)] 
        void startGame(string hostUsername, string matchId);

        [OperationContract(IsOneWay = true)] 
        void leaveLobby(string username, string matchId);

        [OperationContract(IsOneWay = true)] 
        void kickPlayer(string hostUsername, string playerToKickUsername, string matchId);

        [OperationContract(IsOneWay = true)] 
        void startKickVote(string voterUsername, string targetUsername, string matchId);

        [OperationContract(IsOneWay = true)] 
        void submitKickVote(string voterUsername, string targetUsername, string matchId, bool vote);
    }

    [ServiceContract]
    public interface ILobbyServiceCallback
    {
        [OperationContract(IsOneWay = true)] 
        void updateLobbyState(LobbyStateDto lobbyStateDto);

        [OperationContract(IsOneWay = true)] 
        void receiveLobbyMessage(ChatMessageDto messageDto);

        [OperationContract(IsOneWay = true)]
        void onGameStarting(int countdownSeconds);

        [OperationContract(IsOneWay = true)] 
        void onGameStarted();

        [OperationContract(IsOneWay = true)]
        void kickedFromLobby(string reason);

        [OperationContract(IsOneWay = true)]
        void updateKickVote(string targetUsername, int currentVotes, int votesNeeded);
    }
}
