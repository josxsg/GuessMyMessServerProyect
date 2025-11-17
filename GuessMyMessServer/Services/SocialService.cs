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
                Console.WriteLine($"Error retrieving friends list for status notification: {ex.Message}");
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
                        Console.WriteLine($"{friendUsername} is a friend of {username} but is not in connectedClients.");
                    }
                }

                foreach (var clientToRemove in clientsToRemove.Where(connectedClients.ContainsKey))
                {
                    Console.WriteLine($"Removing failed client: {clientToRemove}");
                    connectedClients.Remove(clientToRemove);
                }
            }
        }

        private bool SendNotificationToClient(ISocialServiceCallback callback, string friendUsername, string targetUsername, string status)
        {
            try
            {
                Console.WriteLine($"Notifying {friendUsername} about {targetUsername} ({status})...");
                callback?.NotifyFriendStatusChanged(targetUsername, status);
                Console.WriteLine($"Notification sent to {friendUsername}.");
                return true;
            }
            catch (ObjectDisposedException odEx)
            {
                Console.WriteLine($"Error notifying {friendUsername} (ObjectDisposed): {odEx.Message}. Marked for removal.");
            }
            catch (CommunicationObjectAbortedException coaEx)
            {
                Console.WriteLine($"Error notifying {friendUsername} (Aborted): {coaEx.Message}. Marked for removal.");
            }
            catch (CommunicationObjectFaultedException cofEx)
            {
                Console.WriteLine($"Error notifying {friendUsername} (Faulted): {cofEx.Message}. Marked for removal.");
            }
            catch (TimeoutException tEx)
            {
                Console.WriteLine($"Timeout notifying {friendUsername}: {tEx.Message}. Marked for removal.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"GENERIC error notifying {friendUsername}: {ex.GetType().Name} - {ex.Message}. Marked for removal.");
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
                    Console.WriteLine($"Error updating status in Connect: {ex.Message}");
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
                    Console.WriteLine($"Error updating status in Disconnect: {ex.Message}");
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
                throw new FaultException($"Error retrieving friends list: {ex.Message}");
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
                throw new FaultException($"Error retrieving friend requests: {ex.Message}");
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
                throw new FaultException($"Error searching users: {ex.Message}");
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
                Console.WriteLine($"Error in SendFriendRequest: {ex.Message}");
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
                Console.WriteLine($"Error in RespondToFriendRequest: {ex.Message}");
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
                Console.WriteLine($"Error in RemoveFriend: {ex.Message}");
            }
        }

        public async void SendDirectMessage(DirectMessageDto message)
        {
            if (message == null || string.IsNullOrEmpty(message.RecipientUsername))
            {
                Console.WriteLine("Error: Invalid direct message.");
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
                Console.WriteLine($"Error in SendDirectMessage: {ex.Message}");
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
                throw new FaultException($"Error retrieving conversations: {ex.Message}");
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
                throw new FaultException($"Error retrieving conversation history: {ex.Message}");
            }
        }

        public Task<OperationResultDto> InviteFriendToGameByEmailAsync(string fromUsername, string friendEmail, string matchCode)
        {
            Console.WriteLine("Warning: InviteFriendToGameByEmailAsync is not implemented.");
            throw new NotImplementedException("The email invitation feature has not been implemented yet.");
        }
    }
}
