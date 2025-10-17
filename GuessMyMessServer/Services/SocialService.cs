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

        public List<UserProfileDto> searchUsers(string searchUsername)
        {
            using (var context = new GuessMyMessDBEntities())
            {
                return context.Player
                    .Where(p => p.username.Contains(searchUsername))
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
    }
}
