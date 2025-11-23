using System;
using System.Collections.Generic;
using System.ServiceModel;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.Properties;
using GuessMyMessServer.Properties.Langs;
using log4net;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class MatchmakingService : IMatchmakingService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(MatchmakingService));

        private readonly IMatchmakingServiceCallback _callback;
        private string _connectedUsername;

        public MatchmakingService()
        {
            _callback = OperationContext.Current.GetCallbackChannel<IMatchmakingServiceCallback>();

            IContextChannel channel = OperationContext.Current.Channel;
            channel.Closing += Channel_Closing;
            channel.Faulted += Channel_Faulted;
        }

        public void Connect(string username)
        {
            try
            {
                _connectedUsername = username;
                _log.Info($"MatchmakingService: User '{username}' connected.");
                MatchmakingLogic.ConnectUser(username, _callback);
            }
            catch (Exception ex)
            {
                _log.Error($"Error connecting user '{username}' to matchmaking.", ex);
            }
        }

        public void Disconnect(string username)
        {
            try
            {
                if (!string.IsNullOrEmpty(_connectedUsername) && _connectedUsername != username)
                {
                    _log.Warn($"Disconnect warning: Session user '{_connectedUsername}' received disconnect request for '{username}'.");
                }

                PerformDisconnect();
            }
            catch (Exception ex)
            {
                _log.Warn($"Error during manual disconnect for '{username}'", ex);
            }
        }

        public List<MatchInfoDto> GetPublicMatches()
        {
            try
            {
                return MatchmakingLogic.GetPublicMatches();
            }
            catch (Exception ex)
            {
                _log.Error("Error retrieving public matches list.", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_ServerGeneric),
                    new FaultReason("Server Error"));
            }
        }

        public OperationResultDto CreateMatch(string hostUsername, LobbySettingsDto settings)
        {
            if (!IsSessionValid(hostUsername))
            {
                return new OperationResultDto { Success = false, Message = Lang.Error_SessionMismatch };
            }

            try
            {
                return MatchmakingLogic.CreateMatch(hostUsername, settings);
            }
            catch (Exception ex)
            {
                _log.Error($"Error creating match for host '{hostUsername}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.OperationFailed, Lang.Error_ServerGeneric),
                    new FaultReason("Creation Failed"));
            }
        }

        public void JoinPublicMatch(string username, string matchId)
        {
            if (!IsSessionValid(username))
            {
                NotifyCallbackError(Lang.Error_SessionMismatch);
                return;
            }

            try
            {
                MatchmakingLogic.JoinPublicMatch(username, matchId);
            }
            catch (Exception ex)
            {
                _log.Error($"Error joining public match '{matchId}' for user '{username}'", ex);
                NotifyCallbackError(Lang.Error_JoiningLobbyData);
            }
        }

        public OperationResultDto JoinPrivateMatch(string username, string matchCode)
        {
            if (!IsSessionValid(username))
            {
                return new OperationResultDto { Success = false, Message = Lang.Error_SessionMismatch };
            }

            try
            {
                return MatchmakingLogic.JoinPrivateMatch(username, matchCode);
            }
            catch (Exception ex)
            {
                _log.Error($"Error joining private match for user '{username}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.OperationFailed, Lang.Error_ServerGeneric),
                    new FaultReason("Join Failed"));
            }
        }

        public void InviteToMatch(string inviterUsername, string invitedUsername, string matchId)
        {
            if (!IsSessionValid(inviterUsername))
            {
                NotifyCallbackError(Lang.Error_SessionMismatch);
                return;
            }

            try
            {
                MatchmakingLogic.InviteToMatch(inviterUsername, invitedUsername, matchId);
            }
            catch (Exception ex)
            {
                _log.Warn($"Error sending invite from '{inviterUsername}' to '{invitedUsername}'", ex);
            }
        }

        public void InviteGuestByEmail(string inviterUsername, string targetEmail, string matchId)
        {
            // 1. Seguridad: Validar que quien llama al servicio es quien dice ser
            if (!IsSessionValid(inviterUsername))
            {
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.OperationFailed, "Sesión inválida."),
                    new FaultReason("Session Error"));
            }

            try
            {
                // 2. Delegar al Núcleo: Llamamos a la lógica que acabamos de crear
                MatchmakingLogic.InviteGuestByEmail(inviterUsername, targetEmail, matchId);
            }
            catch (InvalidOperationException ex) when (ex.Message == "EmailAlreadyRegistered")
            {
                // Manejo específico del error de negocio "Usuario ya registrado"
                _log.Info($"InviteGuest blocked: Email '{targetEmail}' is already a registered user.");

                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.EmailAlreadyRegistered, "Este usuario ya tiene cuenta registrada."),
                    new FaultReason("Email Already Registered"));
            }
            catch (Exception ex)
            {
                // Manejo de cualquier otro error imprevisto (BD caída, error de lógica, etc.)
                _log.Error($"Error invoking InviteGuestByEmail logic for {targetEmail}", ex);

                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.OperationFailed, "Error interno al procesar la invitación."),
                    new FaultReason("Server Error"));
            }
        }

        private void PerformDisconnect()
        {
            if (!string.IsNullOrEmpty(_connectedUsername))
            {
                MatchmakingLogic.DisconnectUser(_connectedUsername);
                _log.Info($"MatchmakingService: Cleaned up session for '{_connectedUsername}'.");
                _connectedUsername = null;
            }
        }

        private bool IsSessionValid(string username)
        {
            if (_connectedUsername == username)
            {
                return true;
            }

            _log.Warn($"Auth mismatch: Session owner is '{_connectedUsername ?? "null"}' but request came for '{username}'.");
            return false;
        }

        private void NotifyCallbackError(string message)
        {
            try
            {
                _callback?.MatchmakingFailed(message);
            }
            catch (Exception ex)
            {
                _log.Warn("Failed to send MatchmakingFailed callback to client.", ex);
            }
        }

        private void Channel_Faulted(object sender, EventArgs e)
        {
            _log.Warn($"Channel faulted for user '{_connectedUsername ?? "Unknown"}'. Disconnecting.");
            PerformDisconnect();
        }

        private void Channel_Closing(object sender, EventArgs e)
        {
            PerformDisconnect();
        }
    }
}
