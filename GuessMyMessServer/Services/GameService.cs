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
        private static readonly Dictionary<string, List<string>> _matchPlayers = new Dictionary<string, List<string>>();
        private static readonly Dictionary<string, List<GuessDto>> _matchGuesses = new Dictionary<string, List<GuessDto>>();
        private static readonly Dictionary<string, int> _matchCurrentDrawingIndex = new Dictionary<string, int>();
        private static readonly Dictionary<string, List<PlayerScoreDto>> _matchScores = new Dictionary<string, List<PlayerScoreDto>>();
        private const int SecondsPerGuess = 10;

        public void Connect(string username, string matchId)
        {
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(matchId)) return;

            var callback = OperationContext.Current.GetCallbackChannel<IGameServiceCallback>();
            lock (connectedPlayers)
            {
                connectedPlayers[username] = callback;
            }

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
            Console.WriteLine($"GameService: Player connected: {username} to match {matchId}");
        }

        public void Disconnect(string username, string matchId)
        {
            if (string.IsNullOrEmpty(username)) return;

            lock (connectedPlayers)
            {
                connectedPlayers.Remove(username);
            }

            lock (_playerSelectedWords)
            {
                _playerSelectedWords.Remove(username);
            }

            lock (_matchPlayers)
            {
                if (matchId != null && _matchPlayers.ContainsKey(matchId))
                {
                    _matchPlayers[matchId].Remove(username);

                    if (_matchPlayers[matchId].Count == 0)
                    {
                        ClearMatchData(matchId);
                    }
                }
            }
            Console.WriteLine($"GameService: Player disconnected: {username}");
        }

        public void SelectWord(string username, string matchId, string selectedWord)
        {
            lock (_playerSelectedWords)
            {
                _playerSelectedWords[username] = selectedWord;
            }
            Console.WriteLine($"GameService: Player {username} selected '{selectedWord}' in match {matchId}");
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
                Console.WriteLine($"Error GetRandomWords: {ex.Message}");
                throw new FaultException(ex.Message);
            }
        }

        public void SubmitDrawing(string username, string matchId, byte[] drawingData)
        {
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

                Console.WriteLine($"Drawing received in memory. Match: {matchId}, User: {username}, Word: {wordToSave}");
                CheckIfAllPlayersFinished(matchId);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in SubmitDrawing: {ex.Message}");
            }
        }

        public void SendInGameChatMessage(string username, string matchId, string message)
        {
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
                        var callback = connectedPlayers[playerUsername];
                        try
                        {
                            callback.OnInGameMessageReceived(username, message);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Error sending chat to {playerUsername}: {ex.Message}");
                        }
                    }
                }
            }
        }

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
                Console.WriteLine($"Error in SubmitGuess: Drawing {drawingId} not found in match {matchId}");
                return;
            }

            bool isCorrect = string.Equals(guess, currentDrawing.WordKey, StringComparison.OrdinalIgnoreCase);

            var newGuess = new GuessDto
            {
                GuesserUsername = username,
                DrawingId = drawingId,
                GuessText = guess,
                IsCorrect = isCorrect,
                WordKey = currentDrawing.WordKey
            };

            lock (_matchGuesses)
            {
                if (!_matchGuesses.ContainsKey(matchId))
                {
                    _matchGuesses[matchId] = new List<GuessDto>();
                }
                _matchGuesses[matchId].RemoveAll(g => g.GuesserUsername == username && g.DrawingId == drawingId);
                _matchGuesses[matchId].Add(newGuess);
            }

            lock (_matchScores)
            {
                var playerToScore = _matchScores[matchId].FirstOrDefault(p => p.Username == username);
                if (playerToScore != null && isCorrect)
                {
                    playerToScore.Score += 50;
                }

                var artist = _matchScores[matchId].FirstOrDefault(p => p.Username == currentDrawing.OwnerUsername);
                if (artist != null && isCorrect)
                {
                    artist.Score += 10;
                }
            }

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

            if (guessesForThisDrawing >= (totalPlayers - 1))
            {
                Console.WriteLine($"Match {matchId}: All players have guessed drawing {currentDrawing.DrawingId}. Moving to next...");
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
                DrawingDto nextDrawing = drawings[nextDrawingIndex];
                Console.WriteLine($"Match {matchId}: Moving to next drawing {nextDrawing.DrawingId} ({nextDrawing.OwnerUsername})");

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
                            catch (Exception ex)
                            {
                                Console.WriteLine($"Error in OnShowNextDrawing for {playerUsername}: {ex.Message}");
                            }
                        }
                    }
                }
            }
            else
            {
                Console.WriteLine($"Match {matchId}: Guessing phase finished. Showing answers...");

                List<DrawingDto> allDrawings = drawings;
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

                foreach (var playerUsername in playersInMatch)
                {
                    lock (connectedPlayers)
                    {
                        if (connectedPlayers.ContainsKey(playerUsername))
                        {
                            try
                            {
                                connectedPlayers[playerUsername].OnAnswersPhaseStart(
                                    allDrawings.ToArray(),
                                    allGuesses.ToArray(),
                                    currentScores.ToArray());
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine($"Error in OnAnswersPhaseStart for {playerUsername}: {ex.Message}");
                            }
                        }
                    }
                }

                int totalItemsToShow = allDrawings.Count + allGuesses.Count;
                int delaySeconds = (totalItemsToShow * SecondsPerGuess) + 5;

                Console.WriteLine($"Match {matchId}: Scheduling game end in {delaySeconds} seconds.");

                Task.Delay(TimeSpan.FromSeconds(delaySeconds)).ContinueWith(t =>
                {
                    NotifyGameEnd(matchId);
                });
            }
        }

        private void NotifyGameEnd(string matchId)
        {
            Console.WriteLine($"Match {matchId}: Game finished.");

            List<PlayerScoreDto> finalScores;

            lock (_matchScores)
            {
                if (!_matchScores.ContainsKey(matchId))
                {
                    Console.WriteLine($"Match {matchId}: Cannot send scores, match already cleared.");
                    return;
                }
                finalScores = _matchScores[matchId].OrderByDescending(s => s.Score).ToList();
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
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Error in OnGameEnd for {playerUsername}: {ex.Message}");
                        }
                    }
                }
            }

            ClearMatchData(matchId);
        }

        private void ClearMatchData(string matchId)
        {
            lock (_matchDrawings) { _matchDrawings.Remove(matchId); }
            lock (_matchPlayers) { _matchPlayers.Remove(matchId); }
            lock (_matchGuesses) { _matchGuesses.Remove(matchId); }
            lock (_matchCurrentDrawingIndex) { _matchCurrentDrawingIndex.Remove(matchId); }
            lock (_matchScores) { _matchScores.Remove(matchId); }

            Console.WriteLine($"Memory data for match {matchId} cleared.");
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

            if (totalPlayers > 0 && totalDrawings >= totalPlayers)
            {
                Console.WriteLine($"Match {matchId}: All players have finished. Notifying...");
                NotifyGuessingPhaseStart(matchId);
            }
            else
            {
                Console.WriteLine($"Match {matchId}: Waiting for players. {totalDrawings}/{totalPlayers} finished.");
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

            lock (_matchCurrentDrawingIndex)
            {
                _matchCurrentDrawingIndex[matchId] = 0;
            }
            lock (_matchScores)
            {
                _matchScores[matchId] = playersInMatch
                    .Select(username => new PlayerScoreDto { Username = username, Score = 0 })
                    .ToList();
            }
            lock (_matchGuesses)
            {
                _matchGuesses.Remove(matchId);
            }

            DrawingDto firstDrawing = drawings.FirstOrDefault();
            if (firstDrawing == null)
            {
                Console.WriteLine($"Error: Guessing phase triggered but no drawings exist for match {matchId}.");
                return;
            }

            foreach (var username in playersInMatch)
            {
                lock (connectedPlayers)
                {
                    if (connectedPlayers.ContainsKey(username))
                    {
                        var callback = connectedPlayers[username];
                        try
                        {
                            callback.OnGuessingPhaseStart(firstDrawing);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Error notifying {username}: {ex.Message}");
                        }
                    }
                }
            }
        }
    }
}
