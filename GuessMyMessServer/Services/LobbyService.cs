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
            // Lógica para subscribir al usuario a los eventos del lobby
            throw new NotImplementedException();
        }

        public void sendLobbyMessage(string senderUsername, string matchId, string message)
        {
            // Lógica para enviar mensajes (solo frases preestablecidas) y notificar a los demás (usando el callback)
            throw new NotImplementedException();
        }

        public void startGame(string hostUsername, string matchId)
        {
            // Lógica para iniciar el conteo regresivo y notificar a todos (onGameStarting)
            throw new NotImplementedException();
        }

        public void leaveLobby(string username, string matchId)
        {
            // Lógica para desuscribir al usuario y notificar a los demás (updateLobbyState)
            throw new NotImplementedException();
        }

        public void kickPlayer(string hostUsername, string playerToKickUsername, string matchId)
        {
            // Lógica para expulsión por parte del host [cite: 855]
            throw new NotImplementedException();
        }

        public void startKickVote(string voterUsername, string targetUsername, string matchId)
        {
            // Lógica para iniciar la votación [cite: 856]
            throw new NotImplementedException();
        }

        public void submitKickVote(string voterUsername, string targetUsername, string matchId, bool vote)
        {
            // Lógica para procesar el voto [cite: 856]
            throw new NotImplementedException();
        }
    }
}
