using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.BusinessLogic
{
    public static class MatchmakingLogic
    {
        private const string MatchStatusWaiting = "Waiting";

        private static readonly ConcurrentDictionary<string, IMatchmakingServiceCallback> _connectedUsers =
            new ConcurrentDictionary<string, IMatchmakingServiceCallback>();

        private static readonly ConcurrentDictionary<string, MatchLobby> _activeLobbies =
            new ConcurrentDictionary<string, MatchLobby>();

        public static void ConnectUser(string username, IMatchmakingServiceCallback callback)
        {
            _connectedUsers.TryAdd(username, callback);
        }

        public static void DisconnectUser(string username)
        {
            _connectedUsers.TryRemove(username, out _);

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
            catch (Exception ex)
            {
                return new OperationResultDto { Success = false, Message = "Server error creating match: " + ex.Message };
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
            if (callback == null) return;

            if (_activeLobbies.TryGetValue(matchId, out var lobby))
            {
                if (lobby.CurrentPlayers >= lobby.Settings.MaxPlayers)
                {
                    callback.MatchJoined(null, new OperationResultDto { Success = false, Message = "Match is full." });
                    return;
                }
                if (lobby.Status != "Waiting")
                {
                    callback.MatchJoined(null, new OperationResultDto { Success = false, Message = "Match has already started." });
                    return;
                }

                lobby.Players.Add(username);
                lobby.CurrentPlayers++;
                UpdatePlayerCountInDb(lobby.MatchId, 1);

                callback.MatchJoined(matchId, new OperationResultDto { Success = true });
                BroadcastLobbyUpdate(lobby);
                BroadcastPublicMatchList();
            }
            else
            {
                callback.MatchJoined(null, new OperationResultDto { Success = false, Message = "Match not found." });
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
                    return new OperationResultDto { Success = false, Message = "Match is full." };
                }

                lobby.Players.Add(username);
                lobby.CurrentPlayers++;
                UpdatePlayerCountInDb(lobby.MatchId, 1);
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
                return new OperationResultDto { Success = false, Message = "Invalid or expired match code." };
            }
        }

        public static void InviteToMatch(string inviterUsername, string invitedUsername, string matchId)
        {
            if (_connectedUsers.TryGetValue(invitedUsername, out var callback))
            {
                callback.ReceiveMatchInvite(inviterUsername, matchId);
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
                    Console.WriteLine($"[MatchmakingLogic] Player {username} removed from lobby {matchId}. New count: {lobby.CurrentPlayers}");
                }

                if (lobby.Players.Count == 0 || lobby.HostUsername == username)
                {
                    Console.WriteLine($"[MatchmakingLogic] Lobby {matchId} is being removed (Host left or lobby empty).");
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
                                if (match.currentPlayers < 0) match.currentPlayers = 0;
                                context.SaveChanges();
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error updating player count in DB for MatchId {matchId}: {ex.Message}");
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
                catch (Exception ex)
                {
                    Console.WriteLine($"Error updating match status in DB for MatchId {matchId}: {ex.Message}");
                }
            });
        }

        private static void BroadcastPublicMatchList()
        {
            var publicMatches = GetPublicMatches();
            foreach (var userCallback in _connectedUsers.Values)
            {
                try
                {
                    userCallback.PublicMatchesListUpdated(publicMatches);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error broadcasting public match list to a user: {ex.Message}");
                }
            }
        }

        private static void BroadcastLobbyUpdate(MatchLobby lobby)
        {
            var matchInfo = lobby.ToMatchInfoDto();
            foreach (var playerName in lobby.Players)
            {
                if (_connectedUsers.TryGetValue(playerName, out var callback))
                {
                    try
                    {
                        callback.MatchUpdate(matchInfo);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error broadcasting lobby update to {playerName}: {ex.Message}");
                    }
                }
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
            catch (Exception ex)
            {
                Console.WriteLine($"Error fetching difficulty name for MatchId {this.MatchId}: {ex.Message}");
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
