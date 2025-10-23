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
                friendUsernames = friends.Select(f => f.username).ToList();
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
                        try
                        {
                            Console.WriteLine($"Notificando a {friendUsername} sobre {username} ({status})..."); 
                            callback?.NotifyFriendStatusChanged(username, status);
                            Console.WriteLine($"Notificación enviada a {friendUsername}."); 
                        }
                        catch (ObjectDisposedException odEx)
                        {
                            Console.WriteLine($"Error al notificar a {friendUsername} (ObjectDisposed): {odEx.Message}. Marcado para remover.");
                            clientsToRemove.Add(friendUsername); 
                        }
                        catch (CommunicationObjectAbortedException coaEx)
                        {
                            Console.WriteLine($"Error al notificar a {friendUsername} (Aborted): {coaEx.Message}. Marcado para remover.");
                            clientsToRemove.Add(friendUsername);
                        }
                        catch (CommunicationObjectFaultedException cofEx)
                        {
                            Console.WriteLine($"Error al notificar a {friendUsername} (Faulted): {cofEx.Message}. Marcado para remover.");
                            clientsToRemove.Add(friendUsername);
                        }
                        catch (TimeoutException tEx)
                        {
                            Console.WriteLine($"Timeout al notificar a {friendUsername}: {tEx.Message}. Marcado para remover.");
                            clientsToRemove.Add(friendUsername);
                        }
                        catch (Exception ex) 
                        {
                            Console.WriteLine($"Error GENÉRICO al notificar a {friendUsername}: {ex.GetType().Name} - {ex.Message}. Marcado para remover.");
                            clientsToRemove.Add(friendUsername);
                        }
                    }
                    else
                    {
                        Console.WriteLine($"{friendUsername} es amigo de {username} pero no está en connectedClients."); 
                    }
                }

                foreach (var clientToRemove in clientsToRemove)
                {
                    if (connectedClients.ContainsKey(clientToRemove))
                    {
                        Console.WriteLine($"Removiendo cliente fallido: {clientToRemove}");
                        connectedClients.Remove(clientToRemove);
                    }
                }
            } 
        }

        public void Connect(string username)
        {
            if (string.IsNullOrEmpty(username)) return;

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
            if (string.IsNullOrEmpty(username)) return;

            lock (connectedClients)
            {
                if (connectedClients.ContainsKey(username))
                {
                    connectedClients.Remove(username);
                }
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
                throw new FaultException(ex.Message);
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
                throw new FaultException(ex.Message);
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
                throw new FaultException(ex.Message);
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

                ISocialServiceCallback callback;
                lock (connectedClients)
                {
                    connectedClients.TryGetValue(requesterUsername, out callback);
                }
                callback?.NotifyFriendResponse(targetUsername, accepted);

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

                    callback?.NotifyFriendStatusChanged(targetUsername, targetIsOnline ? "Online" : "Offline");

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
            try
            {
                await _socialLogic.SendDirectMessageAsync(message);

                ISocialServiceCallback callback;
                lock (connectedClients)
                {
                    connectedClients.TryGetValue(message.recipientUsername, out callback);
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
                throw new FaultException(ex.Message);
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
                throw new FaultException(ex.Message);
            }
        }

        public Task<OperationResultDto> InviteFriendToGameByEmailAsync(string fromUsername, string friendEmail, string matchCode)
        {
            throw new NotImplementedException();
        }
    }
}