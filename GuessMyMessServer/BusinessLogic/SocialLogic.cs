using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core; 
using System.Data.Entity.Infrastructure; 
using System.Linq;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities.Email;
using log4net;

namespace GuessMyMessServer.BusinessLogic
{
    public class SocialLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(SocialLogic));
        private readonly IEmailService _emailService;

        public SocialLogic(IEmailService emailService)
        {
            _emailService = emailService;
        }

        public async Task<List<FriendDto>> GetFriendsListAsync(string username)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                    if (player == null)
                    {
                        _log.Warn($"GetFriendsList failed: User '{username}' not found.");
                        throw new InvalidOperationException("User not found.");
                    }

                    const string AcceptedStatus = "Accepted";
                    const string OnlineStatus = "Online";

                    var friendships = await context.Friendship
                        .Where(f => (f.Player_idPlayer1 == player.idPlayer || f.Player_idPlayer2 == player.idPlayer)
                                     && f.FriendShipStatus.status == AcceptedStatus)
                        .Select(f => f.Player_idPlayer1 == player.idPlayer ? f.Player1 : f.Player)
                        .Select(p => new
                        {
                            p.username,
                            Status = p.UserStatus.status
                        })
                        .ToListAsync();

                    return friendships.Select(f => new FriendDto
                    {
                        Username = f.username,
                        IsOnline = f.Status == OnlineStatus
                    }).ToList();
                }
            }
            catch (EntityException ex)
            {
                _log.Error($"Database connection error retrieving friends list for '{username}'.", ex);
                throw;
            }
        }

        public async Task<List<FriendRequestInfoDto>> GetFriendRequestsAsync(string username)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                    if (player == null)
                    {
                        _log.Warn($"GetFriendRequests failed: User '{username}' not found.");
                        return new List<FriendRequestInfoDto>();
                    }

                    const string PendingStatus = "Pending";

                    return await context.Friendship
                        .Where(f => f.Player_idPlayer2 == player.idPlayer && f.FriendShipStatus.status == PendingStatus)
                        .Select(f => new FriendRequestInfoDto
                        {
                            RequesterUsername = f.Player.username
                        }).ToListAsync();
                }
            }
            catch (EntityException ex)
            {
                _log.Error($"Database error retrieving friend requests for '{username}'.", ex);
                throw;
            }
        }

        public async Task<List<UserProfileDto>> SearchUsersAsync(string searchUsername, string requesterUsername)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var requester = await context.Player.FirstOrDefaultAsync(p => p.username == requesterUsername);
                    if (requester == null)
                    {
                        _log.Warn($"SearchUsers failed: Requester '{requesterUsername}' not found.");
                        throw new InvalidOperationException("User not found.");
                    }

                    var requesterId = requester.idPlayer;

                    var existingRelationshipsPlayerIds = await context.Friendship
                        .Where(f => f.Player_idPlayer1 == requesterId || f.Player_idPlayer2 == requesterId)
                        .Select(f => f.Player_idPlayer1 == requesterId ? f.Player_idPlayer2 : f.Player_idPlayer1)
                        .Distinct()
                        .ToListAsync();

                    existingRelationshipsPlayerIds.Add(requesterId);

                    return await context.Player
                        .Where(p => p.username.Contains(searchUsername) &&
                                    !existingRelationshipsPlayerIds.Contains(p.idPlayer))
                        .Select(p => new UserProfileDto
                        {
                            Username = p.username
                        }).ToListAsync();
                }
            }
            catch (EntityException ex)
            {
                _log.Error($"Database error searching users for '{requesterUsername}' with query '{searchUsername}'.", ex);
                throw;
            }
        }

        public async Task SendFriendRequestAsync(string requesterUsername, string targetUsername)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var requester = await context.Player.FirstOrDefaultAsync(p => p.username == requesterUsername);
                var target = await context.Player.FirstOrDefaultAsync(p => p.username == targetUsername);

                if (requester == null || target == null)
                {
                    _log.Warn($"SendFriendRequest failed: One or both users not found ({requesterUsername} -> {targetUsername}).");
                    throw new InvalidOperationException("Requester or target user is invalid.");
                }

                if (requester.idPlayer == target.idPlayer)
                {
                    throw new ArgumentException("You cannot send a friend request to yourself.");
                }

                var existing = await context.Friendship.FirstOrDefaultAsync(f =>
                    (f.Player_idPlayer1 == requester.idPlayer && f.Player_idPlayer2 == target.idPlayer) ||
                    (f.Player_idPlayer1 == target.idPlayer && f.Player_idPlayer2 == requester.idPlayer));

                if (existing != null)
                {
                    _log.Info($"Friend request redundant: Relationship already exists between '{requesterUsername}' and '{targetUsername}'.");
                    throw new InvalidOperationException("A relationship or pending request already exists between these users.");
                }

                const string PendingStatus = "Pending";
                var pendingStatusEntity = await context.FriendShipStatus.FirstOrDefaultAsync(fs => fs.status == PendingStatus);
                if (pendingStatusEntity == null)
                {
                    _log.Error("Critical: 'Pending' status missing in database configuration.");
                    throw new InvalidOperationException("Internal error: 'Pending' friendship status is not configured.");
                }

                var friendship = new Friendship
                {
                    Player_idPlayer1 = requester.idPlayer,
                    Player_idPlayer2 = target.idPlayer,
                    FriendShipStatus_idFriendShipStatus = pendingStatusEntity.idFriendShipStatus
                };
                context.Friendship.Add(friendship);

                try
                {
                    await context.SaveChangesAsync();
                    _log.Info($"Friend request sent from '{requesterUsername}' to '{targetUsername}'.");
                }
                catch (DbUpdateException dbEx)
                {
                    _log.Error($"Database error saving friend request from '{requesterUsername}' to '{targetUsername}'.", dbEx);
                    throw new InvalidOperationException("Could not send friend request due to a database error.", dbEx);
                }
            }
        }

        public async Task RespondToFriendRequestAsync(string targetUsername, string requesterUsername, bool accepted)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var target = await context.Player.FirstOrDefaultAsync(p => p.username == targetUsername);
                var requester = await context.Player.FirstOrDefaultAsync(p => p.username == requesterUsername);

                if (target == null || requester == null)
                {
                    _log.Warn($"RespondToFriendRequest failed: Users not found.");
                    return;
                }

                const string PendingStatus = "Pending";
                var friendship = await context.Friendship
                    .Include(f => f.FriendShipStatus)
                    .FirstOrDefaultAsync(f => f.Player_idPlayer1 == requester.idPlayer &&
                                              f.Player_idPlayer2 == target.idPlayer &&
                                              f.FriendShipStatus.status == PendingStatus);

                if (friendship == null)
                {
                    _log.Warn($"RespondToFriendRequest: No pending request found from '{requesterUsername}' to '{targetUsername}'.");
                    throw new InvalidOperationException("A valid pending friend request was not found.");
                }

                if (accepted)
                {
                    const string AcceptedStatus = "Accepted";
                    var acceptedStatusEntity = await context.FriendShipStatus.FirstOrDefaultAsync(fs => fs.status == AcceptedStatus);
                    if (acceptedStatusEntity == null)
                    {
                        _log.Error("Critical: 'Accepted' status missing in database configuration.");
                        throw new InvalidOperationException("Internal error: 'Accepted' friendship status is not configured.");
                    }
                    friendship.FriendShipStatus_idFriendShipStatus = acceptedStatusEntity.idFriendShipStatus;
                    _log.Info($"Friend request accepted by '{targetUsername}'. New friendship established.");
                }
                else
                {
                    context.Friendship.Remove(friendship);
                    _log.Info($"Friend request rejected by '{targetUsername}'. Request removed.");
                }

                try
                {
                    await context.SaveChangesAsync();
                }
                catch (DbUpdateException dbEx)
                {
                    _log.Error($"Database error updating friend request response for '{targetUsername}'.", dbEx);
                    throw new InvalidOperationException("Could not process friend response due to a database error.", dbEx);
                }
            }
        }

        public async Task RemoveFriendAsync(string username, string friendToRemove)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                var friend = await context.Player.FirstOrDefaultAsync(p => p.username == friendToRemove);

                if (player == null || friend == null)
                {
                    _log.Warn($"RemoveFriend failed: User or friend not found.");
                    return;
                }

                var friendship = await context.Friendship.FirstOrDefaultAsync(f =>
                    (f.Player_idPlayer1 == player.idPlayer && f.Player_idPlayer2 == friend.idPlayer) ||
                    (f.Player_idPlayer1 == friend.idPlayer && f.Player_idPlayer2 == player.idPlayer));

                if (friendship != null)
                {
                    context.Friendship.Remove(friendship);
                    try
                    {
                        await context.SaveChangesAsync();
                        _log.Info($"Friendship removed between '{username}' and '{friendToRemove}'.");
                    }
                    catch (DbUpdateException dbEx)
                    {
                        _log.Error($"Database error removing friendship between '{username}' and '{friendToRemove}'.", dbEx);
                        throw;
                    }
                }
                else
                {
                    _log.Info($"RemoveFriend: No friendship found to remove between '{username}' and '{friendToRemove}'.");
                }
            }
        }

        public async Task UpdatePlayerStatusAsync(string username, string status)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null)
                {
                    _log.Warn($"UpdatePlayerStatus failed: User '{username}' not found.");
                    throw new InvalidOperationException($"User '{username}' not found to update status.");
                }

                var userStatus = await context.UserStatus.FirstOrDefaultAsync(s => s.status == status);
                if (userStatus == null)
                {
                    _log.Error($"UpdatePlayerStatus failed: Invalid status '{status}' requested.");
                    throw new InvalidOperationException($"User status '{status}' is not valid.");
                }

                if (player.UserStatus_idUserStatus != userStatus.idUserStatus)
                {
                    player.UserStatus_idUserStatus = userStatus.idUserStatus;
                    try
                    {
                        await context.SaveChangesAsync();
                        _log.Debug($"User '{username}' status updated to '{status}'.");
                    }
                    catch (DbUpdateException dbEx)
                    {
                        _log.Error($"Database error updating status for user '{username}'.", dbEx);
                        throw;
                    }
                }
            }
        }

        public async Task SendDirectMessageAsync(DirectMessageDto message)
        {
            if (message == null || string.IsNullOrWhiteSpace(message.SenderUsername) ||
                string.IsNullOrWhiteSpace(message.RecipientUsername) || string.IsNullOrWhiteSpace(message.Content))
            {
                _log.Warn("SendDirectMessage failed: Invalid message data.");
                throw new ArgumentException("The direct message contains invalid data.");
            }

            using (var dbContext = new GuessMyMessDBEntities())
            {
                var sender = await dbContext.Player.FirstOrDefaultAsync(p => p.username == message.SenderUsername);
                var recipient = await dbContext.Player.FirstOrDefaultAsync(p => p.username == message.RecipientUsername);

                if (sender == null || recipient == null)
                {
                    _log.Warn($"SendDirectMessage failed: Sender or recipient not found.");
                    throw new InvalidOperationException("The sender or recipient of the message does not exist.");
                }

                var dbMessage = new DirectMessages
                {
                    SenderPlayerID = sender.idPlayer,
                    RecipientPlayerID = recipient.idPlayer,
                    MessageContent = message.Content,
                    Timestamp = DateTime.UtcNow
                };

                dbContext.DirectMessages.Add(dbMessage);

                try
                {
                    await dbContext.SaveChangesAsync();
                    message.Timestamp = dbMessage.Timestamp;
                }
                catch (DbUpdateException dbEx)
                {
                    _log.Error($"Database error saving direct message from '{message.SenderUsername}'.", dbEx);
                    throw new InvalidOperationException("Failed to send message due to a storage error.", dbEx);
                }
            }
        }

        public async Task<List<FriendDto>> GetConversationsAsync(string username)
        {
            try
            {
                using (var dbContext = new GuessMyMessDBEntities())
                {
                    var user = await dbContext.Player.FirstOrDefaultAsync(p => p.username == username);
                    if (user == null)
                    {
                        _log.Warn($"GetConversations failed: User '{username}' not found.");
                        return new List<FriendDto>();
                    }

                    var userId = user.idPlayer;

                    var counterpartIds = await dbContext.DirectMessages
                        .Where(m => m.SenderPlayerID == userId || m.RecipientPlayerID == userId)
                        .Select(m => m.SenderPlayerID == userId ? m.RecipientPlayerID : m.SenderPlayerID)
                        .Distinct()
                        .ToListAsync();

                    const string OnlineStatus = "Online";

                    return await dbContext.Player
                        .Where(p => counterpartIds.Contains(p.idPlayer))
                        .Select(p => new FriendDto
                        {
                            Username = p.username,
                            IsOnline = p.UserStatus.status == OnlineStatus
                        })
                        .ToListAsync();
                }
            }
            catch (EntityException ex)
            {
                _log.Error($"Database error retrieving conversations for '{username}'.", ex);
                throw;
            }
        }

        public async Task<List<DirectMessageDto>> GetConversationHistoryAsync(string user1, string user2)
        {
            try
            {
                using (var dbContext = new GuessMyMessDBEntities())
                {
                    var player1 = await dbContext.Player.FirstOrDefaultAsync(p => p.username == user1);
                    var player2 = await dbContext.Player.FirstOrDefaultAsync(p => p.username == user2);

                    if (player1 == null || player2 == null)
                    {
                        _log.Warn($"GetConversationHistory failed: One or both users not found.");
                        return new List<DirectMessageDto>();
                    }

                    return await dbContext.DirectMessages
                        .Where(m => (m.SenderPlayerID == player1.idPlayer && m.RecipientPlayerID == player2.idPlayer) ||
                                    (m.SenderPlayerID == player2.idPlayer && m.RecipientPlayerID == player1.idPlayer))
                        .OrderBy(m => m.Timestamp)
                        .Select(m => new DirectMessageDto
                        {
                            SenderUsername = m.Player1.username,
                            RecipientUsername = m.Player.username,
                            Content = m.MessageContent,
                            Timestamp = m.Timestamp
                        })
                        .ToListAsync();
                }
            }
            catch (EntityException ex)
            {
                _log.Error($"Database error retrieving history between '{user1}' and '{user2}'.", ex);
                throw;
            }
        }
    }
}