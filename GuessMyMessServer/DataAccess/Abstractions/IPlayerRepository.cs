using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace GuessMyMessServer.DataAccess.Abstractions
{
    public interface IPlayerRepository
    {
        Task<Player> GetPlayerByUsernameAsync(string username);
        Task<Player> GetPlayerByEmailAsync(string email);
        void AddPlayer(Player player);
        Task<int> SaveChangesAsync();
        Task<Player> GetPlayerProfileDataAsync(string username);
        Task<List<Player>> SearchPlayersNotFriendsAsync(string searchText, int requesterId);
        Task<int?> GetUserStatusIdAsync(string statusName);
        Task<List<PlayerScoreDto>> GetGlobalRankingAsync();
    }
}