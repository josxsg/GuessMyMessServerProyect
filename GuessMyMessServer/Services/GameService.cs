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
            // Lógica para registrar la palabra elegida [cite: 740]
            throw new NotImplementedException();
        }

        public void submitDrawing(string username, string matchId, byte[] drawingData)
        {
            // Lógica para recibir y almacenar el dibujo [cite: 741]
            throw new NotImplementedException();
        }

        public void submitGuess(string username, string matchId, string guess)
        {
            // Lógica para procesar la adivinanza y calcular puntos [cite: 742, 825]
            throw new NotImplementedException();
        }

        public void sendInGameChatMessage(string username, string matchId, string message)
        {
            // Lógica para enviar el mensaje de chat in-game [cite: 743]
            throw new NotImplementedException();
        }
    }
}
