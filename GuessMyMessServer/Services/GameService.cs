using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class GameService : IGameService
    {
        private static readonly Dictionary<string, IGameServiceCallback> connectedPlayers = new Dictionary<string, IGameServiceCallback>();

        public void Connect(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                return;
            }

            var callback = OperationContext.Current.GetCallbackChannel<IGameServiceCallback>();
            lock (connectedPlayers)
            {
                connectedPlayers[username] = callback;
            }
            Console.WriteLine($"GameService: Jugador conectado: {username}");
        }

        public void Disconnect(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                return;
            }

            lock (connectedPlayers)
            {
                connectedPlayers.Remove(username);
            }
            Console.WriteLine($"GameService: Jugador desconectado: {username}");
        }


        public void SelectWord(string username, string matchId, string selectedWord)
        {
            Console.WriteLine($"GameService: Jugador {username} ha seleccionado la palabra '{selectedWord}' para la partida {matchId}");
        }

        public async Task<List<WordDto>> GetRandomWordsAsync()
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var logic = new GameLogic(context);
                    return await logic.GetRandomWordsAsync();
                }
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public void SubmitDrawing(string username, string matchId, byte[] drawingData)
        {
            throw new NotImplementedException();
        }

        public void SubmitGuess(string username, string matchId, string guess)
        {
            throw new NotImplementedException();
        }

        public void SendInGameChatMessage(string username, string matchId, string message)
        {
            throw new NotImplementedException();
        }
    }
}