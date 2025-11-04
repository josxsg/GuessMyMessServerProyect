using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities.Email;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class SocialService : ISocialService
    {
        private readonly SocialLogic _socialLogic;
        private static readonly Dictionary<string, ISocialServiceCallback> connectedClients = new Dictionary<string, ISocialServiceCallback>();

        public SocialService()
        {
            _socialLogic = new SocialLogic(new SmtpEmailService());
        }

        private async Task NotifyFriendStatusUpdate(string username, string status)
        {
            List<string> friendUsernames;
            try
            {
                var friends = await _socialLogic.GetFriendsListAsync(username);
                friendUsernames = friends.Select(f => f.Username).ToList();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al obtener lista de amigos para notificación de estado: {ex.Message}");
                return;
            }

            List<string> clientsToRemove = new List<string>();

            lock (connectedClients)
            {
                foreach (var friendUsername in friendUsernames)
                {
                    if (connectedClients.TryGetValue(friendUsername, out var callback))
                    {
                        bool success = SendNotificationToClient(callback, friendUsername, username, status);

                        if (!success)
                        {
                            clientsToRemove.Add(friendUsername);
                        }
                    }
                    else
                    {
                        Console.WriteLine($"{friendUsername} es amigo de {username} pero no está en connectedClients.");
                    }
                }

                foreach (var clientToRemove in clientsToRemove.Where(connectedClients.ContainsKey))
                {
                    Console.WriteLine($"Removiendo cliente fallido: {clientToRemove}");
                    connectedClients.Remove(clientToRemove);
                }
            }
        }

        private bool SendNotificationToClient(ISocialServiceCallback callback, string friendUsername, string targetUsername, string status)
        {
            try
            {
                Console.WriteLine($"Notificando a {friendUsername} sobre {targetUsername} ({status})...");
                callback?.NotifyFriendStatusChanged(targetUsername, status);
                Console.WriteLine($"Notificación enviada a {friendUsername}.");
                return true;
            }
            catch (ObjectDisposedException odEx)
            {
                Console.WriteLine($"Error al notificar a {friendUsername} (ObjectDisposed): {odEx.Message}. Marcado para remover.");
            }
            catch (CommunicationObjectAbortedException coaEx)
            {
                Console.WriteLine($"Error al notificar a {friendUsername} (Aborted): {coaEx.Message}. Marcado para remover.");
            }
            catch (CommunicationObjectFaultedException cofEx)
            {
                Console.WriteLine($"Error al notificar a {friendUsername} (Faulted): {cofEx.Message}. Marcado para remover.");
            }
            catch (TimeoutException tEx)
            {
                Console.WriteLine($"Timeout al notificar a {friendUsername}: {tEx.Message}. Marcado para remover.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error GENÉRICO al notificar a {friendUsername}: {ex.GetType().Name} - {ex.Message}. Marcado para remover.");
            }
            return false;
        }
        public void Connect(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                return;
            }

            var callback = OperationContext.Current.GetCallbackChannel<ISocialServiceCallback>();
            lock (connectedClients)
            {
                if (!connectedClients.ContainsKey(username))
                {
                    connectedClients.Add(username, callback);
                }
                else
                {
                    connectedClients[username] = callback;
                }
            }

            Task.Run(async () =>
            {
                try
                {
                    await _socialLogic.UpdatePlayerStatusAsync(username, "Online");
                    await NotifyFriendStatusUpdate(username, "Online");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error al actualizar estado en Connect: {ex.Message}");
                }
            });
        }

        public void Disconnect(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                return;
            }

            lock (connectedClients)
            {
                connectedClients.Remove(username);
            }

            Task.Run(async () =>
            {
                try
                {
                    await _socialLogic.UpdatePlayerStatusAsync(username, "Offline");
                    await NotifyFriendStatusUpdate(username, "Offline");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error al actualizar estado en Disconnect: {ex.Message}");
                }
            });
        }

        public async Task<List<FriendDto>> GetFriendsListAsync(string username)
        {
            try
            {
                return await _socialLogic.GetFriendsListAsync(username);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al obtener lista de amigos: {ex.Message}");
            }
        }

        public async Task<List<FriendRequestInfoDto>> GetFriendRequestsAsync(string username)
        {
            try
            {
                return await _socialLogic.GetFriendRequestsAsync(username);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al obtener solicitudes de amistad: {ex.Message}");
            }
        }

        public async Task<List<UserProfileDto>> SearchUsersAsync(string searchUsername, string requesterUsername)
        {
            try
            {
                return await _socialLogic.SearchUsersAsync(searchUsername, requesterUsername);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al buscar usuarios: {ex.Message}");
            }
        }

        public async void SendFriendRequest(string requesterUsername, string targetUsername)
        {
            try
            {
                await _socialLogic.SendFriendRequestAsync(requesterUsername, targetUsername);

                ISocialServiceCallback callback;
                lock (connectedClients)
                {
                    connectedClients.TryGetValue(targetUsername, out callback);
                }
                callback?.NotifyFriendRequest(requesterUsername);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en SendFriendRequest: {ex.Message}");
            }
        }

        public async void RespondToFriendRequest(string targetUsername, string requesterUsername, bool accepted)
        {
            try
            {
                await _socialLogic.RespondToFriendRequestAsync(targetUsername, requesterUsername, accepted);

                ISocialServiceCallback requesterCallback;
                lock (connectedClients)
                {
                    connectedClients.TryGetValue(requesterUsername, out requesterCallback);
                }
                requesterCallback?.NotifyFriendResponse(targetUsername, accepted);

                if (accepted)
                {
                    bool requesterIsOnline;
                    bool targetIsOnline;
                    ISocialServiceCallback targetCallback;

                    lock (connectedClients)
                    {
                        requesterIsOnline = connectedClients.ContainsKey(requesterUsername);
                        targetIsOnline = connectedClients.TryGetValue(targetUsername, out targetCallback);
                    }

                    requesterCallback?.NotifyFriendStatusChanged(targetUsername, targetIsOnline ? "Online" : "Offline");
                    targetCallback?.NotifyFriendStatusChanged(requesterUsername, requesterIsOnline ? "Online" : "Offline");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en RespondToFriendRequest: {ex.Message}");
            }
        }

        public async void RemoveFriend(string username, string friendToRemove)
        {
            try
            {
                await _socialLogic.RemoveFriendAsync(username, friendToRemove);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en RemoveFriend: {ex.Message}");
            }
        }

        public async void SendDirectMessage(DirectMessageDto message)
        {
            if (message == null || string.IsNullOrEmpty(message.RecipientUsername))
            {
                Console.WriteLine("Error: Mensaje directo inválido.");
                return;
            }

            try
            {
                await _socialLogic.SendDirectMessageAsync(message);

                ISocialServiceCallback callback;
                lock (connectedClients)
                {
                    connectedClients.TryGetValue(message.RecipientUsername, out callback);
                }
                callback?.NotifyMessageReceived(message);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en SendDirectMessage: {ex.Message}");
            }
        }

        public async Task<List<FriendDto>> GetConversationsAsync(string username)
        {
            try
            {
                return await _socialLogic.GetConversationsAsync(username);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al obtener conversaciones: {ex.Message}");
            }
        }

        public async Task<List<DirectMessageDto>> GetConversationHistoryAsync(string user1, string user2)
        {
            try
            {
                return await _socialLogic.GetConversationHistoryAsync(user1, user2);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al obtener historial de conversación: {ex.Message}");
            }
        }

        public Task<OperationResultDto> InviteFriendToGameByEmailAsync(string fromUsername, string friendEmail, string matchCode)
        {
            Console.WriteLine("Advertencia: InviteFriendToGameByEmailAsync no está implementado.");
            throw new NotImplementedException("La función de invitar por correo electrónico aún no está implementada.");
        }
    }
}