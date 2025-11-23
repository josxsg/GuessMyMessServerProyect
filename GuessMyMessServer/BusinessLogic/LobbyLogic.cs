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
using System.Linq;
using System.ServiceModel;
using System.Threading;

namespace GuessMyMessServer.BusinessLogic
{
    public class LobbyLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(LobbyLogic));

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
            private volatile bool _gameHasStarted = false;
            private int _guestCounter = 1;

            public int GetNextGuestNumber()
            {
                return _guestCounter++;
            }

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
                    MatchCode = MatchInfo.IsPrivate ? MatchInfo.MatchCode : null,
                    PlayerUsernames = Players.Keys.ToList()
                };
            }

            public void StartCountdown()
            {
                _countdownSeconds = 5;
                _log.Info($"Lobby {MatchId}: Countdown started.");
                Broadcast(conn => conn.Callback.OnGameStarting(_countdownSeconds));
                _countdownTimer = new Timer(CountdownTick, null, TimeSpan.FromSeconds(1), TimeSpan.FromSeconds(1));
            }

            private void CountdownTick(object state)
            {
                try
                {
                    _countdownTimer?.Change(Timeout.Infinite, Timeout.Infinite);
                    _countdownSeconds--;

                    if (_countdownSeconds > 0)
                    {
                        Broadcast(conn => conn.Callback.OnGameStarting(_countdownSeconds));
                        _countdownTimer?.Change(TimeSpan.FromSeconds(1), TimeSpan.FromSeconds(1));
                    }
                    else
                    {
                        if (!_gameHasStarted)
                        {
                            _gameHasStarted = true;
                            _countdownTimer?.Dispose();
                            _countdownTimer = null;

                            _log.Info($"Lobby {MatchId}: Game started. Disbanding lobby instance.");
                            Broadcast(conn => conn.Callback.OnGameStarted());
                            MatchmakingLogic.SetMatchAsPlaying(MatchId);
                            LobbyLogic.RemoveLobby(MatchId);
                        }
                        else
                        {
                            _countdownTimer?.Dispose();
                            _countdownTimer = null;
                        }
                    }
                }
                catch (ObjectDisposedException objEx)
                {
                    _log.Info($"Lobby {MatchId}: Timer accessed after disposal (Game likely started or lobby closed).", objEx);
                }
                catch (Exception ex)
                {
                    _log.Error($"Lobby {MatchId}: Critical error in countdown timer.", ex);
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
                    catch (CommunicationException comEx)
                    {
                        _log.Warn($"Failed to broadcast to '{playerConn.Username}' in lobby {MatchId}. Connection issue.", comEx);
                    }
                    catch (TimeoutException timeEx)
                    {
                        _log.Warn($"Timeout broadcasting to '{playerConn.Username}' in lobby {MatchId}.", timeEx);
                    }
                    catch (ObjectDisposedException dispEx)
                    {
                        _log.Warn($"Broadcast failed: Channel disposed for '{playerConn.Username}'.", dispEx);
                    }
                    catch (Exception ex)
                    {
                        _log.Error($"Unexpected error broadcasting to '{playerConn.Username}'", ex);
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
                    _log.Warn($"Connection failed: Match {matchId} not found in database.");
                    SafeCallback(callback, () => callback.KickedFromLobby("Match not found."));
                    return null;
                }

                lobby = new Lobby(matchId, hostUsername, matchInfo);

                if (!_lobbies.TryAdd(matchId, lobby))
                {
                    _lobbies.TryGetValue(matchId, out lobby);
                }
                else
                {
                    _log.Info($"Lobby created in memory for match {matchId}. Host candidate: {hostUsername}");
                }
            }

            return lobby;
        }

        private void AddPlayerToLobby(Lobby lobby, string username, ILobbyServiceCallback callback)
        {
            if (lobby.Players.Count >= lobby.MatchInfo.MaxPlayers && !lobby.Players.ContainsKey(username))
            {
                _log.Info($"Connection denied: Lobby {lobby.MatchId} is full. Rejecting {username}.");
                SafeCallback(callback, () => callback.KickedFromLobby("Lobby is full."));
                return;
            }

            string finalDisplayName = username;

            if (username.StartsWith("Guest_"))
            {
                int guestNum = lobby.GetNextGuestNumber();
                finalDisplayName = $"Invitado {guestNum}";
                _log.Info($"Guest '{username}' renamed to '{finalDisplayName}'");
            }

            var connection = new PlayerConnection(finalDisplayName, callback);


            if (lobby.Players.TryAdd(finalDisplayName, connection)) // Usamos el nombre bonito como Key
            {
                _log.Info($"Player '{finalDisplayName}' joined lobby {lobby.MatchId}.");

                // Notificar al cliente ESPECÍFICO cuál es su nombre real asignado
                // Necesitas agregar un método al callback o reutilizar uno.
                // Lo más fácil es asumir que el cliente actualizará su SessionManager al recibir el LobbyState 
                // o mandar un mensaje directo.

                // HACK: Enviamos un mensaje de sistema solo a él
                callback.ReceiveLobbyMessage(new ChatMessageDto 
                {
                    SenderUsername = "System", MessageContent = $"Bienvenido! Juegas como: {finalDisplayName}", 
                    Timestamp = DateTime.UtcNow
                });

                BroadcastLobbyState(lobby);
            }
            else
            {
                if (lobby.Players.TryGetValue(username, out var existingConnection))
                {
                    lobby.Players.TryUpdate(username, connection, existingConnection);
                    _log.Info($"Player '{username}' reconnected to lobby {lobby.MatchId}.");

                    SafeCallback(callback, () => callback.UpdateLobbyState(lobby.GetCurrentState()));
                }
            }
        }

        private static void SafeCallback(ILobbyServiceCallback callback, Action action)
        {
            if (callback == null)
            {
                return;
            }
            try
            {
                action();
            }
            catch (CommunicationException comEx)
            {
                _log.Warn($"SafeCallback: Client disconnected or unreachable.", comEx);
            }
            catch (TimeoutException timeEx)
            {
                _log.Warn($"SafeCallback: Operation timed out.", timeEx);
            }
            catch (ObjectDisposedException objEx)
            {
                _log.Info($"SafeCallback: Channel was closed/disposed before call.", objEx);
            }
            catch (Exception ex)
            {
                _log.Error($"SafeCallback: Unexpected error.", ex);
            }
        }

        public void Disconnect(string username, string matchId)
        {
            MatchmakingLogic.HandlePlayerLeave(username, matchId);

            if (_lobbies.TryGetValue(matchId, out Lobby lobby))
            {
                if (lobby.Players.TryRemove(username, out _))
                {
                    _log.Info($"Player '{username}' left lobby {matchId}.");

                    if (username.Equals(lobby.HostUsername, StringComparison.OrdinalIgnoreCase))
                    {
                        _log.Info($"Host '{username}' left. Disbanding lobby {matchId}.");
                        lobby.Broadcast(conn =>
                        {
                            try
                            {
                                conn.Callback.KickedFromLobby("Host cancelled the match.");
                            }
                            catch (CommunicationException cmEx)
                            {
                                _log.Warn($"Could not notify kick to {conn.Username} (Connection lost).", cmEx);
                            }
                            catch (TimeoutException tmEx)
                            {
                                _log.Warn($"Timeout notifying kick to {conn.Username}.", tmEx);
                            }
                            catch (Exception ex)
                            {
                                _log.Error($"Error notifying kick to {conn.Username}", ex);
                            }
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
                    _log.Info($"Lobby {matchId} is empty. Removing.");
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

                lobby.Broadcast(conn => conn.Callback.ReceiveLobbyMessage(messageDto));
            }
        }

        public void KickPlayer(string hostUsername, string playerToKickUsername, string matchId)
        {
            if (_lobbies.TryGetValue(matchId, out Lobby lobby))
            {
                if (!hostUsername.Equals(lobby.HostUsername, StringComparison.OrdinalIgnoreCase))
                {
                    _log.Warn($"Kick failed: '{hostUsername}' attempted to kick '{playerToKickUsername}' but is not the host of {matchId}.");
                    return;
                }

                if (hostUsername.Equals(playerToKickUsername, StringComparison.OrdinalIgnoreCase))
                {
                    _log.Warn($"Kick ignored: Host '{hostUsername}' tried to kick themselves.");
                    return;
                }

                if (lobby.Players.TryRemove(playerToKickUsername, out PlayerConnection kickedPlayerConnection))
                {
                    MatchmakingLogic.HandlePlayerLeave(playerToKickUsername, matchId);
                    _log.Info($"Player '{playerToKickUsername}' was kicked from lobby {matchId} by '{hostUsername}'.");

                    SafeCallback(kickedPlayerConnection.Callback, () => kickedPlayerConnection.Callback.KickedFromLobby("Kicked by the host."));

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
                    _log.Warn($"StartGame denied: '{hostUsername}' is not the host of {matchId}.");
                    return;
                }

                if (lobby.Players.Count < 2)
                {
                    _log.Info($"StartGame failed: Not enough players in lobby {matchId} (Count: {lobby.Players.Count}).");
                    return;
                }

                _log.Info($"Host '{hostUsername}' initiated game start for {matchId}.");
                lobby.StartCountdown();
            }
        }

        private static void BroadcastLobbyState(Lobby lobby)
        {
            var state = lobby.GetCurrentState();
            lobby.Broadcast(conn => conn.Callback.UpdateLobbyState(state));
        }

        public static void RemoveLobby(string matchId)
        {
            if (_lobbies.TryRemove(matchId, out _))
            {
                _log.Info($"Lobby {matchId} removed from memory.");
            }
        }

        private MatchInfoDto GetMatchInfo(string matchId)
        {
            if (!int.TryParse(matchId, out int matchIdNumeric))
            {
                _log.Warn($"GetMatchInfo: Invalid MatchId format '{matchId}'. Expected integer.");
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
                        if (match.matchStatus != "Waiting")
                        {
                            _log.Warn($"Connection refused: Match {matchId} is in status '{match.matchStatus}'.");
                            return null;
                        }

                        return new MatchInfoDto
                        {
                            MatchId = matchId,
                            MatchCode = match.matchCode,
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
            catch (EntityException entityEx)
            {
                _log.Error($"Database entity error fetching match info for {matchId}", entityEx);
            }
            catch (DataException dataEx)
            {
                _log.Error($"Database data error fetching match info for {matchId}", dataEx);
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

                if (userToRemove != null)
                {
                    break;
                }
            }

            if (userToRemove != null && matchIdToRemove != null)
            {
                _log.Info($"CleanUpClient: Found stale connection for '{userToRemove}' in lobby {matchIdToRemove}. Disconnecting.");
                Disconnect(userToRemove, matchIdToRemove);
            }
        }

        public void StartKickVote(string voterUsername, string targetUsername, string matchId)
        {
            _log.Info($"Vote kick started: '{voterUsername}' wants to kick '{targetUsername}' in lobby {matchId}.");
        }

        public void SubmitKickVote(string voterUsername, string targetUsername, string matchId, bool vote)
        {
            _log.Info($"Vote cast: '{voterUsername}' voted {(vote ? "YES" : "NO")} to kick '{targetUsername}' in lobby {matchId}.");
        }
    }
}