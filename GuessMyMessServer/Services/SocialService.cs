using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;

namespace GuessMyMessServer.Services
{
    // PerSession para mantener la conexión Dúplex (callback) activa
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession)]
    public class SocialService : ISocialService
    {
        private ISocialServiceCallback callback;

        public SocialService()
        {
            callback = OperationContext.Current.GetCallbackChannel<ISocialServiceCallback>();
        }

        public List<FriendDto> getFriendsList(string username)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = context.Player.FirstOrDefault(p => p.username == username);
                if (player == null)
                {
                    return new List<FriendDto>();
                }

                var friends = context.Friendship
                    .Where(f => (f.Player_idPlayer1 == player.idPlayer || f.Player_idPlayer2 == player.idPlayer)
                                && f.FriendShipStatus.status == "Accepted")

                    .Select(f => f.Player_idPlayer1 == player.idPlayer ? f.Player1 : f.Player)

                    .Select(p => new FriendDto
                    {
                        username = p.username,
                        isOnline = p.UserStatus.status == "Online"
                    })
                    .ToList();

                return friends;
            }
        }

        public List<FriendRequestInfoDto> getFriendRequests(string username)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = context.Player.FirstOrDefault(p => p.username == username);
                if (player == null) return new List<FriendRequestInfoDto>();

                var requests = context.Friendship
                    .Where(f => f.Player_idPlayer2 == player.idPlayer && f.FriendShipStatus.status == "Pending")
                    .Select(f => new FriendRequestInfoDto
                    {
                        requesterUsername = f.Player.username
                    }).ToList();
                return requests;
            }
        }

        public List<UserProfileDto> searchUsers(string searchUsername, string requesterUsername)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                return context.Player
                    .Where(p => p.username.Contains(searchUsername) && p.username != requesterUsername)
                    .Select(p => new UserProfileDto
                    {
                        Username = p.username
                    }).ToList();
            }
        }

        public void sendFriendRequest(string requesterUsername, string targetUsername)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var requester = context.Player.FirstOrDefault(p => p.username == requesterUsername);
                var target = context.Player.FirstOrDefault(p => p.username == targetUsername);
                var pendingStatus = context.FriendShipStatus.FirstOrDefault(fs => fs.status == "Pending");

                if (requester != null && target != null && pendingStatus != null)
                {
                    var friendship = new Friendship
                    {
                        Player_idPlayer1 = requester.idPlayer,
                        Player_idPlayer2 = target.idPlayer,
                        FriendShipStatus_idFriendShipStatus = pendingStatus.idFriendShipStatus
                    };
                    context.Friendship.Add(friendship);
                    context.SaveChanges();
                }
            }
        }

        public void respondToFriendRequest(string targetUsername, string requesterUsername, bool accepted)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var target = context.Player.FirstOrDefault(p => p.username == targetUsername);
                var requester = context.Player.FirstOrDefault(p => p.username == requesterUsername);

                if (target != null && requester != null)
                {
                    var friendship = context.Friendship
                        .FirstOrDefault(f => f.Player_idPlayer1 == requester.idPlayer && f.Player_idPlayer2 == target.idPlayer);

                    if (friendship != null)
                    {
                        if (accepted)
                        {
                            var acceptedStatus = context.FriendShipStatus.FirstOrDefault(fs => fs.status == "Accepted");
                            if (acceptedStatus != null)
                            {
                                friendship.FriendShipStatus_idFriendShipStatus = acceptedStatus.idFriendShipStatus;
                            }
                        }
                        else
                        {
                            context.Friendship.Remove(friendship);
                        }
                        context.SaveChanges();
                    }
                }
            }
        }

        public void removeFriend(string username, string friendToRemove)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                var player = context.Player.FirstOrDefault(p => p.username == username);
                var friend = context.Player.FirstOrDefault(p => p.username == friendToRemove);

                if (player != null && friend != null)
                {
                    var friendship = context.Friendship.FirstOrDefault(f =>
                        (f.Player_idPlayer1 == player.idPlayer && f.Player_idPlayer2 == friend.idPlayer) ||
                        (f.Player_idPlayer1 == friend.idPlayer && f.Player_idPlayer2 == player.idPlayer));

                    if (friendship != null)
                    {
                        context.Friendship.Remove(friendship);
                        context.SaveChanges();
                    }
                }
            }
        }

        public OperationResultDto inviteFriendToGameByEmail(string fromUsername, string friendEmail, string matchCode)
        {
            // Lógica para enviar invitación por correo
            throw new NotImplementedException();
        }

        public void SendDirectMessage(DirectMessageDto message)
        {
            if (message == null || string.IsNullOrEmpty(message.senderUsername) || string.IsNullOrEmpty(message.recipientUsername) || string.IsNullOrEmpty(message.content))
            {
                Console.WriteLine("Received invalid message (missing sender, recipient, or content).");
                return;
            }

            try
            {
                using (var dbContext = new GuessMyMessDBEntities())
                {
                    var sender = dbContext.Player.FirstOrDefault(p => p.username == message.senderUsername);
                    var recipient = dbContext.Player.FirstOrDefault(p => p.username == message.recipientUsername);

                    if (sender != null && recipient != null)
                    {
                        var dbMessage = new DirectMessages 
                        {
                            SenderPlayerID = sender.idPlayer,
                            RecipientPlayerID = recipient.idPlayer,
                            MessageContent = message.content,                            
                        };

                        dbContext.DirectMessages.Add(dbMessage); 
                        dbContext.SaveChanges(); 
                    }
                    else
                    {
                        throw new FaultException("Sender or recipient username not valid.");
                    }
                }
            }
            catch (Exception ex) 
            {
                throw new FaultException("Failed to save the message due to a server error.");
            }
        }

        public List<FriendDto> GetConversations(string username)
        {
            Console.WriteLine($"Fetching conversations for {username}...");
            var conversations = new List<FriendDto>();
            try
            {
                using (var dbContext = new GuessMyMessDBEntities())
                {
                    var user = dbContext.Player.FirstOrDefault(p => p.username == username);
                    if (user != null)
                    {
                        var userId = user.idPlayer;

                        // Obtener IDs de usuarios con los que ha hablado
                        var senderIds = dbContext.DirectMessages
                            .Where(m => m.RecipientPlayerID == userId)
                            .Select(m => m.SenderPlayerID)
                            .Distinct();

                        var recipientIds = dbContext.DirectMessages
                            .Where(m => m.SenderPlayerID == userId)
                            .Select(m => m.RecipientPlayerID)
                            .Distinct();

                        // Combinar IDs, eliminar duplicados y el propio ID del usuario
                        var userIds = senderIds.Union(recipientIds)
                                             .Distinct()
                                             .Where(id => id != userId)
                                             .ToList();

                        conversations = dbContext.Player
                            .Where(p => userIds.Contains(p.idPlayer))
                            .Select(p => new FriendDto
                            {
                                username = p.username,
                                isOnline = p.UserStatus.status == "Online" // Obtenemos el estado
                            })
                            .ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error fetching conversations for {username}: {ex.Message}");
            }
            return conversations;
        }

        public List<DirectMessageDto> GetConversationHistory(string user1, string user2)
        {
            Console.WriteLine($"Fetching history between {user1} and {user2}...");
            var history = new List<DirectMessageDto>();
            try
            {
                using (var dbContext = new GuessMyMessDBEntities())
                {
                    var player1 = dbContext.Player.FirstOrDefault(p => p.username == user1);
                    var player2 = dbContext.Player.FirstOrDefault(p => p.username == user2);

                    if (player1 != null && player2 != null)
                    {
                        var player1Id = player1.idPlayer;
                        var player2Id = player2.idPlayer;

                        var messagesFromDb = dbContext.DirectMessages
                            .Where(m => (m.SenderPlayerID == player1Id && m.RecipientPlayerID == player2Id) ||
                                         (m.SenderPlayerID == player2Id && m.RecipientPlayerID == player1Id))
                            .OrderBy(m => m.Timestamp) // Ordenar por fecha
                            .Select(m => new DirectMessageDto // Mapear de entidad BD a DTO
                            {
                                senderUsername = m.Player.username,   // Asume navegación Player->username (remitente)
                                recipientUsername = m.Player1.username, 
                                content = m.MessageContent,
                                timestamp = m.Timestamp,
                            })
                            .ToList();

                        history.AddRange(messagesFromDb);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error fetching history between {user1} and {user2}: {ex.Message}");
                // Devolver lista vacía o lanzar FaultException
            }
            return history;
        }
    }
}
