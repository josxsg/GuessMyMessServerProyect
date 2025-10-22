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
            // Puedes inyectar dependencias aquí si es necesario
            _socialLogic = new SocialLogic(new SmtpEmailService());
        }

        public void Connect(string username)
        {
            var callback = OperationContext.Current.GetCallbackChannel<ISocialServiceCallback>();
            lock (connectedClients)
            {
                if (!connectedClients.ContainsKey(username))
                {
                    connectedClients.Add(username, callback);
                }
                else
                {
                    connectedClients[username] = callback; // Actualizar canal por si se reconecta
                }
            }
        }

        public void Disconnect(string username)
        {
            lock (connectedClients)
            {
                if (connectedClients.ContainsKey(username))
                {
                    connectedClients.Remove(username);
                }
            }
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