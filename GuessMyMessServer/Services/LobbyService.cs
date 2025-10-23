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

        public void connectToLobby(string username, string matchId)
        {
            throw new NotImplementedException();
        }

        public void sendLobbyMessage(string senderUsername, string matchId, string message)
        {
            throw new NotImplementedException();
        }

        public void startGame(string hostUsername, string matchId)
        {
            throw new NotImplementedException();
        }

        public void leaveLobby(string username, string matchId)
        {
            throw new NotImplementedException();
        }

        public void kickPlayer(string hostUsername, string playerToKickUsername, string matchId)
        {
            throw new NotImplementedException();
        }

        public void startKickVote(string voterUsername, string targetUsername, string matchId)
        {
            throw new NotImplementedException();
        }

        public void submitKickVote(string voterUsername, string targetUsername, string matchId, bool vote)
        {
            throw new NotImplementedException();
        }
    }
}
