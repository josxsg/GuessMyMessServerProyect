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
        private static readonly Dictionary<string, string> _playerSelectedWords = new Dictionary<string, string>();
        private static readonly Dictionary<string, List<DrawingDto>> _matchDrawings = new Dictionary<string, List<DrawingDto>>();

        // --- MODIFICACIÓN NECESARIA ---
        // Necesitamos saber qué jugadores hay en cada partida para poder limpiarla.
        private static readonly Dictionary<string, List<string>> _matchPlayers = new Dictionary<string, List<string>>();

        // --- MODIFICACIÓN NECESARIA ---
        // Connect debe saber a qué partida (matchId) se une el jugador.
        public void Connect(string username, string matchId)
        {
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(matchId)) return;

            var callback = OperationContext.Current.GetCallbackChannel<IGameServiceCallback>();
            lock (connectedPlayers)
            {
                connectedPlayers[username] = callback;
            }

            // Registramos al jugador en la partida
            lock (_matchPlayers)
            {
                if (!_matchPlayers.ContainsKey(matchId))
                {
                    _matchPlayers[matchId] = new List<string>();
                }
                if (!_matchPlayers[matchId].Contains(username))
                {
                    _matchPlayers[matchId].Add(username);
                }
            }
            Console.WriteLine($"GameService: Jugador conectado: {username} a partida {matchId}");
        }

        // --- MODIFICACIÓN NECESARIA ---
        // Disconnect debe saber de qué partida (matchId) se va el jugador.
        public void Disconnect(string username, string matchId)
        {
            if (string.IsNullOrEmpty(username)) return;

            lock (connectedPlayers)
            {
                connectedPlayers.Remove(username);
            }

            lock (_playerSelectedWords)
            {
                // Limpiamos la palabra de ese jugador
                _playerSelectedWords.Remove(username);
            }

            // Verificamos si era el último jugador de la partida
            lock (_matchPlayers)
            {
                if (matchId != null && _matchPlayers.ContainsKey(matchId))
                {
                    _matchPlayers[matchId].Remove(username);

                    // Si la lista de jugadores de esa partida queda vacía, llamamos a la limpieza
                    if (_matchPlayers[matchId].Count == 0)
                    {
                        ClearMatchData(matchId);
                    }
                }
            }
            Console.WriteLine($"GameService: Jugador desconectado: {username}");
        }

        public void SelectWord(string username, string matchId, string selectedWord)
        {
            lock (_playerSelectedWords)
            {
                _playerSelectedWords[username] = selectedWord;
            }
            Console.WriteLine($"GameService: Jugador {username} seleccionó '{selectedWord}' en partida {matchId}");
        }

        public async Task<List<WordDto>> GetRandomWordsAsync()
        {
            // ... (Tu código existente) ...
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
                Console.WriteLine($"Error GetRandomWords: {ex.Message}");
                throw new FaultException(ex.Message);
            }
        }

        public void SubmitDrawing(string username, string matchId, byte[] drawingData)
        {
            // ... (Tu código existente para guardar en _matchDrawings) ...
            try
            {
                string wordToSave = "Unknown";
                lock (_playerSelectedWords)
                {
                    if (_playerSelectedWords.ContainsKey(username))
                    {
                        wordToSave = _playerSelectedWords[username];
                    }
                }

                var newDrawing = new DrawingDto
                {
                    OwnerUsername = username,
                    DrawingData = drawingData,
                    WordKey = wordToSave,
                    IsGuessed = false
                };

                lock (_matchDrawings)
                {
                    if (!_matchDrawings.ContainsKey(matchId))
                    {
                        _matchDrawings[matchId] = new List<DrawingDto>();
                    }
                    newDrawing.DrawingId = _matchDrawings[matchId].Count + 1;
                    _matchDrawings[matchId].Add(newDrawing);
                }
                Console.WriteLine($"Dibujo recibido en memoria. Match: {matchId}, User: {username}, Word: {wordToSave}");
                CheckIfAllPlayersFinished(matchId);
            } // <-- LLAVE CORREGIDA: Cierre del 'try'
            catch (Exception ex)
            {
                Console.WriteLine($"Error en SubmitDrawing: {ex.Message}");
            } // <-- LLAVE CORREGIDA: Cierre del 'catch'
        } // <-- LLAVE CORREGIDA: Cierre del método 'SubmitDrawing'

        public void SubmitGuess(string username, string matchId, string guess)
        {
            throw new NotImplementedException();
        }

        public void SendInGameChatMessage(string username, string matchId, string message)
        {
            throw new NotImplementedException();
        }

        // --- MÉTODO DE LIMPIEZA AÑADIDO ---
        private void ClearMatchData(string matchId)
        {
            lock (_matchDrawings)
            {
                if (_matchDrawings.ContainsKey(matchId))
                {
                    _matchDrawings.Remove(matchId);
                    Console.WriteLine($"Dibujos en memoria de partida {matchId} eliminados.");
                }
            }

            lock (_matchPlayers)
            {
                if (_matchPlayers.ContainsKey(matchId))
                {
                    _matchPlayers.Remove(matchId);
                    Console.WriteLine($"Lista de jugadores de partida {matchId} eliminada.");
                }
            }

            // Las palabras en _playerSelectedWords se limpian individualmente
            // cuando cada jugador se desconecta (en el método Disconnect).
        }

        private void CheckIfAllPlayersFinished(string matchId)
        {
            int totalPlayers = 0;
            int totalDrawings = 0;

            lock (_matchPlayers)
            {
                if (_matchPlayers.ContainsKey(matchId))
                    totalPlayers = _matchPlayers[matchId].Count;
            }

            lock (_matchDrawings)
            {
                if (_matchDrawings.ContainsKey(matchId))
                    totalDrawings = _matchDrawings[matchId].Count;
            }

            // Si ya tenemos un dibujo por cada jugador, cambiamos de fase
            if (totalPlayers > 0 && totalDrawings >= totalPlayers)
            {
                Console.WriteLine($"Partida {matchId}: Todos los jugadores terminaron. Notificando...");
                NotifyGuessingPhaseStart(matchId);
            }
            else
            {
                Console.WriteLine($"Partida {matchId}: Faltan jugadores. {totalDrawings}/{totalPlayers} han terminado.");
            }
        }

        private void NotifyGuessingPhaseStart(string matchId)
        {
            List<string> playersInMatch;
            List<DrawingDto> drawings;

            lock (_matchPlayers)
            {
                if (!_matchPlayers.ContainsKey(matchId)) return;
                // Hacemos una copia para evitar problemas de concurrencia al iterar
                playersInMatch = new List<string>(_matchPlayers[matchId]);
            }

            lock (_matchDrawings)
            {
                if (!_matchDrawings.ContainsKey(matchId)) return;
                drawings = _matchDrawings[matchId];
            }

            // Lógica para decidir qué dibujo mostrar.
            // Por ahora, enviamos el primer dibujo de la lista a todos.
            DrawingDto firstDrawing = drawings.FirstOrDefault();
            if (firstDrawing == null)
            {
                Console.WriteLine($"Error: Notificando fase de adivinanza pero no hay dibujos para {matchId}.");
                return;
            }

            // Notificamos a cada jugador en la partida
            foreach (var username in playersInMatch)
            {
                lock (connectedPlayers)
                {
                    if (connectedPlayers.ContainsKey(username))
                    {
                        var callback = connectedPlayers[username];
                        try
                        {
                            // ¡ESTA ES LA LLAMADA AL CLIENTE QUE INICIA LA NAVEGACIÓN!
                            callback.OnGuessingPhaseStart(firstDrawing.DrawingData, firstDrawing.OwnerUsername);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Error al notificar a {username}: {ex.Message}");
                        }
                    }
                }
            }
        }
    } // <-- LLAVE CORREGIDA: Cierre de la clase 'GameService'
} // <-- LLAVE CORREGIDA: Cierre del 'namespace'