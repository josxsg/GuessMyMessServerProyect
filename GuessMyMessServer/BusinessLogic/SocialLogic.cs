using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.DataAccess.Abstractions;
using GuessMyMessServer.Utilities;
using log4net;

namespace GuessMyMessServer.BusinessLogic
{
    public class SocialLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(SocialLogic));
        private readonly ISocialRepository _socialRepository;
        private readonly IPlayerRepository _playerRepository;
        private const int StatusAccepted = 2;
        private const int StatusPending = 1;
        private const string OnlineStatusString = "Online";

        public SocialLogic(ISocialRepository socialRepository, IPlayerRepository playerRepository)
        {
            _socialRepository = socialRepository;
            _playerRepository = playerRepository;
        }

        public async Task<List<FriendDto>> GetFriendsListAsync(string username)
        {
            var user = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (user == null)
            {
                _log.Warn($"GetFriendsList failed: User '{username}' not found.");
                ThrowServiceFault(ServiceErrorType.NotFound, "User not found.");
            }

            try
            {
                var friendships = await _socialRepository.GetFriendsListAsync(user.idPlayer);
                return friendships.Select(f =>
                {
                    var friendEntity = f.Player_idPlayer1 == user.idPlayer ? f.Player1 : f.Player;
                    return new FriendDto
                    {
                        Username = friendEntity.username,
                        IsOnline = friendEntity.UserStatus?.status == OnlineStatusString
                    };
                }).ToList();
            }
            catch (Exception ex)
            {
                _log.Error($"Error retrieving friends list for '{username}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not retrieve friends list.");
                return null;
            }
        }

        public async Task<List<FriendRequestInfoDto>> GetFriendRequestsAsync(string username)
        {
            var user = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (user == null)
            {
                return new List<FriendRequestInfoDto>();
            }

            try
            {
                var requests = await _socialRepository.GetPendingRequestsAsync(user.idPlayer);
                return requests.Select(f => new FriendRequestInfoDto
                {
                    RequesterUsername = f.Player.username
                }).ToList();
            }
            catch (Exception ex)
            {
                _log.Error($"Error retrieving friend requests for '{username}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not retrieve friend requests.");
                return null;
            }
        }

        public async Task<List<UserProfileDto>> SearchUsersAsync(string searchUsername, string requesterUsername)
        {
            var requester = await _playerRepository.GetPlayerByUsernameAsync(requesterUsername);
            if (requester == null)
            {
                _log.Warn($"SearchUsers failed: Requester '{requesterUsername}' not found.");
                ThrowServiceFault(ServiceErrorType.NotFound, "Requester user not found.");
            }

            try
            {
                var players = await _playerRepository.SearchPlayersNotFriendsAsync(searchUsername, requester.idPlayer);
                return players.Select(p => new UserProfileDto
                {
                    Username = p.username
                }).ToList();
            }
            catch (Exception ex)
            {
                _log.Error($"Error searching users for '{requesterUsername}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Search operation failed.");
                return null;
            }
        }

        public async Task<OperationResultDto> SendFriendRequestAsync(string requesterUsername, string targetUsername)
        {
            if (requesterUsername == targetUsername)
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "You cannot send a friend request to yourself.");
            }

            var requester = await _playerRepository.GetPlayerByUsernameAsync(requesterUsername);
            var target = await _playerRepository.GetPlayerByUsernameAsync(targetUsername);

            if (requester == null || target == null)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "One or both users not found.");
            }

            var existing = await _socialRepository.GetFriendshipAsync(requester.idPlayer, target.idPlayer);
            if (existing != null)
            {
                string msg = existing.FriendShipStatus_idFriendShipStatus == StatusAccepted
                    ? "You are already friends."
                    : "A request is already pending.";

                _log.Info($"Friend request redundant: {msg}");
                ThrowServiceFault(ServiceErrorType.OperationFailed, msg);
            }

            var friendship = new Friendship
            {
                Player_idPlayer1 = requester.idPlayer,
                Player_idPlayer2 = target.idPlayer,
                FriendShipStatus_idFriendShipStatus = StatusPending
            };

            _socialRepository.AddFriendship(friendship);

            try
            {
                await _socialRepository.SaveChangesAsync();
                _log.Info($"Friend request sent: '{requesterUsername}' -> '{targetUsername}'.");
                return new OperationResultDto { Success = true, Message = "Friend request sent." };
            }
            catch (Exception ex)
            {
                _log.Error($"Database error sending request to '{targetUsername}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not send friend request.");
                return null;
            }
        }

        public async Task<OperationResultDto> RespondToFriendRequestAsync(string targetUsername, string requesterUsername, bool accepted)
        {
            var target = await _playerRepository.GetPlayerByUsernameAsync(targetUsername);
            var requester = await _playerRepository.GetPlayerByUsernameAsync(requesterUsername);

            if (target == null || requester == null)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "Users not found.");
            }

            var friendship = await _socialRepository.GetFriendshipAsync(requester.idPlayer, target.idPlayer);
            if (friendship == null)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "Friend request not found.");
            }

            if (friendship.FriendShipStatus_idFriendShipStatus != StatusPending)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "Friend request not found (Status mismatch).");
            }

            if (friendship.Player_idPlayer2 != target.idPlayer)
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "You cannot respond to this request.");
            }

            if (accepted)
            {
                friendship.FriendShipStatus_idFriendShipStatus = StatusAccepted;
                _log.Info($"Friend request accepted by '{targetUsername}'.");
            }
            else
            {
                _socialRepository.RemoveFriendship(friendship);
                _log.Info($"Friend request rejected by '{targetUsername}'.");
            }

            try
            {
                await _socialRepository.SaveChangesAsync();
                return new OperationResultDto { Success = true, Message = accepted ? "Request Accepted" : "Request Rejected" };
            }
            catch (Exception ex)
            {
                _log.Error($"Error responding to request for '{targetUsername}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not process response.");
                return null;
            }
        }

        public async Task RemoveFriendAsync(string username, string friendToRemove)
        {
            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            var friend = await _playerRepository.GetPlayerByUsernameAsync(friendToRemove);

            if (player == null || friend == null)
            {
                return;
            }

            var friendship = await _socialRepository.GetFriendshipAsync(player.idPlayer, friend.idPlayer);

            if (friendship != null)
            {
                _socialRepository.RemoveFriendship(friendship);
                try
                {
                    await _socialRepository.SaveChangesAsync();
                    _log.Info($"Friendship removed between '{username}' and '{friendToRemove}'.");
                }
                catch (Exception ex)
                {
                    _log.Error("Error removing friendship.", ex);
                    ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not remove friend.");
                }
            }
        }

        public async Task UpdatePlayerStatusAsync(string username, string status)
        {
            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (player == null)
            {
                _log.Warn($"UpdateStatus: User '{username}' not found.");
                return;
            }

            var statusId = await _playerRepository.GetUserStatusIdAsync(status);
            if (statusId == null)
            {
                _log.Warn($"UpdateStatus: Invalid status '{status}'.");
                return;
            }

            if (player.UserStatus_idUserStatus != statusId)
            {
                player.UserStatus_idUserStatus = statusId;
                try
                {
                    await _playerRepository.SaveChangesAsync();
                    _log.Debug($"User '{username}' status updated to '{status}'.");
                }
                catch (Exception ex)
                {
                    _log.Error($"Error updating status for '{username}'.", ex);
                }
            }
        }

        public async Task SendDirectMessageAsync(DirectMessageDto message)
        {
            if (message == null || string.IsNullOrWhiteSpace(message.Content))
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Invalid message.");
            }

            var sender = await _playerRepository.GetPlayerByUsernameAsync(message.SenderUsername);
            var recipient = await _playerRepository.GetPlayerByUsernameAsync(message.RecipientUsername);

            if (sender == null || recipient == null)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "Sender or recipient not found.");
            }

            var dbMessage = new DirectMessages
            {
                SenderPlayerID = sender.idPlayer,
                RecipientPlayerID = recipient.idPlayer,
                MessageContent = message.Content,
                Timestamp = DateTime.UtcNow
            };

            _socialRepository.AddDirectMessage(dbMessage);

            try
            {
                await _socialRepository.SaveChangesAsync();
                message.Timestamp = dbMessage.Timestamp;
            }
            catch (Exception ex)
            {
                _log.Error($"Error sending message from '{message.SenderUsername}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not send message.");
            }
        }

        public async Task<List<FriendDto>> GetConversationsAsync(string username)
        {
            var user = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (user == null)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "User not found.");
            }

            try
            {
                var usersWithChat = await _socialRepository.GetUsersWithConversationAsync(user.idPlayer);
                return usersWithChat.Select(p => new FriendDto
                {
                    Username = p.username,
                    IsOnline = p.UserStatus?.status == OnlineStatusString
                }).ToList();
            }
            catch (Exception ex)
            {
                _log.Error($"Error getting conversations for '{username}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not retrieve conversations.");
                return null;
            }
        }

        public async Task<List<DirectMessageDto>> GetConversationHistoryAsync(string user1, string user2)
        {
            var p1 = await _playerRepository.GetPlayerByUsernameAsync(user1);
            var p2 = await _playerRepository.GetPlayerByUsernameAsync(user2);

            if (p1 == null || p2 == null)
            {
                return new List<DirectMessageDto>();
            }

            try
            {
                var messages = await _socialRepository.GetConversationHistoryAsync(p1.idPlayer, p2.idPlayer);
                return messages.Select(m => new DirectMessageDto
                {
                    SenderUsername = m.Player1.username,
                    RecipientUsername = m.Player.username,
                    Content = m.MessageContent,
                    Timestamp = m.Timestamp
                }).ToList();
            }
            catch (Exception ex)
            {
                _log.Error("Error retrieving chat history.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not retrieve chat history.");
                return null;
            }
        }

        private void ThrowServiceFault(ServiceErrorType type, string message)
        {
            var fault = new ServiceFaultDto(type, message);
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason(message));
        }
    }
}
