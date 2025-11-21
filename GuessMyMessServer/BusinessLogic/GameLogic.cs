using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using log4net;

namespace GuessMyMessServer.BusinessLogic
{
    public class GameLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(GameLogic));
        private static readonly GameLogic _instance = new GameLogic();
        public static GameLogic Instance => _instance;

        private readonly Dictionary<string, IGameServiceCallback> _connectedPlayers = new Dictionary<string, IGameServiceCallback>();
        private readonly Dictionary<string, string> _playerSelectedWords = new Dictionary<string, string>();
        private readonly Dictionary<string, List<DrawingDto>> _matchDrawings = new Dictionary<string, List<DrawingDto>>();
        private readonly Dictionary<string, List<string>> _matchPlayers = new Dictionary<string, List<string>>();
        private readonly Dictionary<string, List<GuessDto>> _matchGuesses = new Dictionary<string, List<GuessDto>>();
        private readonly Dictionary<string, int> _matchCurrentDrawingIndex = new Dictionary<string, int>();
        private readonly Dictionary<string, List<PlayerScoreDto>> _matchScores = new Dictionary<string, List<PlayerScoreDto>>();

        private const int SecondsPerGuess = 10;
        private static readonly Random _random = new Random();

        private GameLogic() { }

        public async Task<List<WordDto>> GetRandomWordsAsync()
        {
            const int WordsToSelect = 3;

            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var allWords = await context.Word
                        .Select(w => new WordDto
                        {
                            WordId = w.idWord,
                            WordKey = w.word1
                        })
                        .ToListAsync();

                    if (allWords.Count < WordsToSelect)
                    {
                        _log.Warn($"Insufficient words in database. Requested: {WordsToSelect}, Available: {allWords.Count}.");
                        return allWords;
                    }

                    var randomWords = allWords
                        .OrderBy(w => _random.Next())
                        .Take(WordsToSelect)
                        .ToList();

                    return randomWords;
                }
            }
            catch (Exception ex) // Capturamos Exception general aquí porque EF puede lanzar varias en lectura (EntityException, SqlException)
            {
                _log.Warn("Database error retrieving random words.", ex);
                throw;
            }
        }

        public void ConnectPlayer(string username, string matchId, IGameServiceCallback callback)
        {
            lock (_connectedPlayers)
            {
                _connectedPlayers[username] = callback;
            }

            lock (_matchPlayers)
            {
                if (!_matchPlayers.ContainsKey(matchId))
                {
                    _matchPlayers[matchId] = new List<string>();
                    _log.Info($"Match {matchId} created in memory.");
                }
                if (!_matchPlayers[matchId].Contains(username))
                {
                    _matchPlayers[matchId].Add(username);
                }
            }

            _log.Info($"Player '{username}' connected to match {matchId}.");
        }

        public void DisconnectPlayer(string username, string matchId)
        {
            lock (_connectedPlayers)
            {
                _connectedPlayers.Remove(username);
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

            _log.Info($"Player '{username}' disconnected.");
        }

        public void RegisterSelectedWord(string username, string matchId, string selectedWord)
        {
            lock (_playerSelectedWords)
            {
                _playerSelectedWords[username] = selectedWord;
            }
            _log.Info($"Player '{username}' selected a word in match {matchId}.");
        }

        public void AddDrawing(string username, string matchId, byte[] drawingData)
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

            _log.Info($"Drawing received. Match: {matchId}, User: '{username}'.");
            CheckIfAllPlayersFinishedDrawing(matchId);
        }

        public void ProcessGuess(string username, string matchId, int drawingId, string guess)
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
                _log.Warn($"ProcessGuess Warning: Drawing {drawingId} not found in match {matchId}.");
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

            if (isCorrect)
            {
                _log.Info($"Correct guess! Player '{username}' guessed the word in match {matchId}.");
                CalculateScores(matchId, username, currentDrawing.OwnerUsername);
            }
            else
            {
                _log.Info($"Incorrect guess by '{username}' in match {matchId}.");
            }

            CheckIfAllGuessesForCurrentDrawingAreIn(matchId, currentDrawing);
        }

        public void BroadcastChatMessage(string senderUsername, string matchId, string message)
        {
            List<string> playersInMatch;
            lock (_matchPlayers)
            {
                if (!_matchPlayers.ContainsKey(matchId))
                {
                    return;
                }
                playersInMatch = new List<string>(_matchPlayers[matchId]);
            }

            foreach (var playerUsername in playersInMatch)
            {
                NotifyPlayer(playerUsername, callback => callback.OnInGameMessageReceived(senderUsername, message));
            }
        }

        private void CalculateScores(string matchId, string guesser, string artistUsername)
        {
            lock (_matchScores)
            {
                if (!_matchScores.ContainsKey(matchId))
                {
                    _matchScores[matchId] = new List<PlayerScoreDto>();
                }

                var playerToScore = _matchScores[matchId].FirstOrDefault(p => p.Username == guesser);
                if (playerToScore == null)
                {
                    playerToScore = new PlayerScoreDto { Username = guesser, Score = 0 };
                    _matchScores[matchId].Add(playerToScore);
                }
                playerToScore.Score += 50;

                var artist = _matchScores[matchId].FirstOrDefault(p => p.Username == artistUsername);
                if (artist == null)
                {
                    artist = new PlayerScoreDto { Username = artistUsername, Score = 0 };
                    _matchScores[matchId].Add(artist);
                }
                artist.Score += 10;
            }
        }

        private void CheckIfAllPlayersFinishedDrawing(string matchId)
        {
            int totalPlayers = 0;
            int totalDrawings = 0;

            lock (_matchPlayers)
            {
                if (_matchPlayers.ContainsKey(matchId))
                {
                    totalPlayers = _matchPlayers[matchId].Count;
                }
            }

            lock (_matchDrawings)
            {
                if (_matchDrawings.ContainsKey(matchId))
                {
                    totalDrawings = _matchDrawings[matchId].Count;
                }
            }

            if (totalPlayers > 0 && totalDrawings >= totalPlayers)
            {
                _log.Info($"Match {matchId}: All players finished drawing. Proceeding to guessing phase.");
                NotifyGuessingPhaseStart(matchId);
            }
        }

        private void NotifyGuessingPhaseStart(string matchId)
        {
            InitializeMatchForGuessing(matchId);

            List<DrawingDto> drawings;
            lock (_matchDrawings)
            {
                drawings = _matchDrawings[matchId];
            }

            DrawingDto firstDrawing = drawings.FirstOrDefault();
            if (firstDrawing == null)
            {
                _log.Warn($"Match {matchId}: Tried to start guessing phase but no drawings were found.");
                return;
            }

            BroadcastToMatch(matchId, callback => callback.OnGuessingPhaseStart(firstDrawing));
        }

        private void InitializeMatchForGuessing(string matchId)
        {
            List<string> players;
            lock (_matchPlayers)
            {
                players = new List<string>(_matchPlayers[matchId]);
            }

            lock (_matchCurrentDrawingIndex)
            {
                _matchCurrentDrawingIndex[matchId] = 0;
            }

            lock (_matchScores)
            {
                _matchScores[matchId] = players
                    .Select(u => new PlayerScoreDto { Username = u, Score = 0 })
                    .ToList();
            }

            lock (_matchGuesses)
            {
                _matchGuesses.Remove(matchId);
            }
        }

        private void CheckIfAllGuessesForCurrentDrawingAreIn(string matchId, DrawingDto currentDrawing)
        {
            int totalPlayers;
            lock (_matchPlayers)
            {
                if (!_matchPlayers.ContainsKey(matchId))
                {
                    return;
                }
                totalPlayers = _matchPlayers[matchId].Count;
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
                _log.Info($"Match {matchId}: Drawing {currentDrawing.DrawingId} completed. Moving to next step.");
                GoToNextDrawingOrAnswersPhase(matchId);
            }
        }

        private void GoToNextDrawingOrAnswersPhase(string matchId)
        {
            int nextIndex;
            lock (_matchCurrentDrawingIndex)
            {
                _matchCurrentDrawingIndex[matchId]++;
                nextIndex = _matchCurrentDrawingIndex[matchId];
            }

            List<DrawingDto> drawings;
            lock (_matchDrawings)
            {
                drawings = _matchDrawings[matchId];
            }

            if (nextIndex < drawings.Count)
            {
                DrawingDto nextDrawing = drawings[nextIndex];
                BroadcastToMatch(matchId, callback => callback.OnShowNextDrawing(nextDrawing));
            }
            else
            {
                StartAnswersPhase(matchId, drawings);
            }
        }

        private void StartAnswersPhase(string matchId, List<DrawingDto> allDrawings)
        {
            _log.Info($"Match {matchId}: Starting Answers Phase.");

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

            BroadcastToMatch(matchId, callback =>
                callback.OnAnswersPhaseStart(allDrawings.ToArray(), allGuesses.ToArray(), currentScores.ToArray()));

            int delaySeconds = ((allDrawings.Count + allGuesses.Count) * SecondsPerGuess) + 5;

            Task.Delay(TimeSpan.FromSeconds(delaySeconds)).ContinueWith(t => NotifyGameEnd(matchId));
        }

        private void NotifyGameEnd(string matchId)
        {
            List<PlayerScoreDto> finalScores;
            lock (_matchScores)
            {
                if (!_matchScores.ContainsKey(matchId))
                {
                    return;
                }
                finalScores = _matchScores[matchId].OrderByDescending(s => s.Score).ToList();
            }

            _log.Info($"Match {matchId}: Game ended. Notifying players.");
            BroadcastToMatch(matchId, callback => callback.OnGameEnd(finalScores));

            ClearMatchData(matchId);
        }

        private void ClearMatchData(string matchId)
        {
            lock (_matchDrawings)
            {
                _matchDrawings.Remove(matchId);
            }

            lock (_matchPlayers)
            {
                _matchPlayers.Remove(matchId);
            }

            lock (_matchGuesses)
            {
                _matchGuesses.Remove(matchId);
            }

            lock (_matchCurrentDrawingIndex)
            {
                _matchCurrentDrawingIndex.Remove(matchId);
            }

            lock (_matchScores)
            {
                _matchScores.Remove(matchId);
            }

            _log.Info($"Match {matchId}: Data cleared from memory.");
        }

        private void BroadcastToMatch(string matchId, Action<IGameServiceCallback> action)
        {
            List<string> players;
            lock (_matchPlayers)
            {
                if (!_matchPlayers.ContainsKey(matchId))
                {
                    return;
                }
                players = new List<string>(_matchPlayers[matchId]);
            }

            foreach (var user in players)
            {
                NotifyPlayer(user, action);
            }
        }

        private void NotifyPlayer(string username, Action<IGameServiceCallback> action)
        {
            IGameServiceCallback callback = null;
            lock (_connectedPlayers)
            {
                if (_connectedPlayers.ContainsKey(username))
                {
                    callback = _connectedPlayers[username];
                }
            }

            if (callback != null)
            {
                try
                {
                    action(callback);
                }
                catch (CommunicationException comEx)
                {
                    _log.Warn($"Communication error notifying player '{username}'. The client might have disconnected.", comEx);
                }
                catch (TimeoutException timeEx)
                {
                    _log.Warn($"Timeout trying to notify player '{username}'.", timeEx);
                }
                catch (Exception ex)
                {
                    _log.Error($"Unexpected error notifying player '{username}'.", ex);
                }
            }
        }
    }
}
