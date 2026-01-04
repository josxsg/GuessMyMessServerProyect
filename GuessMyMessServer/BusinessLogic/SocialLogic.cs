using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.DataAccess.Abstractions;
using GuessMyMessServer.DataAccess.Repositories;
using GuessMyMessServer.Utilities;
using log4net;

namespace GuessMyMessServer.BusinessLogic
{
    public class SocialLogic
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(SocialLogic));
        private readonly ISocialRepository _socialRepository;
        private readonly IPlayerRepository _playerRepository;
        private readonly ISocialNetworkRepository _socialNetworkRepository;
        private const int StatusAccepted = 2;
        private const int StatusPending = 1;
        private const string OnlineStatusString = "Online";

        public SocialLogic(ISocialRepository socialRepository, IPlayerRepository playerRepository, ISocialNetworkRepository socialNetworkRepository)
        {
            _socialRepository = socialRepository;
            _playerRepository = playerRepository;
            _socialNetworkRepository = socialNetworkRepository;
        }

        public async Task<List<FriendDto>> GetFriendsListAsync(string username)
        {
            var user = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (user == null)
            {
                _log.WarnFormat("GetFriendsList failed: User '{0}' not found.", username);
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
                _log.WarnFormat("SearchUsers failed: Requester '{0}' not found.", requesterUsername);
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
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.OperationFailed, Message = "Cannot add self"
                };
            }

            var requester = await _playerRepository.GetPlayerByUsernameAsync(requesterUsername);
            var target = await _playerRepository.GetPlayerByUsernameAsync(targetUsername);

            if (requester == null || target == null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.NotFound, Message = "User not found"
                };
            }

            var existing = await _socialRepository.GetFriendshipAsync(requester.idPlayer, target.idPlayer);
            if (existing != null)
            {
                var errorType = existing.FriendShipStatus_idFriendShipStatus == StatusAccepted
                    ? ServiceErrorType.DuplicateRecord 
                    : ServiceErrorType.OperationFailed; 

                string msg = existing.FriendShipStatus_idFriendShipStatus == StatusAccepted
                    ? "You are already friends."
                    : "A request is already pending.";

                return new OperationResultDto
                {
                    Success = false, ErrorCode = errorType, Message = msg
                };
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
                _log.InfoFormat("Friend request sent: '{0}' -> '{1}'.", requesterUsername, targetUsername);
                return new OperationResultDto
                {
                    Success = true, ErrorCode = ServiceErrorType.None, Message = "Friend request sent."
                };
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
                return new OperationResultDto { Success = false, ErrorCode = ServiceErrorType.NotFound, Message = "User not found" };
            }

            var friendship = await _socialRepository.GetFriendshipAsync(requester.idPlayer, target.idPlayer);
            if (friendship == null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.NotFound, Message = "Request not found"
                };
            }

            if (friendship.FriendShipStatus_idFriendShipStatus != StatusPending)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.OperationFailed, Message = "Status mismatch"
                };
            }

            if (friendship.Player_idPlayer2 != target.idPlayer)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.OperationFailed, Message = "Not your request"
                };
            }

            if (accepted)
            {
                friendship.FriendShipStatus_idFriendShipStatus = StatusAccepted;
                _log.InfoFormat("Friend request accepted by '{0}'.", targetUsername);
            }
            else
            {
                _socialRepository.RemoveFriendship(friendship);
                _log.InfoFormat("Friend request rejected by '{0}'.", targetUsername);
            }

            try
            {
                await _socialRepository.SaveChangesAsync();
                return new OperationResultDto
                {
                    Success = true, ErrorCode = ServiceErrorType.None, Message = accepted ? "Request Accepted" : "Request Rejected"
                };
            }
            catch (Exception ex)
            {
                _log.Error($"Error responding to request for '{targetUsername}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not process response.");
                return null;
            }
        }

        public async Task<OperationResultDto> RemoveFriendAsync(string username, string friendToRemove)
        {
            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            var friend = await _playerRepository.GetPlayerByUsernameAsync(friendToRemove);

            if (player == null || friend == null)
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.NotFound, Message = "User not found"
                };
            }

            var friendship = await _socialRepository.GetFriendshipAsync(player.idPlayer, friend.idPlayer);

            if (friendship != null)
            {
                _socialRepository.RemoveFriendship(friendship);
                try
                {
                    if (await _socialRepository.SaveChangesAsync() > 0)
                    {
                        _log.InfoFormat("Friendship removed between '{0}' and '{1}'.", username, friendToRemove);
                        return new OperationResultDto
                        {
                            Success = true, ErrorCode = ServiceErrorType.None, Message = "Friend successfully removed."
                        };
                    }
                    else
                    {
                        return new OperationResultDto
                        {
                            Success = false, ErrorCode = ServiceErrorType.DatabaseError, Message = "No changes saved"
                        };
                    }
                }
                catch (Exception ex)
                {
                    _log.Error("Error removing friendship.", ex);
                    ThrowServiceFault(ServiceErrorType.DatabaseError, "Error trying to delete friendship");
                    return null;
                }
            }
            else
            {
                return new OperationResultDto
                {
                    Success = false, ErrorCode = ServiceErrorType.NotFound, Message = "Friendship not found"
                };
            }
        }

        public async Task<FriendProfileDto> GetFriendProfileAsync(string username)
        {
            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (player == null)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "User not found.");
            }

            var socialNetworks = await _socialNetworkRepository.GetSocialNetworksAsync(player.idPlayer);

            var dto = new FriendProfileDto
            {
                FirstName = player.name,
                LastName = player.lastName,
                Email = player.email,
                GenderId = player.Gender_idGender.GetValueOrDefault(),
                SocialNetworks = socialNetworks.Select(sn => new SocialNetworkDto
                {
                    NetworkType = sn.TypeSocialNetwork.type,
                    UserLink = sn.userLink
                }).ToList()
            };

            return dto;
        }

        public async Task UpdatePlayerStatusAsync(string username, string status)
        {
            var player = await _playerRepository.GetPlayerByUsernameAsync(username);
            if (player == null)
            {
                _log.WarnFormat("UpdateStatus: User '{0}' not found.", username);
                return;
            }

            var statusId = await _playerRepository.GetUserStatusIdAsync(status);
            if (statusId == null)
            {
                _log.WarnFormat("UpdateStatus: Invalid status '{0}'.", status);
                return;
            }

            if (player.UserStatus_idUserStatus != statusId)
            {
                player.UserStatus_idUserStatus = statusId;
                try
                {
                    await _playerRepository.SaveChangesAsync();
                    _log.DebugFormat("User '{0}' status updated to '{1}'.", username, status);
                }
                catch (Exception ex)
                {
                    _log.Error($"Error updating status for '{username}'.", ex);
                }
            }
        }

        public async Task<DirectMessageDto> SendDirectMessageAsync(DirectMessageDto message)
        {
            if (message == null || string.IsNullOrWhiteSpace(message.Content))
            {
                ThrowServiceFault(ServiceErrorType.OperationFailed, "Invalid message.");
                return null;
            }

            string cleanContent = BadWordValidator.BanMessage(message.Content);
            message.Content = cleanContent;

            var sender = await _playerRepository.GetPlayerByUsernameAsync(message.SenderUsername);
            var recipient = await _playerRepository.GetPlayerByUsernameAsync(message.RecipientUsername);

            if (sender == null || recipient == null)
            {
                ThrowServiceFault(ServiceErrorType.NotFound, "Sender or recipient not found.");
                return null;
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

                return message;
            }
            catch (Exception ex)
            {
                _log.Error($"Error sending message from '{message.SenderUsername}'.", ex);
                ThrowServiceFault(ServiceErrorType.DatabaseError, "Could not send message.");
                return null;
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

        private static void ThrowServiceFault(ServiceErrorType type, string message)
        {
            var fault = new ServiceFaultDto(type, message);
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason(message));
        }
    }
}