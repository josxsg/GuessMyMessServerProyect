using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.ServiceContracts;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession)]
    public class LobbyService : ILobbyService
    {
        private ILobbyServiceCallback callback;

        public LobbyService()
        {
            callback = OperationContext.Current.GetCallbackChannel<ILobbyServiceCallback>();
        }

        public void ConnectToLobby(string username, string matchId)
        {
            throw new NotImplementedException();
        }

        public void SendLobbyMessage(string senderUsername, string matchId, string message)
        {
            throw new NotImplementedException();
        }

        public void StartGame(string hostUsername, string matchId)
        {
            throw new NotImplementedException();
        }

        public void LeaveLobby(string username, string matchId)
        {
            throw new NotImplementedException();
        }

        public void KickPlayer(string hostUsername, string playerToKickUsername, string matchId)
        {
            throw new NotImplementedException();
        }

        public void StartKickVote(string voterUsername, string targetUsername, string matchId)
        {
            throw new NotImplementedException();
        }

        public void SubmitKickVote(string voterUsername, string targetUsername, string matchId, bool vote)
        {
            throw new NotImplementedException();
        }
    }
}
