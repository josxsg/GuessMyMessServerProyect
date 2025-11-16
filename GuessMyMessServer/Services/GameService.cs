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
        // Almacena las adivinanzas de cada jugador por partida
        private static readonly Dictionary<string, List<GuessDto>> _matchGuesses = new Dictionary<string, List<GuessDto>>();

        // Almacena el índice del dibujo que se está adivinando actualmente en la partida
        private static readonly Dictionary<string, int> _matchCurrentDrawingIndex = new Dictionary<string, int>();

        // Almacena los puntajes actuales de la partida
        private static readonly Dictionary<string, List<PlayerScoreDto>> _matchScores = new Dictionary<string, List<PlayerScoreDto>>();
        private const int SecondsPerGuess = 30;

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

        public void SendInGameChatMessage(string username, string matchId, string message)
        {
            List<string> playersInMatch;
            lock (_matchPlayers)
            {
                if (!_matchPlayers.ContainsKey(matchId)) return;
                playersInMatch = new List<string>(_matchPlayers[matchId]); // Copia para iterar
            }

            // Notificamos a cada jugador en la partida
            foreach (var playerUsername in playersInMatch)
            {
                lock (connectedPlayers)
                {
                    if (connectedPlayers.ContainsKey(playerUsername))
                    {
                        var callback = connectedPlayers[playerUsername];
                        try
                        {
                            // ¡NUEVO CALLBACK! Debes añadir OnInGameMessageReceived a IGameServiceCallback
                            callback.OnInGameMessageReceived(username, message);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Error al enviar chat a {playerUsername}: {ex.Message}");
                            // Podrías remover al jugador si la conexión falla
                        }
                    }
                }
            }
        }

        // --- IMPLEMENTACIÓN DE ADIVINANZA ---
        public void SubmitGuess(string username, string matchId, int drawingId, string guess)
        {
            DrawingDto currentDrawing = null;
            lock (_matchDrawings)
            {
                if (_matchDrawings.ContainsKey(matchId))
                {
                    currentDrawing = _matchDrawings[matchId].FirstOrDefault(d => d.DrawingId == drawingId);
                }
            }

            if (currentDrawing == null)
            {
                Console.WriteLine($"Error en SubmitGuess: No se encontró el dibujo {drawingId} en la partida {matchId}");
                return;
            }

            // Comprobar si la respuesta es correcta
            bool isCorrect = string.Equals(guess, currentDrawing.WordKey, StringComparison.OrdinalIgnoreCase);

            // Guardar la adivinanza
            var newGuess = new GuessDto
            {
                GuesserUsername = username,
                DrawingId = drawingId,
                GuessText = guess,
                IsCorrect = isCorrect,
                WordKey = currentDrawing.WordKey // Incluimos la palabra correcta para mostrarla después
            };

            lock (_matchGuesses)
            {
                if (!_matchGuesses.ContainsKey(matchId))
                {
                    _matchGuesses[matchId] = new List<GuessDto>();
                }
                // Evitar duplicados si el jugador envía varias veces
                _matchGuesses[matchId].RemoveAll(g => g.GuesserUsername == username && g.DrawingId == drawingId);
                _matchGuesses[matchId].Add(newGuess);
            }

            // Actualizar puntaje
            lock (_matchScores)
            {
                var playerToScore = _matchScores[matchId].FirstOrDefault(p => p.Username == username);
                if (playerToScore != null && isCorrect)
                {
                    // (Lógica de puntos simple, puedes hacerla basada en tiempo)
                    playerToScore.Score += 50;
                }

                // TODO: Dar puntos al dibujante (p.ej. 10 puntos por cada acierto)
                var artist = _matchScores[matchId].FirstOrDefault(p => p.Username == currentDrawing.OwnerUsername);
                if (artist != null && isCorrect)
                {
                    artist.Score += 10;
                }
            }


            // --- Comprobar si todos han adivinado ---
            CheckIfAllGuessesForCurrentDrawingAreIn(matchId, currentDrawing);
        }

        private void CheckIfAllGuessesForCurrentDrawingAreIn(string matchId, DrawingDto currentDrawing)
        {
            int totalPlayers = 0;
            List<string> playersInMatch;
            lock (_matchPlayers)
            {
                if (!_matchPlayers.ContainsKey(matchId)) return;
                playersInMatch = _matchPlayers[matchId];
                totalPlayers = playersInMatch.Count;
            }

            int guessesForThisDrawing = 0;
            lock (_matchGuesses)
            {
                if (_matchGuesses.ContainsKey(matchId))
                {
                    guessesForThisDrawing = _matchGuesses[matchId].Count(g => g.DrawingId == currentDrawing.DrawingId);
                }
            }

            // Todos han adivinado (N-1 jugadores)
            if (guessesForThisDrawing >= (totalPlayers - 1))
            {
                Console.WriteLine($"Partida {matchId}: Todos adivinaron el dibujo {currentDrawing.DrawingId}. Pasando al siguiente...");

                // --- LÓGICA CAMBIADA ---
                // ¡Ya no enviamos OnShowAnswers!
                // ¡Ya no hay Task.Delay!
                // Simplemente llamamos al método que decide qué hacer a continuación.
                GoToNextDrawingOrAnswersPhase(matchId);
            }
        }

        private void GoToNextDrawingOrAnswersPhase(string matchId)
        {
            int nextDrawingIndex = 0;
            lock (_matchCurrentDrawingIndex)
            {
                _matchCurrentDrawingIndex[matchId]++;
                nextDrawingIndex = _matchCurrentDrawingIndex[matchId];
            }

            List<DrawingDto> drawings;
            lock (_matchDrawings)
            {
                drawings = _matchDrawings[matchId];
            }

            List<string> playersInMatch;
            lock (_matchPlayers)
            {
                playersInMatch = new List<string>(_matchPlayers[matchId]);
            }

            if (nextDrawingIndex < drawings.Count)
            {
                // --- A. AÚN HAY DIBUJOS POR ADIVINAR ---
                DrawingDto nextDrawing = drawings[nextDrawingIndex];
                Console.WriteLine($"Partida {matchId}: Pasando al siguiente dibujo {nextDrawing.DrawingId} ({nextDrawing.OwnerUsername})");

                // Enviamos el siguiente dibujo a todos
                foreach (var playerUsername in playersInMatch)
                {
                    lock (connectedPlayers)
                    {
                        if (connectedPlayers.ContainsKey(playerUsername))
                        {
                            try
                            {
                                connectedPlayers[playerUsername].OnShowNextDrawing(nextDrawing);
                            }
                            catch (Exception ex) { Console.WriteLine($"Error en OnShowNextDrawing para {playerUsername}: {ex.Message}"); }
                        }
                    }
                }
            }
            else
            {
                // --- B. SE ACABARON LOS DIBUJOS POR ADIVINAR ---
                Console.WriteLine($"Partida {matchId}: Fase de adivinanza terminada. Pasando a mostrar respuestas...");

                // 1. Recopilamos TODOS los datos de la partida
                List<DrawingDto> allDrawings = drawings; // Ya la tenemos
                List<GuessDto> allGuesses;
                List<PlayerScoreDto> currentScores;

                lock (_matchGuesses)
                {
                    allGuesses = _matchGuesses.ContainsKey(matchId) ? new List<GuessDto>(_matchGuesses[matchId]) : new List<GuessDto>();
                }
                lock (_matchScores)
                {
                    currentScores = new List<PlayerScoreDto>(_matchScores[matchId]);
                }

                // 2. Enviamos el NUEVO callback a todos
                foreach (var playerUsername in playersInMatch)
                {
                    lock (connectedPlayers)
                    {
                        if (connectedPlayers.ContainsKey(playerUsername))
                        {
                            try
                            {
                                // ¡NUEVO CALLBACK! (Recuerda actualizar tu referencia de servicio)
                                connectedPlayers[playerUsername].OnAnswersPhaseStart(
                                    allDrawings.ToArray(),
                                    allGuesses.ToArray(),
                                    currentScores.ToArray());
                            }
                            catch (Exception ex) { Console.WriteLine($"Error en OnAnswersPhaseStart para {playerUsername}: {ex.Message}"); }
                        }
                    }
                }

                // 3. Programamos el FIN DE JUEGO (OnGameEnd)
                // El servidor esperará a que el cliente termine de mostrar todas las respuestas.
                int totalItemsToShow = allDrawings.Count + allGuesses.Count;
                int delaySeconds = (totalItemsToShow * SecondsPerGuess) + 5; // +5s de colchón

                Console.WriteLine($"Partida {matchId}: Programando fin de juego en {delaySeconds} segundos.");
                Task.Delay(TimeSpan.FromSeconds(delaySeconds)).ContinueWith(t =>
                {
                    NotifyGameEnd(matchId);
                });
            }
        }

        private void NotifyGameEnd(string matchId)
        {
            Console.WriteLine($"Partida {matchId}: Fin de la partida.");
            List<PlayerScoreDto> finalScores;

            // Es posible que los datos ya se hayan limpiado si los jugadores se fueron.
            // Verificamos si aún existen.
            lock (_matchScores)
            {
                if (!_matchScores.ContainsKey(matchId))
                {
                    Console.WriteLine($"Partida {matchId}: No se pueden enviar puntajes, ya fue limpiada.");
                    return;
                }
                finalScores = _matchScores[matchId]
                    .OrderByDescending(s => s.Score)
                    .ToList();
            }

            List<string> playersInMatch;
            lock (_matchPlayers)
            {
                if (!_matchPlayers.ContainsKey(matchId)) return;
                playersInMatch = new List<string>(_matchPlayers[matchId]);
            }

            foreach (var playerUsername in playersInMatch)
            {
                lock (connectedPlayers)
                {
                    if (connectedPlayers.ContainsKey(playerUsername))
                    {
                        try
                        {
                            connectedPlayers[playerUsername].OnGameEnd(finalScores);
                        }
                        catch (Exception ex) { Console.WriteLine($"Error en OnGameEnd para {playerUsername}: {ex.Message}"); }
                    }
                }
            }

            // Limpiamos la memoria de esta partida DESPUÉS de enviar el fin.
            ClearMatchData(matchId);
        }

        // --- MÉTODO DE LIMPIEZA AÑADIDO ---
        private void ClearMatchData(string matchId)
        {
            lock (_matchDrawings) { _matchDrawings.Remove(matchId); }
            lock (_matchPlayers) { _matchPlayers.Remove(matchId); }
            lock (_matchGuesses) { _matchGuesses.Remove(matchId); }
            lock (_matchCurrentDrawingIndex) { _matchCurrentDrawingIndex.Remove(matchId); }
            lock (_matchScores) { _matchScores.Remove(matchId); }

            // _playerSelectedWords se limpia cuando cada jugador se desconecta

            Console.WriteLine($"Datos en memoria de partida {matchId} eliminados.");
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
                playersInMatch = new List<string>(_matchPlayers[matchId]);
            }

            lock (_matchDrawings)
            {
                if (!_matchDrawings.ContainsKey(matchId)) return;
                drawings = _matchDrawings[matchId];
            }

            // --- INICIALIZACIÓN DE PARTIDA ---
            lock (_matchCurrentDrawingIndex)
            {
                _matchCurrentDrawingIndex[matchId] = 0; // Empezamos en el primer dibujo
            }
            lock (_matchScores)
            {
                // Inicializa los puntajes
                _matchScores[matchId] = playersInMatch
                    .Select(username => new PlayerScoreDto { Username = username, Score = 0 })
                    .ToList();
            }
            lock (_matchGuesses)
            {
                _matchGuesses.Remove(matchId); // Limpia adivinanzas anteriores si las hubo
            }
            // --- FIN INICIALIZACIÓN ---


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
                            // MODIFICACIÓN: Enviamos el DTO completo
                            // ¡DEBES CAMBIAR ESTO EN IGameServiceCallback!
                            callback.OnGuessingPhaseStart(firstDrawing);
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