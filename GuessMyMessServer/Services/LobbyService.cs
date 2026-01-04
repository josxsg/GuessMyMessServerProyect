using System;
using System.ServiceModel;
using Autofac;
using GuessMyMessServer.AppStart;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.ServiceContracts;
using log4net;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class LobbyService : ILobbyService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(LobbyService));

        private string _connectedUsername;
        private string _connectedMatchId;

        private static LobbyLogic Logic => Bootstrapper.Container.Resolve<LobbyLogic>();

        public LobbyService()
        {
            Bootstrapper.Init();
            SubscribeToChannelEvents();
        }

        public LobbyService(LobbyLogic lobbyLogic)
        {
            SubscribeToChannelEvents();
        }

        private void SubscribeToChannelEvents()
        {
            IContextChannel channel = OperationContext.Current.Channel;
            channel.Faulted += Channel_FaultedOrClosed;
            channel.Closed += Channel_FaultedOrClosed;
        }

        public async void ConnectToLobby(string username, string matchId)
        {
            try
            {
                _connectedUsername = username;
                _connectedMatchId = matchId;
                _log.InfoFormat("LobbyService: Connect request '{0}' -> Lobby '{1}'.", username, matchId);
                await Logic.ConnectAsync(username, matchId);
            }
            catch (Exception ex) { _log.Error($"Error connecting '{username}'", ex); }
        }

        public void SendLobbyMessage(string senderUsername, string matchId, string message)
        {
            if (ValidateSession(senderUsername, matchId))
                Logic.SendMessage(senderUsername, matchId, message);
        }

        public void StartGame(string hostUsername, string matchId)
        {
            if (ValidateSession(hostUsername, matchId))
                Logic.StartGame(hostUsername, matchId);
        }

        public void LeaveLobby(string username, string matchId)
        {
            if (ValidateSession(username, matchId))
                PerformDisconnect();
        }

        public void KickPlayer(string hostUsername, string playerToKickUsername, string matchId)
        {
            if (ValidateSession(hostUsername, matchId))
                Logic.KickPlayer(hostUsername, playerToKickUsername, matchId);
        }

        public void StartKickVote(string voterUsername, string targetUsername, string matchId) { }
        public void SubmitKickVote(string voterUsername, string targetUsername, string matchId, bool vote) { }

        private bool ValidateSession(string username, string matchId) => _connectedUsername == username && _connectedMatchId == matchId;

        private void PerformDisconnect()
        {
            if (!string.IsNullOrEmpty(_connectedUsername))
            {
                Logic.Disconnect(_connectedUsername, _connectedMatchId);
                _connectedUsername = null;
            }
        }

        private void Channel_FaultedOrClosed(object sender, EventArgs e) { PerformDisconnect(); }
    }
}