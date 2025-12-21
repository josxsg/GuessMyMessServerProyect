using GuessMyMessServer.DataAccess;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace GuessMyMessServer.DataAccess.Abstractions
{
    public interface ISocialRepository
    {
        Task<Friendship> GetFriendshipAsync(int userId1, int userId2);
        Task<List<Friendship>> GetFriendsListAsync(int userId);
        Task<bool> AreFriendsAsync(int userId1, int userId2);
        void AddFriendship(Friendship friendship);
        void RemoveFriendship(Friendship friendship);
        Task<List<Friendship>> GetPendingRequestsAsync(int userId);
        Task<int> SaveChangesAsync();
        void AddDirectMessage(DirectMessages message);
        Task<List<DirectMessages>> GetConversationHistoryAsync(int userId1, int userId2);
        Task<List<Player>> GetUsersWithConversationAsync(int userId);
    }
}