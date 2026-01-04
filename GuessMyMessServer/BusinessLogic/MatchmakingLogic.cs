using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using Autofac;
using GuessMyMessServer.AppStart;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.DataAccess.Abstractions;
using GuessMyMessServer.Utilities;
using GuessMyMessServer.Utilities.Email;
using GuessMyMessServer.Utilities.Email.Templates;
using log4net;

namespace GuessMyMessServer.BusinessLogic
{
    public class MatchmakingLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(MatchmakingLogic));
        private const string MatchStatusWaiting = "Waiting";

        private static readonly ConcurrentDictionary<string, IMatchmakingServiceCallback> _connectedUsers =
            new ConcurrentDictionary<string, IMatchmakingServiceCallback>();

        private static readonly ConcurrentDictionary<string, MatchLobby> _activeLobbies =
            new ConcurrentDictionary<string, MatchLobby>();

        private readonly IMatchRepository _matchRepository;
        private readonly IPlayerRepository _playerRepository;
        private readonly IEmailService _emailService;

        public MatchmakingLogic(
            IMatchRepository matchRepository,
            IPlayerRepository playerRepository,
            IEmailService emailService)
        {
            _matchRepository = matchRepository;
            _playerRepository = playerRepository;
            _emailService = emailService;
        }

        public void ConnectUser(string username)
        {
            var callback = OperationContext.Current.GetCallbackChannel<IMatchmakingServiceCallback>();
            _connectedUsers.AddOrUpdate(username, callback, (key, old) => callback);
            _log.InfoFormat("User '{0}' connected to Matchmaking.", username);
        }

        public void DisconnectUser(string username)
        {
            _connectedUsers.TryRemove(username, out _);
            _log.InfoFormat("User '{0}' disconnected from Matchmaking.", username);
            var lobby = _activeLobbies.Values.FirstOrDefault(l => l.Players.Contains(username));
            if (lobby != null)
            {
                HandlePlayerLeave(username, lobby.MatchId);
            }
        }

        public async Task<OperationResultDto> CreateMatchAsync(string hostUsername, LobbySettingsDto settings)
        {
            var hostPlayer = await _playerRepository.GetPlayerByUsernameAsync(hostUsername);
            if (hostPlayer == null)
            {
                _log.WarnFormat("CreateMatch failed: Host '{0}' not found.", hostUsername);
                ThrowServiceFault(ServiceErrorType.NotFound, "Host user not found.");
            }

            string newMatchCode = null;
            byte isPrivateValue = (byte)(settings.IsPrivate ? 1 : 0);

            if (settings.IsPrivate)
            {
                newMatchCode = GenerateMatchCode(8);
                while (await _matchRepository.MatchCodeExistsAsync(newMatchCode))
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

            _matchRepository.AddMatch(newMatch);

            try
            {
                await _matchRepository.SaveChangesAsync();

                string matchId = newMatch.idMatch.ToString();

                var lobby = new MatchLobby(matchId, newMatchCode, hostUsername, settings);
                lobby.Players.Add(hostUsername);
                lobby.CurrentPlayers = 1;
                lobby.DifficultyName = await _matchRepository.GetDifficultyNameAsync(settings.DifficultyId);

                _activeLobbies.TryAdd(matchId, lobby);

                _log.InfoFormat("Match created: {0} by {1}", matchId, hostUsername);
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
            catch (Exception ex)
            {
                _log.Error($"Error creating match for '{hostUsername}'", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not create match.");
                return null;
            }
        }

        public List<MatchInfoDto> GetPublicMatches()
        {
            return _activeLobbies.Values
                .Where(l => !l.Settings.IsPrivate && l.Status == MatchStatusWaiting)
                .Select(l => l.ToMatchInfoDto())
                .ToList();
        }

        public async Task<OperationResultDto> JoinPublicMatchAsync(string username, string matchId)
        {
            if (!_connectedUsers.ContainsKey(username))
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "User not connected to matchmaking.");
            }

            if (!_activeLobbies.TryGetValue(matchId, out var lobby))
            {
                ThrowServiceFault(ServiceErrorType.MatchNotFound, "Match not found or expired.");
            }

            return await JoinLobbyInternalAsync(username, lobby);
        }

        public async Task<OperationResultDto> JoinPrivateMatchAsync(string username, string matchCode)
        {
            if (string.IsNullOrWhiteSpace(matchCode))
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Match code is required.");
            }

            var lobby = _activeLobbies.Values.FirstOrDefault(l => l.MatchCode == matchCode && l.Status == MatchStatusWaiting);

            if (lobby == null)
            {
                ThrowServiceFault(ServiceErrorType.MatchNotFound, "Invalid or expired match code.");
            }

            return await JoinLobbyInternalAsync(username, lobby);
        }

        private async Task<OperationResultDto> JoinLobbyInternalAsync(string username, MatchLobby lobby)
        {
            if (lobby.Players.Contains(username))
            {
                return new OperationResultDto { Success = true, Message = "Already in match.", Data = new Dictionary<string, string> { { "MatchId", lobby.MatchId } } };
            }

            if (lobby.CurrentPlayers >= lobby.Settings.MaxPlayers)
            {
                ThrowServiceFault(ServiceErrorType.LobbyFull, "The match is full.");
            }

            if (lobby.Status != MatchStatusWaiting)
            {
                ThrowServiceFault(ServiceErrorType.GameInProgress, "Match has already started.");
            }

            lobby.Players.Add(username);
            lobby.CurrentPlayers++;

            await UpdatePlayerCountInDbAsync(lobby.MatchId, 1);

            _log.InfoFormat("User '{0}' joined match {1}.", username, lobby.MatchId);

            BroadcastLobbyUpdate(lobby);
            if (!lobby.Settings.IsPrivate)
            {
                BroadcastPublicMatchList();
            }

            return new OperationResultDto
            {
                Success = true,
                Message = "Joined successfully.",
                Data = new Dictionary<string, string> { { "MatchId", lobby.MatchId } }
            };
        }

        public void InviteToMatch(string inviterUsername, string invitedUsername, string matchId)
        {
            if (_connectedUsers.TryGetValue(invitedUsername, out var callback))
            {
                SafeCallback(callback, c => c.ReceiveMatchInvite(inviterUsername, matchId));
                _log.InfoFormat("Invite sent: {0} -> {1} (Match {2})",
                    inviterUsername,
                    invitedUsername,
                    matchId);
            }
            else
            {
                _log.InfoFormat("Invite failed: {0} not connected.", invitedUsername);
            }
        }

        public async Task InviteGuestByEmailAsync(string inviterUsername, string targetEmail, string matchId)
        {
            var existingUser = await _playerRepository.GetPlayerByEmailAsync(targetEmail);
            if (existingUser != null)
            {
                ThrowServiceFault(ServiceErrorType.EmailAlreadyRegistered, "User is already registered. Invite them by username.");
            }

            string code = GuestInviteManager.CreateInvite(targetEmail, matchId);

            try
            {
                var emailTemplate = new InvitationForMatchEmailTemplate(code);
                await _emailService.SendEmailAsync(targetEmail, "Game Invitation", emailTemplate);
                _log.InfoFormat("Guest invite sent to {0}", targetEmail);
            }
            catch (Exception ex)
            {
                _log.Error($"Error sending guest invite to {targetEmail}", ex);
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Could not send invitation email.");
            }
        }

        public void HandlePlayerLeave(string username, string matchId)
        {
            if (_activeLobbies.TryGetValue(matchId, out var lobby))
            {
                bool removed = lobby.Players.Remove(username);
                if (removed)
                {
                    lobby.CurrentPlayers--;
                    _ = UpdatePlayerCountInDbAsync(matchId, -1);
                    _log.Info($"Player {username} left {matchId}.");
                }

                if (lobby.Players.Count == 0 || (lobby.HostUsername == username && lobby.Status == "Waiting"))
                {
                    _log.Info($"Closing lobby {matchId}.");
                    _activeLobbies.TryRemove(matchId, out _);

                    if (lobby.Status != "Finished")
                    {
                        _ = UpdateMatchStatusInDbAsync(matchId, "Aborted");
                    }

                    if (!lobby.Settings.IsPrivate)
                    {
                        BroadcastPublicMatchList();
                    }
                }
                else if (removed)
                {
                    BroadcastLobbyUpdate(lobby);
                    if (!lobby.Settings.IsPrivate)
                    {
                        BroadcastPublicMatchList();
                    }
                }
            }
        }

        public void SetMatchAsPlaying(string matchId)
        {
            if (_activeLobbies.TryGetValue(matchId, out var lobby))
            {
                lobby.Status = "Playing";
                _ = UpdateMatchStatusInDbAsync(matchId, "Playing");
                BroadcastPublicMatchList();
            }
        }

        public static void SetMatchAsFinished(string matchId)
        {
            if (_activeLobbies.TryGetValue(matchId, out var lobby))
            {
                lobby.Status = "Finished";
            }
        }

        private async Task UpdatePlayerCountInDbAsync(string matchIdStr, int change)
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
                    match.currentPlayers += change;
                    if (match.currentPlayers < 0)
                    {
                        match.currentPlayers = 0;
                    }
                    await _matchRepository.SaveChangesAsync();
                }
            }
            catch (Exception ex)
            {
                _log.Error($"Error updating player count DB for match {matchId}", ex);
            }
        }

        private static async Task UpdateMatchStatusInDbAsync(string matchIdStr, string status)
        {
            if (!int.TryParse(matchIdStr, out int matchId))
            {
                return;
            }

            using (var scope = Bootstrapper.Container.BeginLifetimeScope())
            {
                try
                {
                    var matchRepo = scope.Resolve<IMatchRepository>();

                    var match = await matchRepo.GetMatchByIdAsync(matchId);
                    if (match != null)
                    {
                        match.matchStatus = status;
                        await matchRepo.SaveChangesAsync();
                    }
                }
                catch (Exception ex)
                {
                    _log.Error($"Error updating status DB for match {matchId}", ex);
                }
            }
        }

        private void BroadcastPublicMatchList()
        {
            var list = GetPublicMatches();
            foreach (var cb in _connectedUsers.Values)
            {
                SafeCallback(cb, c => c.PublicMatchesListUpdated(list));
            }
        }

        private void BroadcastLobbyUpdate(MatchLobby lobby)
        {
            var info = lobby.ToMatchInfoDto();
            foreach (var p in lobby.Players)
            {
                if (_connectedUsers.TryGetValue(p, out var cb))
                {
                    SafeCallback(cb, c => c.MatchUpdate(info));
                }
            }
        }

        private static void SafeCallback(IMatchmakingServiceCallback callback, Action<IMatchmakingServiceCallback> action)
        {
            try
            {
                action(callback);
            }
            catch (CommunicationException ex)
            {
                // CORRECCIÓN: Registramos como Debug porque es un evento esperado 
                // cuando un jugador cierra el juego o pierde internet.
                _log.Debug("Matchmaking callback failed: Client communication lost.", ex);
            }
            catch (TimeoutException ex)
            {
                // CORRECCIÓN: Los timeouts pueden indicar saturación de red.
                _log.Warn("Matchmaking callback timed out.", ex);
            }
            catch (Exception ex)
            {
                // CORRECCIÓN: Cualquier otro error inesperado debe registrarse como Error 
                // para que sepas si hay un bug en tu lógica.
                _log.Error("Unexpected error in matchmaking callback.", ex);
            }
        }

        private static string GenerateMatchCode(int length)
        {
            const string chars = "ABCDEFGHIJKLMNPQRSTUVWXYZ123456789";
            using (var crypto = new RNGCryptoServiceProvider())
            {
                var data = new byte[length];
                crypto.GetBytes(data);
                var result = new StringBuilder(length);
                foreach (byte b in data) result.Append(chars[b % chars.Length]);
                return result.ToString();
            }
        }

        private static void ThrowServiceFault(ServiceErrorType type, string message)
        {
            throw new FaultException<ServiceFaultDto>(new ServiceFaultDto(type, message), new FaultReason(message));
        }
    }

    public class MatchLobby
    {
        public string MatchId { get; set; }
        public string MatchCode { get; set; }
        public string HostUsername { get; set; }
        public LobbySettingsDto Settings { get; set; }
        public List<string> Players { get; set; } = new List<string>();
        public string Status { get; set; } = "Waiting";
        public int CurrentPlayers { get; set; }
        public string DifficultyName { get; set; }

        public MatchLobby(string matchId, string matchCode, string host, LobbySettingsDto settings)
        {
            MatchId = matchId;
            MatchCode = matchCode;
            HostUsername = host;
            Settings = settings;
        }

        public MatchInfoDto ToMatchInfoDto()
        {
            return new MatchInfoDto
            {
                MatchId = this.MatchId,
                MatchName = this.Settings.MatchName,
                HostUsername = this.HostUsername,
                CurrentPlayers = this.CurrentPlayers,
                MaxPlayers = this.Settings.MaxPlayers,
                DifficultyName = this.DifficultyName ?? "Unknown"
            };
        }
    }
}
