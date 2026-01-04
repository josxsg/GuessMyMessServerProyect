using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;
using Autofac;
using GuessMyMessServer.AppStart;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.Properties.Langs;
using log4net;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class MatchmakingService : IMatchmakingService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(MatchmakingService));

        // Variables de sesión
        private string _connectedUsername;
        private IMatchmakingServiceCallback _callback;

        // Propiedad para resolver la lógica bajo demanda
        private static MatchmakingLogic Logic => Bootstrapper.Container.Resolve<MatchmakingLogic>();

        // Constructor WCF
        public MatchmakingService()
        {
            Bootstrapper.Init();
            InitializeCallback();
        }

        // Constructor Inyección
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
            if (!IsSessionValid(username)) return;
            try { PerformDisconnect(); }
            catch (Exception ex) { _log.Warn($"Error during manual disconnect for '{username}'", ex); }
        }

        public async Task<OperationResultDto> CreateMatch(string hostUsername, LobbySettingsDto settings)
        {
            if (!IsSessionValid(hostUsername)) ThrowSessionFault();
            _log.InfoFormat("Request CreateMatch from: {0}", hostUsername);
            return await Logic.CreateMatchAsync(hostUsername, settings);
        }

        public async Task<List<MatchInfoDto>> GetPublicMatches()
        {
            // Logic.GetPublicMatches() es síncrono (memoria), lo envolvemos en Task
            return await Task.Run(() => Logic.GetPublicMatches());
        }

        public async void JoinPublicMatch(string username, string matchId)
        {
            if (!IsSessionValid(username))
            {
                NotifyCallbackError(Lang.Error_SessionMismatch);
                return;
            }
            try
            {
                var result = await Logic.JoinPublicMatchAsync(username, matchId);
                _callback.MatchJoined(result.Data["MatchId"], result);
            }
            catch (FaultException<ServiceFaultDto> fEx)
            {
                _log.InfoFormat("JoinPublicMatch failed: {0}", fEx.Detail.Message);
                _callback.MatchJoined(null, new OperationResultDto { Success = false, Message = fEx.Detail.Message });
            }
            catch (Exception ex)
            {
                _log.Error($"Critical error joining public match '{matchId}'", ex);
                _callback.MatchJoined(null, new OperationResultDto { Success = false, Message = Lang.Error_ServerGeneric });
            }
        }

        public async Task<OperationResultDto> JoinPrivateMatch(string username, string matchCode)
        {
            if (!IsSessionValid(username)) ThrowSessionFault();
            _log.Info($"Request JoinPrivateMatch from: {username} Code: {matchCode}");
            return await Logic.JoinPrivateMatchAsync(username, matchCode);
        }

        public void InviteToMatch(string inviterUsername, string invitedUsername, string matchId)
        {
            if (!IsSessionValid(inviterUsername)) return;
            try { Logic.InviteToMatch(inviterUsername, invitedUsername, matchId); }
            catch (Exception ex) { _log.Warn($"Error inviting {invitedUsername}", ex); }
        }

        public async Task InviteGuestByEmail(string inviterUsername, string targetEmail, string matchId)
        {
            if (!IsSessionValid(inviterUsername)) ThrowSessionFault();
            await Logic.InviteGuestByEmailAsync(inviterUsername, targetEmail, matchId);
        }

        #region Helpers
        private bool IsSessionValid(string username)
        {
            if (_connectedUsername == username) return true;
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
        private void NotifyCallbackError(string message)
        {
            try { _callback?.MatchmakingFailed(message); } catch { }
        }
        private void ThrowSessionFault()
        {
            throw new FaultException<ServiceFaultDto>(new ServiceFaultDto(ServiceErrorType.OperationFailed, Lang.Error_SessionMismatch), new FaultReason("Invalid Session"));
        }
        private void Channel_Closing(object sender, EventArgs e) { PerformDisconnect(); }
        private void Channel_Faulted(object sender, EventArgs e) { _log.Warn($"Channel faulted for user '{_connectedUsername}'."); PerformDisconnect(); }
        #endregion
    }
}