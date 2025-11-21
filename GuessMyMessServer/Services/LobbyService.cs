using System;
using System.ServiceModel;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.ServiceContracts;
using log4net;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class LobbyService : ILobbyService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(LobbyService));

        private readonly ILobbyServiceCallback _callback;
        private readonly LobbyLogic _lobbyLogic;
        private string _connectedUsername = null;
        private string _connectedMatchId = null;

        public LobbyService()
        {
            _callback = OperationContext.Current.GetCallbackChannel<ILobbyServiceCallback>();
            _lobbyLogic = new LobbyLogic();

            IContextChannel channel = OperationContext.Current.Channel;
            channel.Faulted += Channel_FaultedOrClosed;
            channel.Closed += Channel_FaultedOrClosed;
        }

        public void ConnectToLobby(string username, string matchId)
        {
            try
            {
                _connectedUsername = username;
                _connectedMatchId = matchId;
                _log.Info($"LobbyService: Connection request from '{username}' to lobby '{matchId}'.");

                _lobbyLogic.Connect(username, matchId, _callback);
            }
            catch (Exception ex)
            {
                _log.Error($"Error connecting '{username}' to lobby '{matchId}'", ex);
            }
        }

        public void SendLobbyMessage(string senderUsername, string matchId, string message)
        {
            try
            {
                if (ValidateSession(senderUsername, matchId))
                {
                    _lobbyLogic.SendMessage(senderUsername, matchId, message);
                }
            }
            catch (Exception ex)
            {
                _log.Warn($"Error sending lobby message from '{senderUsername}'", ex);
            }
        }

        public void StartGame(string hostUsername, string matchId)
        {
            try
            {
                if (ValidateSession(hostUsername, matchId))
                {
                    _log.Info($"LobbyService: StartGame requested by '{hostUsername}'.");
                    _lobbyLogic.StartGame(hostUsername, matchId);
                }
            }
            catch (Exception ex)
            {
                _log.Error($"Error starting game in lobby '{matchId}'", ex);
            }
        }

        public void LeaveLobby(string username, string matchId)
        {
            try
            {
                if (ValidateSession(username, matchId))
                {
                    _log.Info($"LobbyService: '{username}' is leaving lobby '{matchId}'.");
                    PerformDisconnect();
                }
            }
            catch (Exception ex)
            {
                _log.Warn($"Error processing leave lobby for '{username}'", ex);
            }
        }

        public void KickPlayer(string hostUsername, string playerToKickUsername, string matchId)
        {
            try
            {
                if (ValidateSession(hostUsername, matchId))
                {
                    _log.Info($"LobbyService: Kick request from '{hostUsername}' against '{playerToKickUsername}'.");
                    _lobbyLogic.KickPlayer(hostUsername, playerToKickUsername, matchId);
                }
            }
            catch (Exception ex)
            {
                _log.Error($"Error kicking player '{playerToKickUsername}' from lobby '{matchId}'", ex);
            }
        }

        public void StartKickVote(string voterUsername, string targetUsername, string matchId)
        {
            try
            {
                if (ValidateSession(voterUsername, matchId))
                {
                    _lobbyLogic.StartKickVote(voterUsername, targetUsername, matchId);
                }
            }
            catch (Exception ex)
            {
                _log.Warn($"Error starting kick vote in lobby '{matchId}'", ex);
            }
        }

        public void SubmitKickVote(string voterUsername, string targetUsername, string matchId, bool vote)
        {
            try
            {
                if (ValidateSession(voterUsername, matchId))
                {
                    _lobbyLogic.SubmitKickVote(voterUsername, targetUsername, matchId, vote);
                }
            }
            catch (Exception ex)
            {
                _log.Warn($"Error submitting kick vote in lobby '{matchId}'", ex);
            }
        }

        private bool ValidateSession(string username, string matchId)
        {
            if (_connectedUsername == username && _connectedMatchId == matchId)
            {
                return true;
            }

            _log.Warn($"Session validation failed. Request from: '{username}' (Match: {matchId}), Expected: '{_connectedUsername}' (Match: {_connectedMatchId})");
            return false;
        }

        private void PerformDisconnect()
        {
            if (!string.IsNullOrEmpty(_connectedUsername) && !string.IsNullOrEmpty(_connectedMatchId))
            {
                _lobbyLogic.Disconnect(_connectedUsername, _connectedMatchId);
                _connectedUsername = null;
                _connectedMatchId = null;
            }
        }

        private void Channel_FaultedOrClosed(object sender, EventArgs e)
        {
            string user = _connectedUsername ?? "Unknown";
            string match = _connectedMatchId ?? "None";

            _log.Warn($"WCF Channel faulted/closed for user '{user}' in lobby '{match}'. Cleaning up.");

            try
            {
                PerformDisconnect();
            }
            catch (Exception ex)
            {
                _log.Error("Error during channel cleanup.", ex);
            }
            finally
            {
                if (sender is IContextChannel channel)
                {
                    channel.Faulted -= Channel_FaultedOrClosed;
                    channel.Closed -= Channel_FaultedOrClosed;
                }
            }
        }
    }
}