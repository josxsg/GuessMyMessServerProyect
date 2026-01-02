using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.DataAccess.Abstractions;
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
        private static readonly ConcurrentDictionary<string, IGameServiceCallback> _connectedPlayers = new ConcurrentDictionary<string, IGameServiceCallback>();
        private static readonly Dictionary<string, MatchState> _matches = new Dictionary<string, MatchState>();
        private static readonly object _gameStateLock = new object();

        private const int CorrectGuessScore = 50;
        private const int DrawingGuessedCorrectlyScore = 10;

        private readonly IWordRepository _wordRepository;
        private readonly IMatchRepository _matchRepository;
        private readonly IPlayerRepository _playerRepository;

        public GameLogic(
            IWordRepository wordRepository,
            IMatchRepository matchRepository,
            IPlayerRepository playerRepository)
        {
            _wordRepository = wordRepository;
            _matchRepository = matchRepository;
            _playerRepository = playerRepository;
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
            _log.Info($"GameLogic: Player '{username}' connected to match {matchId}.");
        }

        public void DisconnectPlayer(string username, string matchId)
        {
            _connectedPlayers.TryRemove(username, out _);
            bool shouldEndMatch = false;
            bool shouldClear = false;
            lock (_gameStateLock)
            {
                if (matchId != null && _matches.TryGetValue(matchId, out var match))
                {

                    if (match.Players.Contains(username))
                    {
                        match.Players.Remove(username);
                        match.Scores.RemoveAll(s => s.Username == username);
                        if (match.PlayerSelectedWords.ContainsKey(username))
                        {
                            match.PlayerSelectedWords.Remove(username);
                        }

                        if (match.Players.Count > 0)
                        {
                            BroadcastToMatch(matchId, c => c.OnInGameMessageReceived("SYSTEM", $"SYSTEM_LEAVE|{username}"));
                        }

                        if (match.Players.Count == 0)
                        {
                            shouldClear = true;
                        }
                        else if (match.Players.Count < 2 && match.Phase != MatchPhase.Finished && match.Phase != MatchPhase.NotStarted)
                        {
                            shouldEndMatch = true;
                        }
                        else
                        {
                            CheckPhaseProgressionAfterDisconnect(match, username);
                        }
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
                _log.Info($"GameLogic: Match {matchId} removed from memory (empty).");
            }
            else if (shouldEndMatch)
            {
                Task.Run(async () =>
                {
                    BroadcastToMatch(matchId, c => c.OnInGameMessageReceived("SYSTEM", "SYSTEM_NOT_ENOUGH_PLAYERS"));
                    await NotifyGameEndAsync(matchId);
                });
            }
        }

        private void CheckPhaseProgressionAfterDisconnect(MatchState match, string leaverUsername)
        {
            if (match.Phase == MatchPhase.Drawing)
            {
                int validDrawings = match.Drawings.Count(d => match.Players.Contains(d.OwnerUsername));

                if (validDrawings >= match.Players.Count && match.Players.Count > 0)
                {
                    _log.Info($"Disconnect triggered end of Drawing phase in match {match.MatchId}");
                    NotifyGuessingPhaseStart(match.MatchId);
                }
            }
            else if (match.Phase == MatchPhase.Guessing)
            {
                if (match.CurrentDrawingIndex < match.Drawings.Count)
                {
                    var currentDrawing = match.Drawings[match.CurrentDrawingIndex];

                    if (currentDrawing.OwnerUsername == leaverUsername)
                    {
                        _log.Info($"Artist left in match {match.MatchId}. Skipping drawing.");
                        Task.Run(() => GoToNextDrawingOrAnswersPhase(match.MatchId));
                    }
                    else
                    {
                        CheckDrawingCompletion(match, currentDrawing.DrawingId);
                    }
                }
            }
        }

        public void ForceDisconnection(string username, string matchId)
        {
            const int StatusOffline = 1;
            DisconnectPlayer(username, matchId);
            UpdateUserStatus(username, StatusOffline); 
        }

        private void UpdateUserStatus(string username, int statusId)
        {
            Task.Run(async () =>
            {
                try
                {
                    var player = await _playerRepository.GetPlayerByUsernameAsync(username);
                    if (player != null)
                    {
                        player.UserStatus_idUserStatus = statusId;
                        await _playerRepository.SaveChangesAsync();
                    }
                }
                catch (Exception ex)
                {
                    _log.Error($"Error updating status for {username} to {statusId}", ex);
                }
            });
        }

        public async Task StartGameAsync(string matchId, int totalRounds, List<string> playersFromLobby)
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

            await RegisterMatchStartAsync(matchId, playersFromLobby);
            await StartNewRoundAsync(matchId);
        }

        private async Task StartNewRoundAsync(string matchId)
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

        public async Task<List<WordDto>> GetRandomWordsAsync()
        {
            try
            {
                var words = await _wordRepository.GetRandomWordsAsync(3);
                return words.Select(w => new WordDto { WordId = w.idWord, WordKey = w.word1 }).ToList();
            }
            catch (Exception ex)
            {
                _log.Error("Error retrieving random words.", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(Contracts.DataContracts.ServiceErrorType.DatabaseError, "Could not retrieve words."),
                    new FaultReason("Database Error"));
            }
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
            bool allDrawingsReceived = false;

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

                if (!match.Drawings.Any(d => d.OwnerUsername == username))
                {
                    match.Drawings.Add(new DrawingDto
                    {
                        OwnerUsername = username,
                        DrawingData = drawingData,
                        WordKey = wordToSave,
                        IsGuessed = false,
                        DrawingId = match.Drawings.Count + 1
                    });
                }

                int validDrawings = match.Drawings.Count(d => match.Players.Contains(d.OwnerUsername));
                if (validDrawings >= match.Players.Count && match.Players.Count > 0)
                {
                    allDrawingsReceived = true;
                }
            }

            if (allDrawingsReceived)
            {
                NotifyGuessingPhaseStart(matchId);
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

                match.Phase = MatchPhase.Guessing;
                match.CurrentDrawingIndex = 0;
                match.Guesses.Clear();

                firstDrawing = match.Drawings.FirstOrDefault(d => match.Players.Contains(d.OwnerUsername));
            }

            if (firstDrawing != null)
            {
                BroadcastToMatch(matchId, c => c.OnGuessingPhaseStart(firstDrawing));
            }
            else
            {
                Task.Run(() => GoToNextDrawingOrAnswersPhase(matchId));
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
                if (drawing == null)
                {
                    return;
                }

                bool isCorrect = string.Equals(guessText, drawing.WordKey, StringComparison.OrdinalIgnoreCase);
                bool alreadyGuessedCorrectly = match.Guesses.Any(g => g.GuesserUsername == username && g.DrawingId == drawingId && g.IsCorrect);

                if (!alreadyGuessedCorrectly)
                {
                    match.Guesses.Add(new GuessDto
                    {
                        GuesserUsername = username,
                        DrawingId = drawingId,
                        GuessText = guessText,
                        IsCorrect = isCorrect,
                        WordKey = drawing.WordKey
                    });

                    if (isCorrect)
                    {
                        ApplyScores(match, username, drawing.OwnerUsername);
                    }
                }

                CheckDrawingCompletion(match, drawingId);
            }
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
            int guessesForThisDrawing = match.Guesses.Count(g => g.DrawingId == currentDrawingId && match.Players.Contains(g.GuesserUsername));

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

                while (match.CurrentDrawingIndex < match.Drawings.Count)
                {
                    var candidate = match.Drawings[match.CurrentDrawingIndex];
                    if (match.Players.Contains(candidate.OwnerUsername))
                    {
                        nextDrawing = candidate;
                        break;
                    }
                    match.CurrentDrawingIndex++;
                }

                if (nextDrawing == null)
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
            const int FiveSeconds = 5;
            const int FifteenSeconds = 15;
            MatchState snapshot;
            lock (_gameStateLock)
            {
                if (!_matches.TryGetValue(matchId, out var match))
                {
                    return;
                }
                match.Phase = MatchPhase.Answers;

                var activeDrawings = match.Drawings
                    .Where(d => match.Players.Contains(d.OwnerUsername))
                    .ToList();

                var activeGuesses = match.Guesses
                    .Where(g => match.Players.Contains(g.GuesserUsername) &&
                                activeDrawings.Any(d => d.DrawingId == g.DrawingId))
                    .ToList();

                snapshot = new MatchState
                {
                    Drawings = activeDrawings, 
                    Guesses = activeGuesses,   
                    Scores = new List<PlayerScoreDto>(match.Scores), 
                    CurrentRound = match.CurrentRound
                };
            }

            BroadcastToMatch(matchId, c => c.OnAnswersPhaseStart(
                snapshot.Drawings.ToArray(),
                snapshot.Guesses.ToArray(),
                snapshot.Scores.ToArray()));

            int totalItems = snapshot.Drawings.Count + snapshot.Guesses.Count;
            int delaySeconds = (totalItems * FiveSeconds) + FifteenSeconds;

            StartTimer(matchId, TimerCallback, new Tuple<string, int>(matchId, snapshot.CurrentRound), delaySeconds);
        }

        private void TimerCallback(object state)
        {
            var tuple = (Tuple<string, int>)state;
            Task.Run(() => CheckEndOfRoundOrGame(tuple.Item1, tuple.Item2));
        }

        private async Task CheckEndOfRoundOrGame(string matchId, int expectedRound)
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
                await StartNewRoundAsync(matchId);
            }
            else
            {
                await NotifyGameEndAsync(matchId);
            }
        }

        private async Task NotifyGameEndAsync(string matchId)
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
                await RegisterMatchEndAsync(matchId, finalScores);
                BroadcastToMatch(matchId, c => c.OnGameEnd(finalScores));
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

        private async Task RegisterMatchStartAsync(string matchIdStr, List<string> playerUsernames)
        {
            if (!int.TryParse(matchIdStr, out int matchId))
            {
                return;
            }

            try
            {
                var match = await _matchRepository.GetMatchByIdAsync(matchId);
                if (match != null)
                {
                    match.matchStatus = "Playing";

                    foreach (var username in playerUsernames)
                    {
                        var player = await _playerRepository.GetPlayerByUsernameAsync(username);
                        if (player != null)
                        {
                            bool exists = await _matchRepository.PlayerHasHistoryInMatchAsync(matchId, player.idPlayer);
                            if (!exists)
                            {
                                _matchRepository.AddMatchHistory(new MatchHistory
                                {
                                    Match_idMatch = matchId,
                                    Player_idPlayer = player.idPlayer,
                                    finalScore = 0,
                                    ranking = 0
                                });
                            }
                        }
                    }
                    await _matchRepository.SaveChangesAsync();
                }
            }
            catch (Exception ex)
            {
                _log.Error($"DB Error registering match start {matchId}", ex);
            }
        }

        private async Task RegisterMatchEndAsync(string matchIdStr, List<PlayerScoreDto> finalScores)
        {
            if (!int.TryParse(matchIdStr, out int matchId))
            {
                return;
            }

            try
            {
                var match = await _matchRepository.GetMatchByIdAsync(matchId);
                if (match != null)
                {
                    match.matchStatus = "Finished";

                    var histories = await _matchRepository.GetMatchHistoryByMatchIdAsync(matchId);

                    for (int i = 0; i < finalScores.Count; i++)
                    {
                        var score = finalScores[i];
                        var player = await _playerRepository.GetPlayerByUsernameAsync(score.Username);
                        if (player != null)
                        {
                            var entry = histories.FirstOrDefault(h => h.Player_idPlayer == player.idPlayer);
                            if (entry != null)
                            {
                                entry.finalScore = score.Score;
                                entry.ranking = i + 1;
                            }
                        }
                    }
                    await _matchRepository.SaveChangesAsync();
                }
            }
            catch (Exception ex)
            {
                _log.Error($"DB Error registering match end {matchId}", ex);
            }
        }

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
            const int OneThousand = 1000;
            lock (_gameStateLock)
            {
                if (_matches.TryGetValue(matchId, out var match))
                {
                    match.DisposeTimer();
                    match.GameTimer = new Timer(callback, state, delaySeconds * OneThousand, Timeout.Infinite);
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
                catch (CommunicationException)
                {
                }
                catch (Exception ex)
                {
                    _log.Warn($"Error notifying player {username}", ex);
                }
            }
        }
    }
}
