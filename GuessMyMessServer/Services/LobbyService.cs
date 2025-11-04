using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.ServiceContracts;
using System;
using System.ServiceModel;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class LobbyService : ILobbyService
    {
        private readonly ILobbyServiceCallback _callback;
        private readonly LobbyLogic _lobbyLogic;
        private string _connectedUsername = null;
        private string _connectedMatchId = null;

        public LobbyService()
        {
            _callback = OperationContext.Current.GetCallbackChannel<ILobbyServiceCallback>();
            _lobbyLogic = new LobbyLogic();
            OperationContext.Current.Channel.Faulted += Channel_FaultedOrClosed;
            OperationContext.Current.Channel.Closed += Channel_FaultedOrClosed;
        }

        public void ConnectToLobby(string username, string matchId)
        {
            _connectedUsername = username;
            _connectedMatchId = matchId;
            _lobbyLogic.Connect(username, matchId, _callback);
        }

        public void SendLobbyMessage(string senderUsername, string matchId, string message)
        {
            if (_connectedUsername == senderUsername && _connectedMatchId == matchId)
            {
                _lobbyLogic.SendMessage(senderUsername, matchId, message);
            }
        }

        public void StartGame(string hostUsername, string matchId)
        {
            if (_connectedUsername == hostUsername && _connectedMatchId == matchId)
            {
                _lobbyLogic.StartGame(hostUsername, matchId);
            }
        }

        public void LeaveLobby(string username, string matchId)
        {
            if (_connectedUsername == username && _connectedMatchId == matchId)
            {
                string user = _connectedUsername;
                string match = _connectedMatchId;
                _connectedUsername = null;
                _connectedMatchId = null;
                _lobbyLogic.Disconnect(user, match);
            }
        }

        public void KickPlayer(string hostUsername, string playerToKickUsername, string matchId)
        {
            if (_connectedUsername == hostUsername && _connectedMatchId == matchId)
            {
                _lobbyLogic.KickPlayer(hostUsername, playerToKickUsername, matchId);
            }
        }

        public void StartKickVote(string voterUsername, string targetUsername, string matchId)
        {
            if (_connectedUsername == voterUsername && _connectedMatchId == matchId)
            {
                _lobbyLogic.StartKickVote(voterUsername, targetUsername, matchId);
            }
        }

        public void SubmitKickVote(string voterUsername, string targetUsername, string matchId, bool vote)
        {
            if (_connectedUsername == voterUsername && _connectedMatchId == matchId)
            {
                _lobbyLogic.SubmitKickVote(voterUsername, targetUsername, matchId, vote);
            }
        }

        private void Channel_FaultedOrClosed(object sender, EventArgs e)
        {
            Console.WriteLine($"WCF channel faulted or closed for user: {_connectedUsername ?? "Unknown"} in match: {_connectedMatchId ?? "None"}");
            if (!string.IsNullOrEmpty(_connectedUsername) && !string.IsNullOrEmpty(_connectedMatchId))
            {
                _lobbyLogic.Disconnect(_connectedUsername, _connectedMatchId);
                _connectedUsername = null;
                _connectedMatchId = null;
            }
            if (sender is IContextChannel channel)
            {
                channel.Faulted -= Channel_FaultedOrClosed;
                channel.Closed -= Channel_FaultedOrClosed;
            }
        }
    }
}
