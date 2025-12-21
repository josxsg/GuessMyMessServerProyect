using GuessMyMessServer.DataAccess.Abstractions;
using System;
using System.Data.Entity; 
using System.Threading.Tasks;
using System.Linq;
using System.Collections.Generic;

namespace GuessMyMessServer.DataAccess.Repositories
{
    public class PlayerRepository : IPlayerRepository
    {
        private readonly GuessMyMessDBEntities _context;

        public PlayerRepository(GuessMyMessDBEntities context)
        {
            _context = context;
        }

        public async Task<Player> GetPlayerByUsernameAsync(string username)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                return null;
            }

            return await _context.Player
                .FirstOrDefaultAsync(p => p.username == username);
        }

        public async Task<Player> GetPlayerByEmailAsync(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
            {
                return null;
            }

            return await _context.Player
                .FirstOrDefaultAsync(p => p.email == email);
        }

        public void AddPlayer(Player player)
        {
            if (player == null)
            {
                throw new ArgumentNullException(nameof(player));
            }
            _context.Player.Add(player);
        }

        public async Task<int> SaveChangesAsync()
        {
            return await _context.SaveChangesAsync();
        }

        public async Task<Player> GetPlayerProfileDataAsync(string username)
        {
            if (string.IsNullOrWhiteSpace(username)) return null;

            return await _context.Player
                .AsNoTracking()
                .Include(p => p.Gender)
                .Include(p => p.Avatar)
                .Include(p => p.SocialNetwork.Select(sn => sn.TypeSocialNetwork)) 
                .FirstOrDefaultAsync(p => p.username == username);
        }

        public async Task<List<Player>> SearchPlayersNotFriendsAsync(string searchText, int requesterId)
        {
            // Obtener IDs de amigos actuales para excluirlos
            var friendIds = await _context.Friendship
                .Where(f => f.Player_idPlayer1 == requesterId || f.Player_idPlayer2 == requesterId)
                .Select(f => f.Player_idPlayer1 == requesterId ? f.Player_idPlayer2 : f.Player_idPlayer1)
                .Distinct()
                .ToListAsync();

            // Agregar al propio usuario para excluirlo también
            friendIds.Add(requesterId);

            // Buscar usuarios que coincidan con el texto y NO estén en la lista de amigos/propio
            return await _context.Player
                .AsNoTracking()
                .Where(p => p.username.Contains(searchText) &&
                            !friendIds.Contains(p.idPlayer))
                .ToListAsync();
        }

        public async Task<int?> GetUserStatusIdAsync(string statusName)
        {
            var status = await _context.UserStatus.FirstOrDefaultAsync(s => s.status == statusName);
            return status?.idUserStatus;
        }
    }
}