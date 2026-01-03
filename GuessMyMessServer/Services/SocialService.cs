using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;
using Autofac;
using GuessMyMessServer.AppStart;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using log4net;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class SocialService : ISocialService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(SocialService));

        // Propiedad para resolver la lógica bajo demanda (Nuevo DbContext por llamada)
        private SocialLogic Logic => Bootstrapper.Container.Resolve<SocialLogic>();

        // Gestión de Clientes Conectados (Estático para persistir entre llamadas PerCall)
        private static readonly Dictionary<string, ISocialServiceCallback> ConnectedClients = new Dictionary<string, ISocialServiceCallback>();
        private static readonly object _clientLock = new object();

        // Constructor WCF
        public SocialService()
        {
            Bootstrapper.Init();
        }

        // Constructor Inyección (opcional para tests)
        public SocialService(SocialLogic socialLogic)
        {
            // No guardamos la instancia, confiamos en el contenedor
        }

        public void Connect(string username)
        {
            if (string.IsNullOrWhiteSpace(username)) return;
            try
            {
                var callback = OperationContext.Current.GetCallbackChannel<ISocialServiceCallback>();
                lock (_clientLock)
                {
                    if (ConnectedClients.ContainsKey(username)) ConnectedClients[username] = callback;
                    else ConnectedClients.Add(username, callback);
                }
                _log.Info($"SocialService: User '{username}' connected.");

                Task.Run(async () => {
                    await Logic.UpdatePlayerStatusAsync(username, "Online");
                    await NotifyFriendStatusUpdate(username, "Online");
                });
            }
            catch (Exception ex) { _log.Error($"Error connecting user '{username}'", ex); }
        }

        public void Disconnect(string username)
        {
            if (string.IsNullOrWhiteSpace(username)) return;
            try
            {
                lock (_clientLock) { if (ConnectedClients.ContainsKey(username)) ConnectedClients.Remove(username); }
                _log.Info($"SocialService: User '{username}' disconnected.");

                Task.Run(async () => {
                    await Logic.UpdatePlayerStatusAsync(username, "Offline");
                    await NotifyFriendStatusUpdate(username, "Offline");
                });
            }
            catch (Exception ex) { _log.Warn($"Error disconnecting user '{username}'", ex); }
        }

        public async Task<List<FriendDto>> GetFriendsListAsync(string username)
        {
            var friends = await Logic.GetFriendsListAsync(username);
            lock (_clientLock)
            {
                foreach (var friend in friends)
                {
                    if (ConnectedClients.ContainsKey(friend.Username)) friend.IsOnline = true;
                }
            }
            return friends;
        }

        public async Task<List<FriendRequestInfoDto>> GetFriendRequestsAsync(string username) => await Logic.GetFriendRequestsAsync(username);
        public async Task<List<UserProfileDto>> SearchUsersAsync(string searchUsername, string requesterUsername) => await Logic.SearchUsersAsync(searchUsername, requesterUsername);

        public async void SendFriendRequest(string requesterUsername, string targetUsername)
        {
            try
            {
                await Logic.SendFriendRequestAsync(requesterUsername, targetUsername);
                NotifyIfConnected(targetUsername, cb => cb.NotifyFriendRequest(requesterUsername));
            }
            catch (Exception ex) { _log.Error($"Error sending friend request", ex); }
        }

        public async void RespondToFriendRequest(string targetUsername, string requesterUsername, bool accepted)
        {
            try
            {
                await Logic.RespondToFriendRequestAsync(targetUsername, requesterUsername, accepted);
                NotifyIfConnected(requesterUsername, cb => cb.NotifyFriendResponse(targetUsername, accepted));
                if (accepted) await NotifyNewFriendshipStatus(targetUsername, requesterUsername);
            }
            catch (Exception ex) { _log.Error($"Error responding request", ex); }
        }

        public async Task<OperationResultDto> RemoveFriendAsync(string username, string friendToRemove)
        {
            try
            {
                var result = await Logic.RemoveFriendAsync(username, friendToRemove);

                if (result.Success)
                {
                    NotifyIfConnected(friendToRemove, cb => cb.NotifyFriendRemoved(username));
                }
                return result;
            }
            catch (Exception ex)
            {
                _log.Error($"Error removing friend", ex);
                throw new FaultException<ServiceFaultDto>(new ServiceFaultDto(ServiceErrorType.OperationFailed, "Error del servidor."), new FaultReason(ex.Message));
            }
        }

        public async Task<DirectMessageDto> SendDirectMessageAsync(DirectMessageDto message)
        {
            try
            {
                // 1. CAPTURAR: Obtenemos el mensaje procesado (ya censurado) de la lógica
                var processedMessage = await Logic.SendDirectMessageAsync(message);

                // 2. NOTIFICAR: Usamos 'processedMessage' para que al receptor le lleguen los asteriscos
                NotifyIfConnected(message.RecipientUsername, cb => cb.NotifyMessageReceived(processedMessage));

                // 3. RETORNAR: Devolvemos el mensaje procesado para que el sender también vea los asteriscos
                return processedMessage;
            }
            catch (Exception ex)
            {
                _log.Error($"Error sending DM", ex);
                throw;
            }
        }

        public async Task<List<FriendDto>> GetConversationsAsync(string username) => await Logic.GetConversationsAsync(username);
        public async Task<List<DirectMessageDto>> GetConversationHistoryAsync(string user1, string user2) => await Logic.GetConversationHistoryAsync(user1, user2);

        public async Task<FriendProfileDto> GetFriendProfileAsync(string username)
        {
            try
            {
                return await Logic.GetFriendProfileAsync(username);
            }
            catch (Exception ex)
            {
                _log.Error($"Error getting profile for {username}", ex);
                throw new FaultException<ServiceFaultDto>(new ServiceFaultDto(ServiceErrorType.OperationFailed, "Error al obtener el perfil."), new FaultReason(ex.Message));
            }
        }

        public Task<OperationResultDto> InviteFriendToGameByEmailAsync(string fromUsername, string friendEmail, string matchCode)
        {
            var fault = new ServiceFaultDto(ServiceErrorType.OperationFailed, "Not implemented yet.");
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason("Not Implemented"));
        }

        private async Task NotifyFriendStatusUpdate(string username, string status)
        {
            var friends = await Logic.GetFriendsListAsync(username);
            foreach (var friend in friends) NotifyIfConnected(friend.Username, cb => cb.NotifyFriendStatusChanged(username, status));
        }

        private async Task NotifyNewFriendshipStatus(string u1, string u2)
        {
            bool u2Online = false, u1Online = false;
            lock (_clientLock) { u2Online = ConnectedClients.ContainsKey(u2); u1Online = ConnectedClients.ContainsKey(u1); }
            NotifyIfConnected(u1, cb => cb.NotifyFriendStatusChanged(u2, u2Online ? "Online" : "Offline"));
            NotifyIfConnected(u2, cb => cb.NotifyFriendStatusChanged(u1, u1Online ? "Online" : "Offline"));
            await Task.CompletedTask;
        }

        private void NotifyIfConnected(string target, Action<ISocialServiceCallback> action)
        {
            ISocialServiceCallback cb = null;
            lock (_clientLock) { ConnectedClients.TryGetValue(target, out cb); }
            if (cb != null)
            {
                try { action(cb); }
                catch { lock (_clientLock) { ConnectedClients.Remove(target); } }
            }
        }
    }
}