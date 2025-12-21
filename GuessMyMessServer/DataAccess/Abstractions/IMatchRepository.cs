using GuessMyMessServer.DataAccess;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace GuessMyMessServer.DataAccess.Abstractions
{
    public interface IMatchRepository
    {
        Task<Match> GetMatchByIdAsync(int matchId);
        void AddMatch(Match match);
        Task<int> SaveChangesAsync();
        Task<Match> GetMatchByCodeAsync(string code); 
        Task<bool> MatchCodeExistsAsync(string code); 
        Task<string> GetDifficultyNameAsync(int difficultyId); 
        Task<List<Match>> GetPublicWaitingMatchesAsync();
        Task<bool> IsMatchPrivateAsync(int matchId);
        Task<bool> PlayerHasHistoryInMatchAsync(int matchId, int playerId);
        void AddMatchHistory(MatchHistory history);
        Task<List<MatchHistory>> GetMatchHistoryByMatchIdAsync(int matchId);
        Task<MatchHistory> GetMatchHistoryEntryAsync(int matchId, int playerId);
    }
}