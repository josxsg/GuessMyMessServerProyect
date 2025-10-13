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

        public List<MatchInfoDto> getPublicMatches()
        {
            throw new NotImplementedException();
        }

        public OperationResultDto createMatch(string hostUsername, LobbySettingsDto settings)
        {
            throw new NotImplementedException();
        }

        public void joinPublicMatch(string username, string matchId)
        {
            // Lógica para unir al jugador y transferirlo al LobbyService
            throw new NotImplementedException();
        }

        public OperationResultDto joinPrivateMatch(string username, string matchCode)
        {
            throw new NotImplementedException();
        }

        public void inviteToMatch(string inviterUsername, string invitedUsername, string matchId)
        {
            // Lógica para notificar al jugador invitado (usando el callback)
            throw new NotImplementedException();
        }
    }
}
