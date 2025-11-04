using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading;
using System.Threading.Tasks;

namespace GuessMyMessServer.BusinessLogic
{
    public class LobbyLogic
    {
        private static readonly ConcurrentDictionary<string, Lobby> _lobbies = new ConcurrentDictionary<string, Lobby>();
        private static readonly object _lock = new object();

        private sealed class PlayerConnection
        {
            public string Username { get; }
            public ILobbyServiceCallback Callback { get; }

            public PlayerConnection(string username, ILobbyServiceCallback callback)
            {
                Username = username;
                Callback = callback;
            }
        }

        private sealed class Lobby
        {
            public string MatchId { get; }
            public string HostUsername { get; }
            public MatchInfoDto MatchInfo { get; }
            public ConcurrentDictionary<string, PlayerConnection> Players { get; } = new ConcurrentDictionary<string, PlayerConnection>();
            private Timer _countdownTimer;
            private int _countdownSeconds = 5;

            public Lobby(string matchId, string hostUsername, MatchInfoDto matchInfo)
            {
                MatchId = matchId;
                HostUsername = hostUsername;
                MatchInfo = matchInfo;
            }

            public LobbyStateDto GetCurrentState()
            {
                return new LobbyStateDto
                {
                    MatchName = MatchInfo.MatchName,
                    HostUsername = HostUsername,
                    Difficulty = MatchInfo.DifficultyName,
                    CurrentPlayers = Players.Count,
                    MaxPlayers = MatchInfo.MaxPlayers,
                    MatchCode = MatchInfo.IsPrivate ? MatchId : null,
                    PlayerUsernames = Players.Keys.ToList()
                };
            }

            public void StartCountdown()
            {
                _countdownSeconds = 5;
                _countdownTimer = new Timer(CountdownTick, null, TimeSpan.Zero, TimeSpan.FromSeconds(1));
                Broadcast(conn => conn.Callback.OnGameStarting(_countdownSeconds));
            }

            private void CountdownTick(object state)
            {
                _countdownSeconds--;
                if (_countdownSeconds > 0)
                {
                    Broadcast(conn => conn.Callback.OnGameStarting(_countdownSeconds));
                }
                else
                {
                    _countdownTimer?.Dispose();
                    Broadcast(conn => conn.Callback.OnGameStarted());
                    LobbyLogic.RemoveLobby(MatchId);
                }
            }

            public void Broadcast(Action<PlayerConnection> action)
            {
                foreach (var playerConn in Players.Values)
                {
                    try
                    {
                        action(playerConn);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error broadcasting to {playerConn.Username}: {ex.Message}");
                    }
                }
            }
        }

        public void Connect(string username, string matchId, ILobbyServiceCallback callback)
        {
            Lobby lobby = GetOrCreateLobby(matchId, username, callback);

            if (lobby == null)
            {
                return;
            }

            AddPlayerToLobby(lobby, username, callback);
        }

        private Lobby GetOrCreateLobby(string matchId, string hostUsername, ILobbyServiceCallback callback)
        {
            Lobby lobby;

            lock (_lock)
            {
                if (_lobbies.TryGetValue(matchId, out lobby))
                {
                    return lobby; 
                }

                var matchInfo = GetMatchInfo(matchId);
                if (matchInfo == null)
                {
                    SafeCallback(callback, () => callback.KickedFromLobby("Match not found."));
                    return null;
                }

                lobby = new Lobby(matchId, hostUsername, matchInfo);

                if (!_lobbies.TryAdd(matchId, lobby))
                {
                    _lobbies.TryGetValue(matchId, out lobby);
                }
            }

            return lobby;
        }

        private void AddPlayerToLobby(Lobby lobby, string username, ILobbyServiceCallback callback)
        {
            if (lobby.Players.Count >= lobby.MatchInfo.MaxPlayers && !lobby.Players.ContainsKey(username))
            {
                SafeCallback(callback, () => callback.KickedFromLobby("Lobby is full."));
                return;
            }

            var connection = new PlayerConnection(username, callback);

            if (lobby.Players.TryAdd(username, connection))
            {
                Console.WriteLine($"Player {username} connected to lobby {lobby.MatchId}");
                BroadcastLobbyState(lobby);
            }
            else
            {
                if (lobby.Players.TryGetValue(username, out var existingConnection))
                {
                    lobby.Players.TryUpdate(username, connection, existingConnection);
                    Console.WriteLine($"Player {username} reconnected to lobby {lobby.MatchId}");

                    SafeCallback(callback, () => callback.UpdateLobbyState(lobby.GetCurrentState()));
                }
            }
        }

