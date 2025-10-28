using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class MatchmakingService : IMatchmakingService
    {
        private IMatchmakingServiceCallback callback;
        private string connectedUsername;

        public MatchmakingService()
        {
            this.callback = OperationContext.Current.GetCallbackChannel<IMatchmakingServiceCallback>();
            OperationContext.Current.Channel.Closing += Channel_Closing;
            OperationContext.Current.Channel.Faulted += Channel_Faulted;
        }

        private void Channel_Faulted(object sender, EventArgs e)
        {
            DisconnectUser();
        }

        private void Channel_Closing(object sender, EventArgs e)
        {
            DisconnectUser();
        }

        private void DisconnectUser()
        {
            if (!string.IsNullOrEmpty(connectedUsername))
            {
                MatchmakingLogic.DisconnectUser(connectedUsername);
                connectedUsername = null;
            }
        }

        public void Connect(string username)
        {
            this.connectedUsername = username;
            MatchmakingLogic.ConnectUser(username, callback);
        }

        public void Disconnect(string username)
        {
            DisconnectUser();
        }

        public List<MatchInfoDto> GetPublicMatches()
        {
            return MatchmakingLogic.GetPublicMatches();
        }

        public OperationResultDto CreateMatch(string hostUsername, LobbySettingsDto settings)
        {
            if (hostUsername != connectedUsername)
            {
                return new OperationResultDto { Success = false, Message = "Auth mismatch." };
            }
            return MatchmakingLogic.CreateMatch(hostUsername, settings);
        }

        public void JoinPublicMatch(string username, string matchId)
        {
            if (username != connectedUsername)
            {
                callback.MatchmakingFailed("Auth mismatch.");
                return;
            }
            MatchmakingLogic.JoinPublicMatch(username, matchId);
        }

        public OperationResultDto JoinPrivateMatch(string username, string matchCode)
        {
            if (username != connectedUsername)
            {
                return new OperationResultDto { Success = false, Message = "Auth mismatch." };
            }
            return MatchmakingLogic.JoinPrivateMatch(username, matchCode);
        }

        public void InviteToMatch(string inviterUsername, string invitedUsername, string matchId)
        {
            if (inviterUsername != connectedUsername)
            {
                callback.MatchmakingFailed("Auth mismatch.");
                return;
            }
            MatchmakingLogic.InviteToMatch(inviterUsername, invitedUsername, matchId);
        }
    }
}
