using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;

namespace GuessMyMessServer.Contracts.ServiceContracts
{
    [ServiceContract(CallbackContract = typeof(ILobbyServiceCallback))] // [cite: 726]
    public interface ILobbyService
    {
        [OperationContract(IsOneWay = true)] // ConnectToLobby [cite: 728]
        void connectToLobby(string username, string matchId);

        [OperationContract(IsOneWay = true)] // SendMessage (Chat preestablecido) [cite: 729]
        void sendLobbyMessage(string senderUsername, string matchId, string message);

        [OperationContract(IsOneWay = true)] // StartGame (Host) [cite: 730]
        void startGame(string hostUsername, string matchId);

        [OperationContract(IsOneWay = true)] // LeaveLobby [cite: 731]
        void leaveLobby(string username, string matchId);

        [OperationContract(IsOneWay = true)] // Expulsar (Host) [cite: 855]
        void kickPlayer(string hostUsername, string playerToKickUsername, string matchId);

        [OperationContract(IsOneWay = true)] // Iniciar votación de expulsión [cite: 856]
        void startKickVote(string voterUsername, string targetUsername, string matchId);

        [OperationContract(IsOneWay = true)] // Emitir voto [cite: 856]
        void submitKickVote(string voterUsername, string targetUsername, string matchId, bool vote);
    }

    [ServiceContract]
    public interface ILobbyServiceCallback
    {
        [OperationContract(IsOneWay = true)] // OnPlayerJoined / OnPlayerLeft [cite: 732, 733]
        void updateLobbyState(LobbyStateDto lobbyStateDto);

        [OperationContract(IsOneWay = true)] // OnLobbyMessage Received [cite: 734]
        void receiveLobbyMessage(ChatMessageDto messageDto);

        [OperationContract(IsOneWay = true)] // OnGameStarting (conteo regresivo) [cite: 736]
        void onGameStarting(int countdownSeconds);

        [OperationContract(IsOneWay = true)] // OnGameStarted [cite: 737]
        void onGameStarted();

        [OperationContract(IsOneWay = true)]
        void kickedFromLobby(string reason);

        [OperationContract(IsOneWay = true)]
        void updateKickVote(string targetUsername, int currentVotes, int votesNeeded);
    }
}
