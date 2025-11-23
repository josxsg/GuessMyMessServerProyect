using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using log4net;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Core; 
using System.Data.Entity.Infrastructure; 
using System.Linq;
using System.Security.Cryptography;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.BusinessLogic
{
    public static class MatchmakingLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(MatchmakingLogic));
        private const string MatchStatusWaiting = "Waiting";

        private static readonly ConcurrentDictionary<string, IMatchmakingServiceCallback> _connectedUsers =
            new ConcurrentDictionary<string, IMatchmakingServiceCallback>();

        private static readonly ConcurrentDictionary<string, MatchLobby> _activeLobbies =
            new ConcurrentDictionary<string, MatchLobby>();

        public static void ConnectUser(string username, IMatchmakingServiceCallback callback)
        {
            _connectedUsers.TryAdd(username, callback);
            _log.Info($"User '{username}' connected to Matchmaking.");
        }

        public static void DisconnectUser(string username)
        {
            _connectedUsers.TryRemove(username, out _);
            _log.Info($"User '{username}' disconnected from Matchmaking.");

            var lobby = _activeLobbies.Values.FirstOrDefault(l => l.Players.Contains(username));
            if (lobby != null)
            {
                HandlePlayerLeave(username, lobby.MatchId);
            }
        }

        public static OperationResultDto CreateMatch(string hostUsername, LobbySettingsDto settings)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var hostPlayer = context.Player.FirstOrDefault(p => p.username == hostUsername);
                    if (hostPlayer == null)
                    {
                        _log.Warn($"CreateMatch failed: Host user '{hostUsername}' not found.");
                        return new OperationResultDto { Success = false, Message = "Host user not found." };
                    }

                    string newMatchCode = null;
                    byte isPrivateValue = (byte)(settings.IsPrivate ? 1 : 0);

                    if (settings.IsPrivate)
                    {
                        newMatchCode = GenerateMatchCode(8);
                        while (context.Match.Any(m => m.matchCode == newMatchCode && m.matchStatus == MatchStatusWaiting))
                        {
                            newMatchCode = GenerateMatchCode(8);
                        }
                    }

                    var newMatch = new Match
                    {
                        matchName = settings.MatchName,
                        maxPlayers = settings.MaxPlayers,
                        currentPlayers = 1,
                        totalRounds = settings.TotalRounds,
                        isPrivate = isPrivateValue,
                        matchCode = newMatchCode,
                        matchStatus = MatchStatusWaiting,
                        Player_idHost = hostPlayer.idPlayer,
                        MatchDifficulty_idMatchDifficulty = settings.DifficultyId
                    };

                    context.Match.Add(newMatch);
                    context.SaveChanges();

                    string matchId = newMatch.idMatch.ToString();
                    var lobby = new MatchLobby(matchId, newMatchCode, hostUsername, settings)
                    {
                        CurrentPlayers = 1
                    };
                    lobby.Players.Add(hostUsername);
                    _activeLobbies.TryAdd(matchId, lobby);

                    _log.Info($"Match created successfully. ID: {matchId}, Host: {hostUsername}, Private: {settings.IsPrivate}");

                    if (!settings.IsPrivate)
                    {
                        BroadcastPublicMatchList();
                    }

                    return new OperationResultDto
                    {
                        Success = true,
                        Message = "Match created.",
                        Data = new Dictionary<string, string>
                        {
                            { "MatchId", matchId },
                            { "MatchCode", newMatchCode }
                        }
                    };
                }
            }
            catch (DbUpdateException dbEx)
            {
                _log.Error($"Database error creating match for host '{hostUsername}'.", dbEx);
                return new OperationResultDto { Success = false, Message = "Database error occurred while creating the match." };
            }
            catch (EntityException entityEx)
            {
                _log.Error($"Database connection error creating match for host '{hostUsername}'.", entityEx);
                return new OperationResultDto { Success = false, Message = "Connection to database failed." };
            }
            catch (Exception ex)
            {
                _log.Error($"Unexpected error creating match for host '{hostUsername}'.", ex);
                return new OperationResultDto { Success = false, Message = "An unexpected server error occurred." };
            }
        }

        public static List<MatchInfoDto> GetPublicMatches()
        {
            return _activeLobbies.Values
                .Where(l => !l.Settings.IsPrivate && l.Status == "Waiting")
                .Select(l => l.ToMatchInfoDto())
                .ToList();
        }

        public static void JoinPublicMatch(string username, string matchId)
        {
            _connectedUsers.TryGetValue(username, out var callback);
            if (callback == null)
            {
                return;
            }

            if (_activeLobbies.TryGetValue(matchId, out var lobby))
            {
                if (lobby.CurrentPlayers >= lobby.Settings.MaxPlayers)
                {
                    _log.Info($"Join denied: Match {matchId} is full. User: {username}");
                    SafeCallback(callback, c => c.MatchJoined(null, new OperationResultDto { Success = false, Message = "Match is full." }));
                    return;
                }
                if (lobby.Status != "Waiting")
                {
                    _log.Info($"Join denied: Match {matchId} already started. User: {username}");
                    SafeCallback(callback, c => c.MatchJoined(null, new OperationResultDto { Success = false, Message = "Match has already started." }));
                    return;
                }

                lobby.Players.Add(username);
                lobby.CurrentPlayers++;
                UpdatePlayerCountInDb(lobby.MatchId, 1);

                _log.Info($"User '{username}' joined public match {matchId}.");

                SafeCallback(callback, c => c.MatchJoined(matchId, new OperationResultDto { Success = true }));
                BroadcastLobbyUpdate(lobby);
                BroadcastPublicMatchList();
            }
            else
            {
                _log.Warn($"Join failed: Match {matchId} not found in active lobbies. User: {username}");
                SafeCallback(callback, c => c.MatchJoined(null, new OperationResultDto { Success = false, Message = "Match not found." }));
            }
        }

        public static OperationResultDto JoinPrivateMatch(string username, string matchCode)
        {
            if (string.IsNullOrWhiteSpace(matchCode))
            {
                return new OperationResultDto { Success = false, Message = "Match code is required." };
            }

            var lobby = _activeLobbies.Values.FirstOrDefault(l => l.MatchCode == matchCode && l.Status == "Waiting");

            if (lobby != null)
            {
                _connectedUsers.TryGetValue(username, out var callback);
                if (callback == null)
                {
                    return new OperationResultDto { Success = false, Message = "User not connected." };
                }

                if (lobby.CurrentPlayers >= lobby.Settings.MaxPlayers)
                {
                    _log.Info($"Join private denied: Match {lobby.MatchId} is full. User: {username}");
                    return new OperationResultDto { Success = false, Message = "Match is full." };
                }

                lobby.Players.Add(username);
                lobby.CurrentPlayers++;
                UpdatePlayerCountInDb(lobby.MatchId, 1);

                _log.Info($"User '{username}' joined private match {lobby.MatchId} via code.");
                BroadcastLobbyUpdate(lobby);

                return new OperationResultDto
                {
                    Success = true,
                    Message = "Joined successfully.",
                    Data = new Dictionary<string, string> { { "MatchId", lobby.MatchId } }
                };
            }
            else
            {
                _log.Info($"Join private failed: Invalid code '{matchCode}' used by '{username}'.");
                return new OperationResultDto { Success = false, Message = "Invalid or expired match code." };
            }
        }

        public static void InviteToMatch(string inviterUsername, string invitedUsername, string matchId)
        {
            if (_connectedUsers.TryGetValue(invitedUsername, out var callback))
            {
                SafeCallback(callback, c => c.ReceiveMatchInvite(inviterUsername, matchId));
                _log.Info($"Invitation sent from '{inviterUsername}' to '{invitedUsername}' for match {matchId}.");
            }
            else
            {
                _log.Info($"Invitation failed: Target user '{invitedUsername}' is not connected.");
            }
        }

        public static void HandlePlayerLeave(string username, string matchId)
        {
            if (_activeLobbies.TryGetValue(matchId, out var lobby))
            {
                bool playerRemoved = lobby.Players.Remove(username);

                if (playerRemoved)
                {
                    lobby.CurrentPlayers--;
                    UpdatePlayerCountInDb(matchId, -1);
                    _log.Info($"Player '{username}' left lobby {matchId}. Current count: {lobby.CurrentPlayers}");
                }

                if (lobby.Players.Count == 0 || lobby.HostUsername == username)
                {
                    _log.Info($"Lobby {matchId} closing (Host left or empty).");
                    _activeLobbies.TryRemove(matchId, out _);
                    UpdateMatchStatusInDb(matchId, "Aborted");

                    if (!lobby.Settings.IsPrivate)
                    {
                        BroadcastPublicMatchList();
                    }
                }
                else if (playerRemoved)
                {
                    BroadcastLobbyUpdate(lobby);
                    if (!lobby.Settings.IsPrivate)
                    {
                        BroadcastPublicMatchList();
                    }
                }
            }
        }

        public static void SetMatchAsPlaying(string matchId)
        {
            if (_activeLobbies.TryGetValue(matchId, out var lobby))
            {
                lobby.Status = "Playing";
                _log.Info($"Match {matchId} status set to 'Playing' in memory.");
            }

            UpdateMatchStatusInDb(matchId, "Playing");
            BroadcastPublicMatchList();
        }

        private static void UpdatePlayerCountInDb(string matchId, int change)
        {
            Task.Run(() =>
            {
                try
                {
                    using (var context = new GuessMyMessDBEntities())
                    {
                        if (int.TryParse(matchId, out int id))
                        {
                            var match = context.Match.Find(id);
                            if (match != null)
                            {
                                match.currentPlayers += change;
                                if (match.currentPlayers < 0)
                                {
                                    match.currentPlayers = 0;
                                }
                                context.SaveChanges();
                            }
                        }
                    }
                }
                catch (DbUpdateException dbEx)
                {
                    _log.Error($"DB Update Error (Player Count) for MatchId {matchId}", dbEx);
                }
                catch (EntityException entEx)
                {
                    _log.Error($"DB Connection Error (Player Count) for MatchId {matchId}", entEx);
                }
                catch (Exception ex)
                {
                    _log.Error($"Critical error updating player count for MatchId {matchId}", ex);
                }
            });
        }

        private static void UpdateMatchStatusInDb(string matchId, string status)
        {
            Task.Run(() =>
            {
                try
                {
                    using (var context = new GuessMyMessDBEntities())
                    {
                        if (int.TryParse(matchId, out int id))
                        {
                            var match = context.Match.Find(id);
                            if (match != null)
                            {
                                match.matchStatus = status;
                                context.SaveChanges();
                            }
                        }
                    }
                }
                catch (DbUpdateException dbEx)
                {
                    _log.Error($"DB Update Error (Match Status) for MatchId {matchId}", dbEx);
                }
                catch (EntityException entEx)
                {
                    _log.Error($"DB Connection Error (Match Status) for MatchId {matchId}", entEx);
                }
                catch (Exception ex)
                {
                    _log.Error($"Critical error updating status for MatchId {matchId}", ex);
                }
            });
        }

        private static void BroadcastPublicMatchList()
        {
            var publicMatches = GetPublicMatches();
            foreach (var userCallback in _connectedUsers.Values)
            {
                SafeCallback(userCallback, c => c.PublicMatchesListUpdated(publicMatches));
            }
        }

        private static void BroadcastLobbyUpdate(MatchLobby lobby)
        {
            var matchInfo = lobby.ToMatchInfoDto();
            foreach (var playerName in lobby.Players)
            {
                if (_connectedUsers.TryGetValue(playerName, out var callback))
                {
                    SafeCallback(callback, c => c.MatchUpdate(matchInfo));
                }
            }
        }

        private static void SafeCallback(IMatchmakingServiceCallback callback, Action<IMatchmakingServiceCallback> action)
        {
            try
            {
                action(callback);
            }
            catch (CommunicationException comEx)
            {
                _log.Warn("Failed to notify client (CommunicationException). Client likely disconnected.", comEx);
            }
            catch (TimeoutException timeEx)
            {
                _log.Warn("Failed to notify client (Timeout).", timeEx);
            }
            catch (Exception ex)
            {
                _log.Error("Unexpected error in matchmaking callback.", ex);
            }
        }

        private static string GenerateMatchCode(int length)
        {
            const string chars = "ABCDEFGHIJKLMNPQRSTUVWXYZ123456789";
            using (var crypto = new RNGCryptoServiceProvider())
            {
                var data = new byte[length];
                var result = new StringBuilder(length);
                crypto.GetBytes(data);
                foreach (byte b in data)
                {
                    result.Append(chars[b % chars.Length]);
                }
                return result.ToString();
            }
        }
    }

    public class MatchLobby
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(MatchLobby));

        public string MatchId { get; set; }
        public string MatchCode { get; set; }
        public string HostUsername { get; set; }
        public LobbySettingsDto Settings { get; set; }
        public List<string> Players { get; set; }
        public string Status { get; set; }
        public int CurrentPlayers { get; set; }

        public MatchLobby(string matchId, string matchCode, string hostUsername, LobbySettingsDto settings)
        {
            MatchId = matchId;
            MatchCode = matchCode;
            HostUsername = hostUsername;
            Settings = settings;
            Players = new List<string>();
            Status = "Waiting";
            CurrentPlayers = 0;
        }

        public MatchInfoDto ToMatchInfoDto()
        {
            string difficultyName = "Unknown";
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    difficultyName = context.MatchDifficulty
                                            .Where(d => d.idMatchDifficulty == Settings.DifficultyId)
                                            .Select(d => d.difficulty)
                                            .FirstOrDefault() ?? "Unknown";
                }
            }
            catch (EntityException entEx)
            {
                _log.Error($"Database error fetching difficulty for MatchId {this.MatchId}", entEx);
            }
            catch (Exception ex)
            {
                _log.Error($"Unexpected error fetching difficulty for MatchId {this.MatchId}", ex);
            }

            return new MatchInfoDto
            {
                MatchId = this.MatchId,
                MatchName = this.Settings.MatchName,
                HostUsername = this.HostUsername,
                CurrentPlayers = this.CurrentPlayers,
                MaxPlayers = this.Settings.MaxPlayers,
                DifficultyName = difficultyName
            };
        }
    }
}