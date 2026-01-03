using GuessMyMessServer.DataAccess.Abstractions;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;

namespace GuessMyMessServer.DataAccess.Repositories
{
    public class MatchRepository : IMatchRepository
    {
        private readonly GuessMyMessDBEntities _context;

        public MatchRepository(GuessMyMessDBEntities context)
        {
            _context = context;
        }

        public async Task<Match> GetMatchByIdAsync(int matchId)
        {
            return await _context.Match.FindAsync(matchId);
        }

        public async Task<Match> GetMatchByCodeAsync(string code)
        {
            return await _context.Match.FirstOrDefaultAsync(m => m.matchCode == code);
        }

        public async Task<Match> GetMatchByPlayerAsync(string username)
        {
            // 1. Buscamos en el historial (MatchHistory)
            // 2. Filtramos donde el jugador tenga ese gamertag
            // 3. Y donde la partida asociada siga 'InGame' o 'Waiting'
            var activeHistory = await _context.MatchHistory
                .Include(h => h.Match)
                .Include(h => h.Player)
                .Where(h => h.Player.username == username)
                .OrderByDescending(h => h.idMatchHistory) // Por si acaso hay residuos, tomamos el último
                .FirstOrDefaultAsync();

            // Devolvemos la partida (Match) o null si no se encontró
            return activeHistory?.Match;
        }

        public async Task<bool> MatchCodeExistsAsync(string code)
        {
            // Verificamos si existe y si está en espera (según tu lógica original)
            return await _context.Match.AnyAsync(m => m.matchCode == code && m.matchStatus == "Waiting");
        }

        public async Task<string> GetDifficultyNameAsync(int difficultyId)
        {
            var diff = await _context.MatchDifficulty.FindAsync(difficultyId);
            return diff?.difficulty ?? "Unknown";
        }

        public async Task<List<Match>> GetPublicWaitingMatchesAsync()
        {
            // isPrivate: 0 = false, 1 = true
            return await _context.Match
                .Where(m => m.isPrivate == 0 && m.matchStatus == "Waiting")
                .ToListAsync();
        }

        public void AddMatch(Match match)
        {
            _context.Match.Add(match);
        }

        public async Task<int> SaveChangesAsync()
        {
            return await _context.SaveChangesAsync();
        }

        public async Task<bool> IsMatchPrivateAsync(int matchId)
        {
            var match = await _context.Match
                .Select(m => new { m.idMatch, m.isPrivate }) // Proyección para mejorar rendimiento
                .FirstOrDefaultAsync(m => m.idMatch == matchId);

            // Si no existe la partida, asumimos que no es accesible (o manejamos lógica de negocio después)
            // Aquí retornamos false o manejamos null según prefieras, pero el repo solo devuelve datos.
            return match != null && match.isPrivate == 1;
        }

        public async Task<bool> PlayerHasHistoryInMatchAsync(int matchId, int playerId)
        {
            return await _context.MatchHistory.AnyAsync(h => h.Match_idMatch == matchId && h.Player_idPlayer == playerId);
        }

        public void AddMatchHistory(MatchHistory history)
        {
            _context.MatchHistory.Add(history);
        }

        public async Task<List<MatchHistory>> GetMatchHistoryByMatchIdAsync(int matchId)
        {
            return await _context.MatchHistory
                .Where(h => h.Match_idMatch == matchId)
                .ToListAsync();
        }

        public async Task<MatchHistory> GetMatchHistoryEntryAsync(int matchId, int playerId)
        {
            return await _context.MatchHistory
                .FirstOrDefaultAsync(h => h.Match_idMatch == matchId && h.Player_idPlayer == playerId);
        }
    }
}