        private static void SafeCallback(ILobbyServiceCallback callback, Action action)
        {
            try
            {
                if (callback != null)
                {
                    action();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Callback failed: {ex.Message}");
            }
        }

        public void Disconnect(string username, string matchId)
        {
            if (_lobbies.TryGetValue(matchId, out Lobby lobby))
            {
                if (lobby.Players.TryRemove(username, out _))
                {
                    Console.WriteLine($"Player {username} disconnected from lobby {matchId}");

                    if (username.Equals(lobby.HostUsername, StringComparison.OrdinalIgnoreCase))
                    {
                        Console.WriteLine($"Host {username} left lobby {matchId}. Kicking all players.");
                        lobby.Broadcast(conn =>
                        {
                            SafeCallback(conn.Callback, () => conn.Callback.KickedFromLobby("Host cancelled the match."));
                        });
                        RemoveLobby(matchId);
                    }
                    else
                    {
                        BroadcastLobbyState(lobby);
                    }
                }

                if (!username.Equals(lobby.HostUsername, StringComparison.OrdinalIgnoreCase) && lobby.Players.IsEmpty)
                {
                    Console.WriteLine($"Lobby {matchId} is empty. Removing.");
                    RemoveLobby(matchId);
                }
            }
        }

        public void SendMessage(string senderUsername, string matchId, string messageKey)
        {
            if (_lobbies.TryGetValue(matchId, out Lobby lobby))
            {
                var messageDto = new ChatMessageDto
                {
                    SenderUsername = senderUsername,
                    MessageContent = messageKey,
                    Timestamp = DateTime.UtcNow
                };

                lobby.Broadcast(conn =>
                {
                    SafeCallback(conn.Callback, () => conn.Callback.ReceiveLobbyMessage(messageDto));
                });
            }
        }

        public void KickPlayer(string hostUsername, string playerToKickUsername, string matchId)
        {
            if (_lobbies.TryGetValue(matchId, out Lobby lobby))
            {
                if (!hostUsername.Equals(lobby.HostUsername, StringComparison.OrdinalIgnoreCase))
                {
                    Console.WriteLine($"Kick attempt failed: {hostUsername} is not the host of lobby {matchId}.");
                    return;
                }

                if (hostUsername.Equals(playerToKickUsername, StringComparison.OrdinalIgnoreCase))
                {
                    return;
                }

                if (lobby.Players.TryRemove(playerToKickUsername, out PlayerConnection kickedPlayerConnection))
                {
                    Console.WriteLine($"Player {playerToKickUsername} kicked from lobby {matchId} by host {hostUsername}.");
                    try
                    {
                        kickedPlayerConnection.Callback.KickedFromLobby("Kicked by the host.");
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Failed to notify kicked player {playerToKickUsername}: {ex.Message}");
                    }

                    BroadcastLobbyState(lobby);
                }
            }
        }

        public void StartGame(string hostUsername, string matchId)
        {
            if (_lobbies.TryGetValue(matchId, out Lobby lobby))
            {
                if (!hostUsername.Equals(lobby.HostUsername, StringComparison.OrdinalIgnoreCase))
                {
                    Console.WriteLine($"Start game attempt failed: {hostUsername} is not the host of lobby {matchId}.");
                    return;
                }

                if (lobby.Players.Count < 2)
                {
                    Console.WriteLine($"Start game attempt failed: Not enough players in lobby {matchId}.");
                }

                Console.WriteLine($"Host {hostUsername} starting game for lobby {matchId}.");
                lobby.StartCountdown();
            }
        }

        private static void BroadcastLobbyState(Lobby lobby)
        {
            var state = lobby.GetCurrentState();
            lobby.Broadcast(conn =>
            {
                SafeCallback(conn.Callback, () => conn.Callback.UpdateLobbyState(state));
            });
        }

        private static void RemoveLobby(string matchId)
        {
            if (_lobbies.TryRemove(matchId, out _))
            {
                Console.WriteLine($"Lobby {matchId} removed.");
            }
        }

        private MatchInfoDto GetMatchInfo(string matchId)
        {
            if (!int.TryParse(matchId, out int matchIdNumeric))
            {
                Console.WriteLine($"Error: MatchId '{matchId}' no es un ID numérico válido.");
                return null;
            }
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var match = context.Match
                        .Include("Player") 
                        .Include("MatchDifficulty") 
                        .FirstOrDefault(m => m.idMatch == matchIdNumeric);

                    if (match != null)
                    {
                        return new MatchInfoDto
                        {
                            MatchId = match.matchCode,
                            MatchName = match.matchName,
                            HostUsername = match.Player?.username,
                            DifficultyName = match.MatchDifficulty?.difficulty,
                            CurrentPlayers = _lobbies.TryGetValue(matchId, out var lobby) ? lobby.Players.Count : 0,
                            MaxPlayers = match.maxPlayers,
                            IsPrivate = match.isPrivate == 1
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error fetching match info for {matchId}: {ex.Message}");
            }
            return null;
        }

        public void CleanUpClient(ILobbyServiceCallback callback)
        {
            string userToRemove = null;
            string matchIdToRemove = null;

            foreach (var lobbyPair in _lobbies)
            {
                foreach (var playerPair in lobbyPair.Value.Players)
                {
                    if (playerPair.Value.Callback == callback)
                    {
                        userToRemove = playerPair.Key;
                        matchIdToRemove = lobbyPair.Key;
                        break;
                    }
                }
                if (userToRemove != null) break;
            }

            if (userToRemove != null && matchIdToRemove != null)
            {
                Disconnect(userToRemove, matchIdToRemove);
            }
        }

        public void StartKickVote(string voterUsername, string targetUsername, string matchId)
        {
            Console.WriteLine($"Player {voterUsername} started a kick vote for {targetUsername} in lobby {matchId}.");
        }

        public void SubmitKickVote(string voterUsername, string targetUsername, string matchId, bool vote)
        {
            Console.WriteLine($"Player {voterUsername} voted {vote} to kick {targetUsername} in lobby {matchId}.");
        }
    }
}
