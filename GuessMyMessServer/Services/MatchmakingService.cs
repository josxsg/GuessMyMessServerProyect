using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession)]
    public class MatchmakingService : IMatchmakingService
    {
        private IMatchmakingServiceCallback callback;

        public MatchmakingService()
        {
            callback = OperationContext.Current.GetCallbackChannel<IMatchmakingServiceCallback>();
        }

        public List<MatchInfoDto> GetPublicMatches()
        {
            throw new NotImplementedException();
        }

        public OperationResultDto CreateMatch(string hostUsername, LobbySettingsDto settings)
        {
            throw new NotImplementedException();
        }

        public void JoinPublicMatch(string username, string matchId)
        {
            throw new NotImplementedException();
        }

        public OperationResultDto JoinPrivateMatch(string username, string matchCode)
        {
            throw new NotImplementedException();
        }

        public void InviteToMatch(string inviterUsername, string invitedUsername, string matchId)
        {
            throw new NotImplementedException();
        }
    }
}
