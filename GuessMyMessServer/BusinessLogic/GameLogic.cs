using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.ServiceModel;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using log4net;

namespace GuessMyMessServer.BusinessLogic
{
    public enum MatchPhase
    {
        NotStarted,
        Drawing,
        Guessing,
        Answers,
        Finished
    }

    public class MatchState
    {
        public string MatchId { get; set; }
        public MatchPhase Phase { get; set; } = MatchPhase.NotStarted;
        public Timer GameTimer { get; set; }
        public int CurrentRound { get; set; } = 1;
        public int TotalRounds { get; set; }
        public int CurrentDrawingIndex { get; set; } = 0;
        public List<string> Players { get; set; } = new List<string>();
        public Dictionary<string, string> PlayerSelectedWords { get; set; } = new Dictionary<string, string>();
        public List<DrawingDto> Drawings { get; set; } = new List<DrawingDto>();
        public List<GuessDto> Guesses { get; set; } = new List<GuessDto>();
        public List<PlayerScoreDto> Scores { get; set; } = new List<PlayerScoreDto>();

        public void DisposeTimer()
        {
            GameTimer?.Dispose();
            GameTimer = null;
        }
    }

    public class GameLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(GameLogic));
        private static readonly GameLogic _instance = new GameLogic();
        public static GameLogic Instance => _instance;

        private readonly ConcurrentDictionary<string, IGameServiceCallback> _connectedPlayers = new ConcurrentDictionary<string, IGameServiceCallback>();
        private readonly Dictionary<string, MatchState> _matches = new Dictionary<string, MatchState>();

        private readonly object _gameStateLock = new object();
        private const int CorrectGuessScore = 50;
        private const int DrawingGuessedCorrectlyScore = 10;

        private GameLogic() { }

        private void StopMatchTimer(string matchId)
        {
            lock (_gameStateLock)
            {
                if (_matches.TryGetValue(matchId, out var match))
                {
                    try
                    {
                        match.DisposeTimer();
                    }
                    catch (Exception ex)
                    {
                        _log.Warn($"Error disposing timer for match {matchId}", ex);
                    }
                }
            }
        }

        private void StartTimer(string matchId, TimerCallback callback, object state, int delaySeconds)
        {
            lock (_gameStateLock)
            {
                if (_matches.TryGetValue(matchId, out var match))
                {
                    match.DisposeTimer();
                    match.GameTimer = new Timer(callback, state, delaySeconds * 1000, Timeout.Infinite);
                }
            }
        }

        public async Task<List<WordDto>> GetRandomWordsAsync()
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    return await context.Word
                        .OrderBy(w => Guid.NewGuid())
                        .Take(3)
                        .Select(w => new WordDto { WordId = w.idWord, WordKey = w.word1 })
                        .ToListAsync();
                }
            }
            catch (Exception ex)
            {
                _log.Error("Error getting random words from DB", ex);
                throw new FaultException("Database error while retrieving words.");
            }
        }

        public void RegisterMatchStart(string matchId, List<string> playerUsernames)
        {
            if (!int.TryParse(matchId, out int matchIdInt))
            {
                return;
            }

            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var matchEntity = context.Match.FirstOrDefault(m => m.idMatch == matchIdInt);
                    if (matchEntity == null)
                    {
                        return;
                    }

                    matchEntity.matchStatus = "Playing";

                    foreach (var username in playerUsernames)
                    {
                        AddPlayerToHistory(context, matchIdInt, username);
                    }
                    context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                _log.Error($"Error registering match start in DB for MatchID: {matchId}", ex);
            }
        }

        private void AddPlayerToHistory(GuessMyMessDBEntities context, int matchId, string username)
        {
            var player = context.Player.FirstOrDefault(p => p.username.ToLower() == username.ToLower());
            if (player != null && !context.MatchHistory.Any(h => h.Match_idMatch == matchId && h.Player_idPlayer == player.idPlayer))
            {
                context.MatchHistory.Add(new MatchHistory { Match_idMatch = matchId, Player_idPlayer = player.idPlayer, finalScore = 0, ranking = 0 });
            }
        }

        public void RegisterMatchEnd(string matchId, List<PlayerScoreDto> finalScores)
        {
            if (!int.TryParse(matchId, out int matchIdInt))
            {
                return;
            }

            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var matchEntity = context.Match.FirstOrDefault(m => m.idMatch == matchIdInt);
                    if (matchEntity == null)
                    {
                        return;
                    }

                    matchEntity.matchStatus = "Finished";
                    UpdateMatchHistoryScores(context, matchIdInt, finalScores);
                    context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                _log.Error($"Error registering match end in DB for MatchID: {matchId}", ex);
            }
        }

        private void UpdateMatchHistoryScores(GuessMyMessDBEntities context, int matchId, List<PlayerScoreDto> finalScores)
        {
            if (finalScores == null)
            {
                return;
            }

            var sorted = finalScores.OrderByDescending(s => s.Score).ToList();
            for (int i = 0; i < sorted.Count; i++)
            {
                var sc = sorted[i];
                var p = context.Player.FirstOrDefault(x => x.username.ToLower() == sc.Username.ToLower());
                if (p == null)
                {
                    continue;
                }

                var h = context.MatchHistory.FirstOrDefault(x => x.Match_idMatch == matchId && x.Player_idPlayer == p.idPlayer);
                if (h != null)
                {
                    h.finalScore = sc.Score;
                    h.ranking = i + 1;
                }
            }
        }

        public void StartGame(string matchId, int totalRounds, List<string> playersFromLobby)
        {
            StopMatchTimer(matchId);

            lock (_gameStateLock)
            {
                if (!_matches.ContainsKey(matchId))
                {
                    _matches[matchId] = new MatchState { MatchId = matchId };
                }

                var match = _matches[matchId];
                match.CurrentRound = 1;
                match.TotalRounds = totalRounds;
                match.Phase = MatchPhase.NotStarted;
                match.Players = match.Players.Union(playersFromLobby).Distinct().ToList();

                if (match.Scores.Count == 0)
                {
                    match.Scores = match.Players.Select(u => new PlayerScoreDto { Username = u, Score = 0 }).ToList();
                }
            }

            Task.Run(() => RegisterMatchStart(matchId, playersFromLobby));
            StartNewRound(matchId);
        }

        private void StartNewRound(string matchId)
        {
            StopMatchTimer(matchId);
            int roundToSend = 0;

            lock (_gameStateLock)
            {
                if (!_matches.TryGetValue(matchId, out var match))
                {
                    return;
                }

                match.Phase = MatchPhase.Drawing;
                match.CurrentDrawingIndex = 0;
                match.Drawings.Clear();
                match.Guesses.Clear();
                match.PlayerSelectedWords.Clear();

                roundToSend = match.CurrentRound;
            }

            BroadcastToMatch(matchId, callback => callback.OnRoundStart(roundToSend, new List<string>()));
        }

        public void RegisterSelectedWord(string username, string matchId, string selectedWord)
        {
            lock (_gameStateLock)
            {
                if (_matches.TryGetValue(matchId, out var match))
                {
                    match.PlayerSelectedWords[username] = selectedWord;
                }
            }
        }

        public void AddDrawing(string username, string matchId, byte[] drawingData)
        {
            lock (_gameStateLock)
            {
                if (!_matches.TryGetValue(matchId, out var match))
                {
                    return;
                }

                if (match.Phase != MatchPhase.Drawing)
                {
                    return;
                }

                string wordToSave = match.PlayerSelectedWords.ContainsKey(username) ? match.PlayerSelectedWords[username] : "Unknown";

                match.Drawings.Add(new DrawingDto
                {
                    OwnerUsername = username,
                    DrawingData = drawingData,
                    WordKey = wordToSave,
                    IsGuessed = false,
                    DrawingId = match.Drawings.Count + 1
                });

                if (match.Drawings.Count >= match.Players.Count && match.Players.Count > 0)
                {
                    Task.Run(() => NotifyGuessingPhaseStart(matchId));
                }
            }
        }

        private void NotifyGuessingPhaseStart(string matchId)
        {
            DrawingDto firstDrawing = null;

            lock (_gameStateLock)
            {
                if (!_matches.TryGetValue(matchId, out var match))
                {
                    return;
                }

                if (match.Phase != MatchPhase.Drawing)
                {
                    return;
                }

                match.Phase = MatchPhase.Guessing;
                match.CurrentDrawingIndex = 0;
                match.Guesses.Clear();

                firstDrawing = match.Drawings.FirstOrDefault();
            }

            if (firstDrawing != null)
            {
                BroadcastToMatch(matchId, c => c.OnGuessingPhaseStart(firstDrawing));
            }
        }

        public void ProcessGuess(string username, string matchId, int drawingId, string guessText)
        {
            lock (_gameStateLock)
            {
                if (!_matches.TryGetValue(matchId, out var match))
                {
                    return;
                }

                if (match.Phase != MatchPhase.Guessing)
                {
                    return;
                }

                var drawing = match.Drawings.FirstOrDefault(d => d.DrawingId == drawingId);
                if (drawing == null) return;

                bool isCorrect = string.Equals(guessText, drawing.WordKey, StringComparison.OrdinalIgnoreCase);
                bool alreadyGuessedCorrectly = match.Guesses.Any(g => g.GuesserUsername == username && g.DrawingId == drawingId && g.IsCorrect);

                if (!alreadyGuessedCorrectly)
                {
                    AddGuess(match, username, drawingId, guessText, isCorrect, drawing.WordKey);
                    if (isCorrect)
                    {
                        ApplyScores(match, username, drawing.OwnerUsername);
                    }
                }

                CheckDrawingCompletion(match, drawingId);
            }
        }

        private void AddGuess(MatchState match, string username, int drawingId, string guessText, bool isCorrect, string wordKey)
        {
            match.Guesses.Add(new GuessDto
            {
                GuesserUsername = username,
                DrawingId = drawingId,
                GuessText = guessText,
                IsCorrect = isCorrect,
                WordKey = wordKey
            });
        }

        private void ApplyScores(MatchState match, string guesser, string artist)
        {
            var guesserScore = match.Scores.FirstOrDefault(p => p.Username == guesser);
            if (guesserScore != null)
            {
                guesserScore.Score += CorrectGuessScore;
            }

            var artistScore = match.Scores.FirstOrDefault(p => p.Username == artist);
            if (artistScore != null)
            {
                artistScore.Score += DrawingGuessedCorrectlyScore;
            }
        }

        private void CheckDrawingCompletion(MatchState match, int currentDrawingId)
        {
            if (match.CurrentDrawingIndex >= match.Drawings.Count)
            {
                return;
            }

            if (match.Drawings[match.CurrentDrawingIndex].DrawingId != currentDrawingId)
            {
                return;
            }

            int totalPlayers = match.Players.Count;
            int guessesForThisDrawing = match.Guesses.Count(g => g.DrawingId == currentDrawingId);

            if (guessesForThisDrawing >= (totalPlayers - 1))
            {
                Task.Run(() => GoToNextDrawingOrAnswersPhase(match.MatchId));
            }
        }

        private void GoToNextDrawingOrAnswersPhase(string matchId)
        {
            DrawingDto nextDrawing = null;
            bool shouldStartAnswers = false;

            lock (_gameStateLock)
            {
                if (!_matches.TryGetValue(matchId, out var match))
                {
                    return;
                }

                if (match.Phase != MatchPhase.Guessing)
                {
                    return;
                }

                match.CurrentDrawingIndex++;

                if (match.CurrentDrawingIndex < match.Drawings.Count)
                {
                    nextDrawing = match.Drawings[match.CurrentDrawingIndex];
                }
                else
                {
                    shouldStartAnswers = true;
                }
            }

            if (nextDrawing != null)
            {
                BroadcastToMatch(matchId, c => c.OnShowNextDrawing(nextDrawing));
            }
            else if (shouldStartAnswers)
            {
                StartAnswersPhase(matchId);
            }
        }

        private void StartAnswersPhase(string matchId)
        {
            MatchState snapshot;
            lock (_gameStateLock)
            {
                if (!_matches.TryGetValue(matchId, out var match))
                {
                    return;
                }

                if (match.Phase != MatchPhase.Guessing)
                {
                    return;
                }

                match.Phase = MatchPhase.Answers;

                snapshot = new MatchState
                {
                    Drawings = new List<DrawingDto>(match.Drawings),
                    Guesses = new List<GuessDto>(match.Guesses),
                    Scores = new List<PlayerScoreDto>(match.Scores),
                    CurrentRound = match.CurrentRound
                };
            }

            BroadcastToMatch(matchId, c => c.OnAnswersPhaseStart(
                snapshot.Drawings.ToArray(),
                snapshot.Guesses.ToArray(),
                snapshot.Scores.ToArray()));

            int totalItems = snapshot.Drawings.Count + snapshot.Guesses.Count;
            int delaySeconds = (totalItems * 5) + 15;

            StartTimer(matchId, TimerCallback, new Tuple<string, int>(matchId, snapshot.CurrentRound), delaySeconds);
        }

        private void TimerCallback(object state)
        {
            var tuple = (Tuple<string, int>)state;
            CheckEndOfRoundOrGame(tuple.Item1, tuple.Item2);
        }

        private void CheckEndOfRoundOrGame(string matchId, int expectedRound)
        {
            bool startNextRound = false;

            lock (_gameStateLock)
            {
                if (!_matches.TryGetValue(matchId, out var match))
                {
                    return;
                }

                if (match.CurrentRound != expectedRound)
                {
                    return;
                }

                if (match.CurrentRound < match.TotalRounds)
                {
                    match.CurrentRound++;
                    startNextRound = true;
                }
            }

            if (startNextRound)
            {
                StartNewRound(matchId);
            }
            else
            {
                NotifyGameEnd(matchId);
            }
        }

        private void NotifyGameEnd(string matchId)
        {
            StopMatchTimer(matchId);
            List<PlayerScoreDto> finalScores = null;

            lock (_gameStateLock)
            {
                if (_matches.TryGetValue(matchId, out var match))
                {
                    match.Phase = MatchPhase.Finished;
                    finalScores = match.Scores.OrderByDescending(s => s.Score).ToList();
                }
            }

            if (finalScores != null)
            {
                MatchmakingLogic.SetMatchAsFinished(matchId);
                Task.Run(() => RegisterMatchEnd(matchId, finalScores));
                BroadcastToMatch(matchId, c => c.OnGameEnd(finalScores));
            }
        }

        public void ConnectPlayer(string username, string matchId, IGameServiceCallback callback)
        {
            _connectedPlayers.AddOrUpdate(username, callback, (key, old) => callback);

            lock (_gameStateLock)
            {
                if (!_matches.ContainsKey(matchId))
                {
                    _matches[matchId] = new MatchState { MatchId = matchId };
                }

                var match = _matches[matchId];
                if (!match.Players.Contains(username))
                {
                    match.Players.Add(username);
                }
            }
        }

        public void DisconnectPlayer(string username, string matchId)
        {
            _connectedPlayers.TryRemove(username, out _);

            bool shouldClear = false;
            lock (_gameStateLock)
            {
                if (matchId != null && _matches.TryGetValue(matchId, out var match))
                {
                    match.Players.Remove(username);
                    if (match.Players.Count == 0)
                    {
                        shouldClear = true;
                    }
                }
            }

            if (shouldClear)
            {
                StopMatchTimer(matchId);
                lock (_gameStateLock)
                {
                    _matches.Remove(matchId);
                }
            }
        }

        public void BroadcastChatMessage(string sender, string matchId, string msg)
        {
            List<string> players = null;
            lock (_gameStateLock)
            {
                if (_matches.TryGetValue(matchId, out var match))
                {
                    players = new List<string>(match.Players);
                }
            }

            if (players != null)
            {
                foreach (var u in players)
                {
                    NotifyPlayer(u, c => c.OnInGameMessageReceived(sender, msg));
                }
            }
        }

        private void BroadcastToMatch(string matchId, Action<IGameServiceCallback> action)
        {
            List<string> players = null;
            lock (_gameStateLock)
            {
                if (_matches.TryGetValue(matchId, out var match))
                {
                    players = new List<string>(match.Players);
                }
            }

            if (players != null)
            {
                foreach (var user in players) NotifyPlayer(user, action);
            }
        }

        private void NotifyPlayer(string username, Action<IGameServiceCallback> action)
        {
            if (_connectedPlayers.TryGetValue(username, out var cb))
            {
                try
                {
                    action(cb);
                }
                catch (CommunicationException commEx)
                {
                    _log.Warn($"Communication error with player {username}. They might have disconnected unexpectedly.", commEx);
                }
                catch (TimeoutException timeoutEx)
                {
                    _log.Warn($"Timeout contacting player {username}", timeoutEx);
                }
                catch (Exception ex)
                {
                    _log.Error($"Unexpected error notifying player {username}", ex);
                }
            }
        }
    }
}
