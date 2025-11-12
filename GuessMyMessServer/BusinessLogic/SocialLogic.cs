using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities.Email;

namespace GuessMyMessServer.BusinessLogic
{
    public class SocialLogic
    {
        private readonly IEmailService _emailService;

        public SocialLogic(IEmailService emailService)
        {
            _emailService = emailService;
        }

        public async Task<List<FriendDto>> GetFriendsListAsync(string username)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null)
                {
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

        public async Task<List<FriendRequestInfoDto>> GetFriendRequestsAsync(string username)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null)
                {
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

        public async Task<List<UserProfileDto>> SearchUsersAsync(string searchUsername, string requesterUsername)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var requester = await context.Player.FirstOrDefaultAsync(p => p.username == requesterUsername);
                if (requester == null)
                {
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

        public async Task SendFriendRequestAsync(string requesterUsername, string targetUsername)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var requester = await context.Player.FirstOrDefaultAsync(p => p.username == requesterUsername);
                var target = await context.Player.FirstOrDefaultAsync(p => p.username == targetUsername);

                if (requester == null || target == null)
                {
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
                    throw new InvalidOperationException("A relationship or pending request already exists between these users.");
                }

                const string PendingStatus = "Pending";
                var pendingStatusEntity = await context.FriendShipStatus.FirstOrDefaultAsync(fs => fs.status == PendingStatus);
                if (pendingStatusEntity == null)
                {
                    throw new InvalidOperationException("Internal error: 'Pending' friendship status is not configured.");
                }

                var friendship = new Friendship
                {
                    Player_idPlayer1 = requester.idPlayer,
                    Player_idPlayer2 = target.idPlayer,
                    FriendShipStatus_idFriendShipStatus = pendingStatusEntity.idFriendShipStatus
                };
                context.Friendship.Add(friendship);
                await context.SaveChangesAsync();
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
                    Console.WriteLine("Error responding to request: User not found.");
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
                    throw new InvalidOperationException("A valid pending friend request was not found.");
                }

                if (accepted)
                {
                    const string AcceptedStatus = "Accepted";
                    var acceptedStatusEntity = await context.FriendShipStatus.FirstOrDefaultAsync(fs => fs.status == AcceptedStatus);
                    if (acceptedStatusEntity == null)
                    {
                        throw new InvalidOperationException("Internal error: 'Accepted' friendship status is not configured.");
                    }
                    friendship.FriendShipStatus_idFriendShipStatus = acceptedStatusEntity.idFriendShipStatus;
                }
                else
                {
                    context.Friendship.Remove(friendship);
                }
                await context.SaveChangesAsync();
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
                    Console.WriteLine("Error removing friend: User not found.");
                    return;
                }

                var friendship = await context.Friendship.FirstOrDefaultAsync(f =>
                    (f.Player_idPlayer1 == player.idPlayer && f.Player_idPlayer2 == friend.idPlayer) ||
                    (f.Player_idPlayer1 == friend.idPlayer && f.Player_idPlayer2 == player.idPlayer));

                if (friendship != null)
                {
                    context.Friendship.Remove(friendship);
                    await context.SaveChangesAsync();
                }
                else
                {
                    Console.WriteLine($"Attempt to remove non-existent friendship between {username} and {friendToRemove}.");
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
                    throw new InvalidOperationException($"User '{username}' not found to update status.");
                }

                var userStatus = await context.UserStatus.FirstOrDefaultAsync(s => s.status == status);
                if (userStatus == null)
                {
                    throw new InvalidOperationException($"User status '{status}' is not valid.");
                }

                if (player.UserStatus_idUserStatus != userStatus.idUserStatus)
                {
                    player.UserStatus_idUserStatus = userStatus.idUserStatus;
                    await context.SaveChangesAsync();
                }
            }
        }

        public async Task SendDirectMessageAsync(DirectMessageDto message)
        {
            if (message == null || string.IsNullOrWhiteSpace(message.SenderUsername) ||
                string.IsNullOrWhiteSpace(message.RecipientUsername) || string.IsNullOrWhiteSpace(message.Content))
            {
                throw new ArgumentException("The direct message contains invalid data.");
            }

            using (var dbContext = new GuessMyMessDBEntities())
            {
                var sender = await dbContext.Player.FirstOrDefaultAsync(p => p.username == message.SenderUsername);
                var recipient = await dbContext.Player.FirstOrDefaultAsync(p => p.username == message.RecipientUsername);

                if (sender == null || recipient == null)
                {
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
                await dbContext.SaveChangesAsync();

                message.Timestamp = dbMessage.Timestamp;
            }
        }

        public async Task<List<FriendDto>> GetConversationsAsync(string username)
        {
            using (var dbContext = new GuessMyMessDBEntities())
            {
                var user = await dbContext.Player.FirstOrDefaultAsync(p => p.username == username);
                if (user == null)
                {
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

        public async Task<List<DirectMessageDto>> GetConversationHistoryAsync(string user1, string user2)
        {
            using (var dbContext = new GuessMyMessDBEntities())
            {
                var player1 = await dbContext.Player.FirstOrDefaultAsync(p => p.username == user1);
                var player2 = await dbContext.Player.FirstOrDefaultAsync(p => p.username == user2);

                if (player1 == null || player2 == null)
                {
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
    }
}