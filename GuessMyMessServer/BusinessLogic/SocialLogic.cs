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

        // El constructor puede aceptar el servicio de email si lo necesitas para invitaciones
        public SocialLogic(IEmailService emailService)
        {
            _emailService = emailService;
        }

        public async Task<List<FriendDto>> GetFriendsListAsync(string username)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null) throw new Exception("Usuario no encontrado.");

                return await context.Friendship
                    .Where(f => (f.Player_idPlayer1 == player.idPlayer || f.Player_idPlayer2 == player.idPlayer)
                                && f.FriendShipStatus.status == "Accepted")
                    .Select(f => f.Player_idPlayer1 == player.idPlayer ? f.Player1 : f.Player)
                    .Select(p => new FriendDto
                    {
                        username = p.username,
                        isOnline = p.UserStatus.status == "Online"
                    })
                    .ToListAsync();
            }
        }

        public async Task<List<FriendRequestInfoDto>> GetFriendRequestsAsync(string username)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                if (player == null) return new List<FriendRequestInfoDto>();

                return await context.Friendship
                    .Where(f => f.Player_idPlayer2 == player.idPlayer && f.FriendShipStatus.status == "Pending")
                    .Select(f => new FriendRequestInfoDto
                    {
                        requesterUsername = f.Player.username
                    }).ToListAsync();
            }
        }

        public async Task<List<UserProfileDto>> SearchUsersAsync(string searchUsername, string requesterUsername)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                return await context.Player
                    .Where(p => p.username.Contains(searchUsername) && p.username != requesterUsername)
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
                var pendingStatus = await context.FriendShipStatus.FirstOrDefaultAsync(fs => fs.status == "Pending");

                if (requester != null && target != null && pendingStatus != null)
                {
                    var friendship = new Friendship
                    {
                        Player_idPlayer1 = requester.idPlayer,
                        Player_idPlayer2 = target.idPlayer,
                        FriendShipStatus_idFriendShipStatus = pendingStatus.idFriendShipStatus
                    };
                    context.Friendship.Add(friendship);
                    await context.SaveChangesAsync();
                }
            }
        }

        public async Task RespondToFriendRequestAsync(string targetUsername, string requesterUsername, bool accepted)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var target = await context.Player.FirstOrDefaultAsync(p => p.username == targetUsername);
                var requester = await context.Player.FirstOrDefaultAsync(p => p.username == requesterUsername);

                if (target != null && requester != null)
                {
                    var friendship = await context.Friendship
                        .FirstOrDefaultAsync(f => f.Player_idPlayer1 == requester.idPlayer && f.Player_idPlayer2 == target.idPlayer);

                    if (friendship != null)
                    {
                        if (accepted)
                        {
                            var acceptedStatus = await context.FriendShipStatus.FirstOrDefaultAsync(fs => fs.status == "Accepted");
                            if (acceptedStatus != null)
                            {
                                friendship.FriendShipStatus_idFriendShipStatus = acceptedStatus.idFriendShipStatus;
                            }
                        }
                        else
                        {
                            context.Friendship.Remove(friendship);
                        }
                        await context.SaveChangesAsync();
                    }
                }
            }
        }

        public async Task RemoveFriendAsync(string username, string friendToRemove)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = await context.Player.FirstOrDefaultAsync(p => p.username == username);
                var friend = await context.Player.FirstOrDefaultAsync(p => p.username == friendToRemove);

                if (player != null && friend != null)
                {
                    var friendship = await context.Friendship.FirstOrDefaultAsync(f =>
                        (f.Player_idPlayer1 == player.idPlayer && f.Player_idPlayer2 == friend.idPlayer) ||
                        (f.Player_idPlayer1 == friend.idPlayer && f.Player_idPlayer2 == player.idPlayer));

                    if (friendship != null)
                    {
                        context.Friendship.Remove(friendship);
                        await context.SaveChangesAsync();
                    }
                }
            }
        }

        public async Task SendDirectMessageAsync(DirectMessageDto message)
        {
            if (message == null || string.IsNullOrEmpty(message.senderUsername) || string.IsNullOrEmpty(message.recipientUsername) || string.IsNullOrEmpty(message.content))
            {
                throw new Exception("Mensaje inválido (falta remitente, destinatario o contenido).");
            }

            using (var dbContext = new GuessMyMessDBEntities())
            {
                var sender = await dbContext.Player.FirstOrDefaultAsync(p => p.username == message.senderUsername);
                var recipient = await dbContext.Player.FirstOrDefaultAsync(p => p.username == message.recipientUsername);

                if (sender == null || recipient == null)
                {
                    throw new Exception("El remitente o el destinatario no son válidos.");
                }

                var dbMessage = new DirectMessages
                {
                    SenderPlayerID = sender.idPlayer,
                    RecipientPlayerID = recipient.idPlayer,
                    MessageContent = message.content,
                    Timestamp = DateTime.UtcNow // Asignar timestamp aquí
                };

                dbContext.DirectMessages.Add(dbMessage);
                await dbContext.SaveChangesAsync();
            }
        }

        public async Task<List<FriendDto>> GetConversationsAsync(string username)
        {
            using (var dbContext = new GuessMyMessDBEntities())
            {
                var user = await dbContext.Player.FirstOrDefaultAsync(p => p.username == username);
                if (user == null) return new List<FriendDto>();

                var userId = user.idPlayer;

                var senderIds = await dbContext.DirectMessages
                    .Where(m => m.RecipientPlayerID == userId)
                    .Select(m => m.SenderPlayerID)
                    .Distinct()
                    .ToListAsync();

                var recipientIds = await dbContext.DirectMessages
                    .Where(m => m.SenderPlayerID == userId)
                    .Select(m => m.RecipientPlayerID)
                    .Distinct()
                    .ToListAsync();

                var userIds = senderIds.Union(recipientIds).Distinct().ToList();
                userIds.Remove(userId);

                return await dbContext.Player
                    .Where(p => userIds.Contains(p.idPlayer))
                    .Select(p => new FriendDto
                    {
                        username = p.username,
                        isOnline = p.UserStatus.status == "Online"
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

                if (player1 == null || player2 == null) return new List<DirectMessageDto>();

                return await dbContext.DirectMessages
                    .Where(m => (m.SenderPlayerID == player1.idPlayer && m.RecipientPlayerID == player2.idPlayer) ||
                                (m.SenderPlayerID == player2.idPlayer && m.RecipientPlayerID == player1.idPlayer))
                    .OrderBy(m => m.Timestamp)
                    .Select(m => new DirectMessageDto
                    {
                        senderUsername = m.Player.username,
                        recipientUsername = m.Player1.username,
                        content = m.MessageContent,
                        timestamp = m.Timestamp,
                    })
                    .ToListAsync();
            }
        }
    }
}