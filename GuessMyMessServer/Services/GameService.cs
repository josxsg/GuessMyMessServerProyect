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
    public class GameService : IGameService
    {
        private IGameServiceCallback callback;

        public GameService()
        {
            callback = OperationContext.Current.GetCallbackChannel<IGameServiceCallback>();
        }

        public void selectWord(string username, string matchId, string selectedWord)
        {
            throw new NotImplementedException();
        }

        public void submitDrawing(string username, string matchId, byte[] drawingData)
        {
            throw new NotImplementedException();
        }

        public void submitGuess(string username, string matchId, string guess)
        {
            throw new NotImplementedException();
        }

        public void sendInGameChatMessage(string username, string matchId, string message)
        {
            throw new NotImplementedException();
        }
    }
}
