using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;
using Autofac;
using GuessMyMessServer.AppStart;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using log4net;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class MatchmakingService : IMatchmakingService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(MatchmakingService));

        private string _connectedUsername;
        private IMatchmakingServiceCallback _callback;

        private static MatchmakingLogic Logic => Bootstrapper.Container.Resolve<MatchmakingLogic>();

        public MatchmakingService()
        {
            Bootstrapper.Init();
            InitializeCallback();
        }

        public MatchmakingService(MatchmakingLogic matchmakingLogic)
        {
            InitializeCallback();
        }

        private void InitializeCallback()
        {
            _callback = OperationContext.Current.GetCallbackChannel<IMatchmakingServiceCallback>();
            IContextChannel channel = OperationContext.Current.Channel;
            channel.Closing += Channel_Closing;
            channel.Faulted += Channel_Faulted;
        }

        public void Connect(string username)
        {
            try
            {
                _connectedUsername = username;
                _log.InfoFormat("MatchmakingService: User '{0}' connected (SessionId: {1}).",
                    username,
                    OperationContext.Current.SessionId);
                Logic.ConnectUser(username);
            }
            catch (Exception ex)
            {
                _log.Error($"Error connecting user '{username}' to matchmaking.", ex);
            }
        }

        public void Disconnect(string username)
        {
            if (!IsSessionValid(username))
            {
                return;
            }

            try
            {
                PerformDisconnect();
            }
            catch (Exception ex)
            {
                _log.Warn($"Error during manual disconnect for '{username}'", ex);
            }
        }

        public async Task<OperationResultDto> CreateMatch(string hostUsername, LobbySettingsDto settings)
        {
            if (!IsSessionValid(hostUsername))
            {
                return new OperationResultDto { Success = false, ErrorCode = ServiceErrorType.UserNotConnected, Message = "Session Mismatch" };
            }

            _log.InfoFormat("Request CreateMatch from: {0}", hostUsername);
            return await Logic.CreateMatchAsync(hostUsername, settings);
        }

        public async Task<List<MatchInfoDto>> GetPublicMatches()
        {
            return await Task.Run(() => Logic.GetPublicMatches());
        }

        public async void JoinPublicMatch(string username, string matchId)
        {
            if (!IsSessionValid(username))
            {
                _callback.MatchJoined(null, new OperationResultDto { Success = false, ErrorCode = ServiceErrorType.UserNotConnected, Message = "Session Invalid" });
                return;
            }

            try
            {
                var result = await Logic.JoinPublicMatchAsync(username, matchId);

                string joinedMatchId = result.Success ? result.Data["MatchId"] : null;

                _callback.MatchJoined(joinedMatchId, result);
            }
            catch (Exception ex)
            {
                _log.Error($"Critical error joining public match '{matchId}'", ex);
                _callback.MatchJoined(null, new OperationResultDto { Success = false, ErrorCode = ServiceErrorType.OperationFailed, Message = "Server Error" });
            }
        }

        public async Task<OperationResultDto> JoinPrivateMatch(string username, string matchCode)
        {
            if (!IsSessionValid(username))
            {
                return new OperationResultDto { Success = false, ErrorCode = ServiceErrorType.UserNotConnected, Message = "Session Invalid" };
            }

            _log.Info($"Request JoinPrivateMatch from: {username} Code: {matchCode}");
            return await Logic.JoinPrivateMatchAsync(username, matchCode);
        }

        public void InviteToMatch(string inviterUsername, string invitedUsername, string matchId)
        {
            if (!IsSessionValid(inviterUsername))
            {
                return;
            }

            try
            {
                Logic.InviteToMatch(inviterUsername, invitedUsername, matchId);
            }
            catch (Exception ex)
            {
                _log.Warn($"Error inviting {invitedUsername}", ex);
            }
        }

        public async Task InviteGuestByEmail(string inviterUsername, string targetEmail, string matchId)
        {
            if (!IsSessionValid(inviterUsername))
            {
                var fault = new ServiceFaultDto(ServiceErrorType.UserNotConnected, "Session Invalid");
                throw new FaultException<ServiceFaultDto>(fault, new FaultReason("Session Invalid"));
            }

            await Logic.InviteGuestByEmailAsync(inviterUsername, targetEmail, matchId);
        }

        private bool IsSessionValid(string username)
        {
            if (_connectedUsername == username)
            {
                return true;
            }
            _log.Warn($"Auth mismatch: Session owner '{_connectedUsername}' tried to act as '{username}'.");
            return false;
        }
        private void PerformDisconnect()
        {
            if (!string.IsNullOrEmpty(_connectedUsername))
            {
                Logic.DisconnectUser(_connectedUsername);
                _log.Info($"MatchmakingService: Session ended for '{_connectedUsername}'.");
                _connectedUsername = null;
            }
        }

        private void Channel_Closing(object sender, EventArgs e) { PerformDisconnect(); }
        private void Channel_Faulted(object sender, EventArgs e) { _log.Warn($"Channel faulted for user '{_connectedUsername}'."); PerformDisconnect(); }
    }
}