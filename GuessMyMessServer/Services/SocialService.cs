using System;
using System.Collections.Generic;
using System.Data.Entity.Core;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Properties;
using GuessMyMessServer.Properties.Langs;
using GuessMyMessServer.Utilities.Email;
using log4net;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class SocialService : ISocialService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(SocialService));
        private readonly SocialLogic _socialLogic;

        private static readonly Dictionary<string, ISocialServiceCallback> connectedClients = new Dictionary<string, ISocialServiceCallback>();
        private static readonly object _clientLock = new object();

        public SocialService()
        {
            _socialLogic = new SocialLogic(new SmtpEmailService());
        }

        public void Connect(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                return;
            }

            try
            {
                var callback = OperationContext.Current.GetCallbackChannel<ISocialServiceCallback>();

                lock (_clientLock)
                {
                    if (connectedClients.ContainsKey(username))
                    {
                        connectedClients[username] = callback;
                    }
                    else
                    {
                        connectedClients.Add(username, callback);
                    }
                }

                _log.Info($"SocialService: User '{username}' connected.");

                Task.Run(async () =>
                {
                    try
                    {
                        await _socialLogic.UpdatePlayerStatusAsync(username, "Online");
                        await NotifyFriendStatusUpdate(username, "Online");
                    }
                    catch (Exception ex)
                    {
                        _log.Error($"Error updating online status for '{username}'", ex);
                    }
                });
            }
            catch (Exception ex)
            {
                _log.Error($"Error connecting user '{username}' to SocialService", ex);
            }
        }

        public void Disconnect(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                return;
            }

            try
            {
                lock (_clientLock)
                {
                    connectedClients.Remove(username);
                }

                _log.Info($"SocialService: User '{username}' disconnected.");

                Task.Run(async () =>
                {
                    try
                    {
                        await _socialLogic.UpdatePlayerStatusAsync(username, "Offline");
                        await NotifyFriendStatusUpdate(username, "Offline");
                    }
                    catch (Exception ex)
                    {
                        _log.Error($"Error updating offline status for '{username}'", ex);
                    }
                });
            }
            catch (Exception ex)
            {
                _log.Warn($"Error during disconnect for '{username}'", ex);
            }
        }

        public async Task<List<FriendDto>> GetFriendsListAsync(string username)
        {
            try
            {
                return await _socialLogic.GetFriendsListAsync(username);
            }
            catch (EntityException ex)
            {
                _log.Error($"Database error retrieving friends for '{username}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.DatabaseError, Lang.Error_DatabaseConnectionError),
                    new FaultReason("Database Unavailable"));
            }
            catch (Exception ex)
            {
                _log.Error($"Error getting friends list for '{username}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_FriendListFailed),
                    new FaultReason("Server Error"));
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
                _log.Error($"Error retrieving friend requests for '{username}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_FriendRequestsFailed),
                    new FaultReason("Server Error"));
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
                _log.Error($"Error searching users for '{requesterUsername}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_UserSearchFailed),
                    new FaultReason("Search Failed"));
            }
        }

        public async void SendFriendRequest(string requesterUsername, string targetUsername)
        {
            try
            {
                await _socialLogic.SendFriendRequestAsync(requesterUsername, targetUsername);

                ISocialServiceCallback callback = null;
                lock (_clientLock)
                {
                    connectedClients.TryGetValue(targetUsername, out callback);
                }

                if (callback != null)
                {
                    NotifyCallbackSafe(callback, c => c.NotifyFriendRequest(requesterUsername), targetUsername);
                }
            }
            catch (InvalidOperationException ex)
            {
                _log.Info($"Friend request failed (Logic): {ex.Message}");
            }
            catch (Exception ex)
            {
                _log.Error($"Error sending friend request from '{requesterUsername}' to '{targetUsername}'", ex);
            }
        }

        public async void RespondToFriendRequest(string targetUsername, string requesterUsername, bool accepted)
        {
            try
            {
                await _socialLogic.RespondToFriendRequestAsync(targetUsername, requesterUsername, accepted);

                ISocialServiceCallback requesterCallback = null;
                lock (_clientLock)
                {
                    connectedClients.TryGetValue(requesterUsername, out requesterCallback);
                }

                if (requesterCallback != null)
                {
                    NotifyCallbackSafe(requesterCallback, c => c.NotifyFriendResponse(targetUsername, accepted), requesterUsername);
                }

                if (accepted)
                {
                    await NotifyNewFriendshipStatus(targetUsername, requesterUsername);
                }
            }
            catch (Exception ex)
            {
                _log.Error($"Error responding to friend request ({targetUsername} -> {requesterUsername})", ex);
            }
        }

        public async void RemoveFriend(string username, string friendToRemove)
        {
            try
            {
                await _socialLogic.RemoveFriendAsync(username, friendToRemove);
                _log.Info($"Friendship removed: {username} and {friendToRemove}");
            }
            catch (Exception ex)
            {
                _log.Error($"Error removing friend '{friendToRemove}' for user '{username}'", ex);
            }
        }

        public async void SendDirectMessage(DirectMessageDto message)
        {
            if (message == null || string.IsNullOrEmpty(message.RecipientUsername))
            {
                _log.Warn("SendDirectMessage: Invalid message received.");
                return;
            }

            try
            {
                await _socialLogic.SendDirectMessageAsync(message);

                ISocialServiceCallback callback = null;
                lock (_clientLock)
                {
                    connectedClients.TryGetValue(message.RecipientUsername, out callback);
                }

                if (callback != null)
                {
                    NotifyCallbackSafe(callback, c => c.NotifyMessageReceived(message), message.RecipientUsername);
                }
            }
            catch (Exception ex)
            {
                _log.Error($"Error sending DM from '{message.SenderUsername}' to '{message.RecipientUsername}'", ex);
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
                _log.Error($"Error getting conversations for '{username}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_ConversationsFailed),
                    new FaultReason("Server Error"));
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
                _log.Error($"Error getting chat history ({user1}-{user2})", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_MessageHistoryFailed),
                    new FaultReason("Server Error"));
            }
        }

        public Task<OperationResultDto> InviteFriendToGameByEmailAsync(string fromUsername, string friendEmail, string matchCode)
        {
            var fault = new ServiceFaultDto(ServiceErrorType.OperationFailed, "Invitation by email not implemented yet.");
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason("Not Implemented"));
        }

        private async Task NotifyFriendStatusUpdate(string username, string status)
        {
            try
            {
                var friends = await _socialLogic.GetFriendsListAsync(username);
                var friendUsernames = friends.Select(f => f.Username).ToList();

                foreach (var friend in friendUsernames)
                {
                    ISocialServiceCallback callback = null;
                    lock (_clientLock)
                    {
                        connectedClients.TryGetValue(friend, out callback);
                    }

                    if (callback != null)
                    {
                        NotifyCallbackSafe(callback, c => c.NotifyFriendStatusChanged(username, status), friend);
                    }
                }
            }
            catch (Exception ex)
            {
                _log.Error($"Error broadcasting status update for '{username}'", ex);
            }
        }

        private async Task NotifyNewFriendshipStatus(string user1, string user2)
        {
            bool user2Online = false;
            ISocialServiceCallback cb1 = null;
            lock (_clientLock)
            {
                user2Online = connectedClients.ContainsKey(user2);
                connectedClients.TryGetValue(user1, out cb1);
            }

            if (cb1 != null)
            {
                NotifyCallbackSafe(cb1, c => c.NotifyFriendStatusChanged(user2, user2Online ? "Online" : "Offline"), user1);
            }

            bool user1Online = false;
            ISocialServiceCallback cb2 = null;
            lock (_clientLock)
            {
                user1Online = connectedClients.ContainsKey(user1);
                connectedClients.TryGetValue(user2, out cb2);
            }

            if (cb2 != null)
            {
                NotifyCallbackSafe(cb2, c => c.NotifyFriendStatusChanged(user1, user1Online ? "Online" : "Offline"), user2);
            }

            await Task.CompletedTask;
        }

        private void NotifyCallbackSafe(ISocialServiceCallback callback, Action<ISocialServiceCallback> action, string targetUsername)
        {
            try
            {
                action(callback);
            }
            catch (CommunicationException comEx)
            {
                _log.Warn($"Failed to notify user '{targetUsername}' (Communication Error). Removing from active clients.", comEx);
                lock (_clientLock)
                {
                    if (connectedClients.ContainsKey(targetUsername))
                    {
                        connectedClients.Remove(targetUsername);
                    }
                }
            }
            catch (TimeoutException timeEx)
            {
                _log.Warn($"Timeout notifying user '{targetUsername}'.", timeEx);
            }
            catch (Exception ex)
            {
                _log.Error($"Unexpected error notifying user '{targetUsername}'", ex);
            }
        }
    }
}
