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
using GuessMyMessServer.Properties.Langs;
using log4net;

namespace GuessMyMessServer.BusinessLogic
{
    public class LobbyLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(LobbyLogic));

        private static readonly ConcurrentDictionary<string, Lobby> _lobbies = new ConcurrentDictionary<string, Lobby>();
        private static readonly object _lock = new object();

        private readonly IMatchRepository _matchRepository;
        private readonly MatchmakingLogic _matchmakingLogic;

        public LobbyLogic(IMatchRepository matchRepository, MatchmakingLogic matchmakingLogic)
        {
            _matchRepository = matchRepository;
            _matchmakingLogic = matchmakingLogic;
        }

        private sealed class PlayerConnection
        {
            public string Username { get; }
            public string DisplayName { get; }
            public ILobbyServiceCallback Callback { get; }

            public PlayerConnection(string username, string displayName, ILobbyServiceCallback callback)
            {
                Username = username;
                DisplayName = displayName;
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

            public int GetNextGuestNumber() => _guestCounter++;

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
                    PlayerUsernames = Players.Values.Select(p => p.DisplayName).ToList()
                };
            }

            public void StartCountdown(ILog log, Action<string> onGameStarted)
            {
                _countdownSeconds = 5;
                log.Info($"Lobby {MatchId}: Countdown started.");

                Broadcast(conn => conn.Callback.OnGameStarting(_countdownSeconds));

                _countdownTimer = new Timer(state =>
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

                                log.Info($"Lobby {MatchId}: Game started.");
                                Broadcast(conn => conn.Callback.OnGameStarted());
                                onGameStarted?.Invoke(MatchId);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        log.Error($"Lobby {MatchId}: Error in countdown timer.", ex);
                    }
                }, null, TimeSpan.FromSeconds(1), TimeSpan.FromSeconds(1));
            }

            public void Broadcast(Action<PlayerConnection> action)
            {
                foreach (var playerConn in Players.Values)
                {
                    try
                    {
                        action(playerConn);
                    }
                    catch
                    {
                    }
                }
            }
        }

        public async Task ConnectAsync(string username, string matchId)
        {
            var callback = OperationContext.Current.GetCallbackChannel<ILobbyServiceCallback>();
            Lobby lobby = await GetOrCreateLobbyAsync(matchId, username, callback);

            if (lobby == null)
            {
                return;
            }

            AddPlayerToLobby(lobby, username, callback);
        }

        public void Disconnect(string username, string matchId)
        {
            _matchmakingLogic.HandlePlayerLeave(username, matchId);

            if (_lobbies.TryGetValue(matchId, out Lobby lobby))
            {
                if (lobby.Players.TryRemove(username, out PlayerConnection removedPlayer))
                {
                    _log.Info($"Player '{removedPlayer.DisplayName}' left lobby {matchId}.");

                    if (username.Equals(lobby.HostUsername, StringComparison.OrdinalIgnoreCase))
                    {
                        _log.Info($"Host left. Disbanding lobby {matchId}.");
                        lobby.Broadcast(conn =>
                        {
                            SafeCallback(conn.Callback, () => conn.Callback.KickedFromLobby(Lang.Error_HostLeft));
                        });
                        RemoveLobby(matchId);
                    }
                    else
                    {
                        BroadcastLobbyState(lobby);
                    }
                }

                if (lobby.Players.IsEmpty)
                {
                    RemoveLobby(matchId);
                }
            }
        }

        public void SendMessage(string senderUsername, string matchId, string messageContent)
        {
            if (_lobbies.TryGetValue(matchId, out Lobby lobby))
            {
                string senderDisplayName = senderUsername;

                if (lobby.Players.TryGetValue(senderUsername, out var senderConnection))
                {
                    senderDisplayName = senderConnection.DisplayName;
                }

                var messageDto = new ChatMessageDto
                {
                    SenderUsername = senderDisplayName,
                    MessageContent = messageContent,
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
                    _log.Warn($"Kick denied: '{hostUsername}' is not host of {matchId}.");
                    return;
                }

                var targetPair = lobby.Players.FirstOrDefault(p => p.Value.DisplayName.Equals(playerToKickUsername, StringComparison.OrdinalIgnoreCase));

                if (targetPair.Value == null)
                {
                    if (lobby.Players.TryGetValue(playerToKickUsername, out var conn))
                    {
                        targetPair = new KeyValuePair<string, PlayerConnection>(playerToKickUsername, conn);
                    }
                }

                if (targetPair.Value == null)
                {
                    _log.Warn($"Kick failed: Player '{playerToKickUsername}' not found in lobby.");
                    return;
                }

                string targetRealUsername = targetPair.Key;

                if (hostUsername.Equals(targetRealUsername, StringComparison.OrdinalIgnoreCase))
                {
                    return;
                }

                if (lobby.Players.TryRemove(targetRealUsername, out PlayerConnection kickedConn))
                {
                    _matchmakingLogic.HandlePlayerLeave(targetRealUsername, matchId);

                    _log.Info($"Player '{targetRealUsername}' kicked from {matchId}.");
                    SafeCallback(kickedConn.Callback, () => kickedConn.Callback.KickedFromLobby(Lang.Error_KickedByHost));

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
                    return;
                }

                if (lobby.Players.Count < 1)
                {
                    return;
                }

                _log.Info($"Starting game countdown for match {matchId}.");

                lobby.StartCountdown(_log, (id) =>
                {
                    _matchmakingLogic.SetMatchAsPlaying(id);
                    RemoveLobby(id);
                });
            }
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
                Disconnect(userToRemove, matchIdToRemove);
            }
        }

        private async Task<Lobby> GetOrCreateLobbyAsync(string matchId, string hostUsername, ILobbyServiceCallback callback)
        {
            if (_lobbies.TryGetValue(matchId, out Lobby existingLobby))
            {
                return existingLobby;
            }

            var matchInfo = await GetMatchInfoAsync(matchId);

            if (matchInfo == null)
            {
                SafeCallback(callback, () => callback.KickedFromLobby(Lang.Error_MatchNotFound));
                return null;
            }

            lock (_lock)
            {
                if (_lobbies.TryGetValue(matchId, out existingLobby))
                {
                    return existingLobby;
                }

                var newLobby = new Lobby(matchId, hostUsername, matchInfo);
                _lobbies.TryAdd(matchId, newLobby);
                _log.Info($"Lobby {matchId} initialized in memory.");
                return newLobby;
            }
        }

        private async Task<MatchInfoDto> GetMatchInfoAsync(string matchId)
        {
            if (!int.TryParse(matchId, out int id))
            {
                return null;
            }

            try
            {
                var match = await _matchRepository.GetMatchByIdAsync(id);
                if (match == null || match.matchStatus != "Waiting")
                {
                    return null;
                }

                string diffName = await _matchRepository.GetDifficultyNameAsync(match.MatchDifficulty_idMatchDifficulty.GetValueOrDefault());

                return new MatchInfoDto
                {
                    MatchId = matchId,
                    MatchCode = match.matchCode,
                    MatchName = match.matchName,
                    HostUsername = "Host",
                    DifficultyName = diffName,
                    MaxPlayers = match.maxPlayers,
                    IsPrivate = match.isPrivate == 1
                };
            }
            catch (Exception ex)
            {
                _log.Error($"Error fetching match info for {matchId}", ex);
                return null;
            }
        }

        private void AddPlayerToLobby(Lobby lobby, string username, ILobbyServiceCallback callback)
        {
            if (lobby.Players.Count >= lobby.MatchInfo.MaxPlayers && !lobby.Players.ContainsKey(username))
            {
                SafeCallback(callback, () => callback.KickedFromLobby(Lang.Error_LobbyFull));
                return;
            }

            string displayName = username;
            bool isGuest = false;

            if (username.StartsWith("Guest_"))
            {
                if (lobby.Players.TryGetValue(username, out var existing))
                {
                    displayName = existing.DisplayName;
                }
                else
                {
                    displayName = $"{Lang.Info_Guest} {lobby.GetNextGuestNumber()}";
                    isGuest = true;
                }
            }

            var connection = new PlayerConnection(username, displayName, callback);

            if (lobby.Players.TryAdd(username, connection))
            {
                _log.Info($"Player '{displayName}' added to lobby {lobby.MatchId}.");

                if (isGuest)
                {
                    SafeCallback(callback, () => callback.ReceiveLobbyMessage(new ChatMessageDto
                    {
                        SenderUsername = "System",
                        MessageContent = $"{Lang.Info_GuestName} {displayName}",
                        Timestamp = DateTime.UtcNow
                    }));
                }

                BroadcastLobbyState(lobby);
            }
            else
            {
                if (lobby.Players.TryGetValue(username, out var oldConn))
                {
                    var newConn = new PlayerConnection(username, oldConn.DisplayName, callback);
                    lobby.Players.TryUpdate(username, newConn, oldConn);
                    _log.Info($"Player '{username}' reconnected to lobby.");
                    SafeCallback(callback, () => callback.UpdateLobbyState(lobby.GetCurrentState()));
                }
            }
        }

        private static void BroadcastLobbyState(Lobby lobby)
        {
            var state = lobby.GetCurrentState();
            lobby.Broadcast(conn => conn.Callback.UpdateLobbyState(state));
        }

        private static void RemoveLobby(string matchId)
        {
            _lobbies.TryRemove(matchId, out _);
        }

        private static void SafeCallback(ILobbyServiceCallback callback, Action action)
        {
            try
            {
                action();
            }
            catch (Exception ex)
            {
                _log.Warn("Error in Lobby callback (client likely disconnected).", ex);
            }
        }

        private void ThrowServiceFault(ServiceErrorType type, string message)
        {
            var fault = new ServiceFaultDto(type, message);
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason(message));
        }
    }
}
