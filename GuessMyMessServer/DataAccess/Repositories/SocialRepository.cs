using GuessMyMessServer.DataAccess.Abstractions;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;

namespace GuessMyMessServer.DataAccess.Repositories
{
    public class SocialRepository : ISocialRepository
    {
        private readonly GuessMyMessDBEntities _context;

        public SocialRepository(GuessMyMessDBEntities context)
        {
            _context = context;
        }

        public async Task<Friendship> GetFriendshipAsync(int userId1, int userId2)
        {
            return await _context.Friendship
                .FirstOrDefaultAsync(f =>
                    (f.Player_idPlayer1 == userId1 && f.Player_idPlayer2 == userId2) ||
                    (f.Player_idPlayer1 == userId2 && f.Player_idPlayer2 == userId1));
        }

        public async Task<List<Friendship>> GetFriendsListAsync(int userId)
        {
            const int StatusAccepted = 2;

            return await _context.Friendship
                .Include(f => f.Player)  
                .Include(f => f.Player1) 
                .Where(f => (f.Player_idPlayer1 == userId || f.Player_idPlayer2 == userId)
                            && f.FriendShipStatus_idFriendShipStatus == StatusAccepted)
                .ToListAsync();
        }

        public async Task<bool> AreFriendsAsync(int userId1, int userId2)
        {
            const int StatusAccepted = 2;

            return await _context.Friendship
                .AnyAsync(f =>
                    ((f.Player_idPlayer1 == userId1 && f.Player_idPlayer2 == userId2) ||
                     (f.Player_idPlayer1 == userId2 && f.Player_idPlayer2 == userId1))
                    && f.FriendShipStatus_idFriendShipStatus == StatusAccepted);
        }

        public void AddFriendship(Friendship friendship)
        {
            _context.Friendship.Add(friendship);
        }

        public void RemoveFriendship(Friendship friendship)
        {
            if (friendship != null)
            {
                _context.Friendship.Remove(friendship);
            }
        }

        public async Task<List<Friendship>> GetPendingRequestsAsync(int userId)
        {
            // Asumiendo que FriendShipStatus 2 es "Pendiente" (ajusta según tu BD)
            const int StatusPending = 1;

            // Buscamos donde el usuario es el "Amigo" (el que recibe la solicitud)
            // NOTA: Revisa en tu BD si 'Friend_idPlayer' o 'Player_idPlayer2' es el receptor.
            // Basado en tu entidad Friendship.cs generada anteriormente:
            return await _context.Friendship
                .Include(f => f.Player) // Quien envía
                .Where(f => f.Player_idPlayer2 == userId && f.FriendShipStatus_idFriendShipStatus == StatusPending)
                .ToListAsync();
        }

        public async Task<int> SaveChangesAsync()
        {
            return await _context.SaveChangesAsync();
        }

        public void AddDirectMessage(DirectMessages message)
        {
            _context.DirectMessages.Add(message);
        }

        public async Task<List<DirectMessages>> GetConversationHistoryAsync(int userId1, int userId2)
        {
            return await _context.DirectMessages
                .AsNoTracking()
                .Include(m => m.Player)  // Sender info (si aplica)
                .Include(m => m.Player1) // Recipient info (si aplica)
                .Where(m => (m.SenderPlayerID == userId1 && m.RecipientPlayerID == userId2) ||
                            (m.SenderPlayerID == userId2 && m.RecipientPlayerID == userId1))
                .OrderBy(m => m.Timestamp)
                .ToListAsync();
        }

        public async Task<List<Player>> GetUsersWithConversationAsync(int userId)
        {
            // Obtener IDs de usuarios con los que se ha hablado
            var counterpartIds = await _context.DirectMessages
                .Where(m => m.SenderPlayerID == userId || m.RecipientPlayerID == userId)
                .Select(m => m.SenderPlayerID == userId ? m.RecipientPlayerID : m.SenderPlayerID)
                .Distinct()
                .ToListAsync();

            // Retornar los objetos Player correspondientes
            return await _context.Player
                .AsNoTracking()
                .Where(p => counterpartIds.Contains(p.idPlayer))
                .Include(p => p.UserStatus) // Necesario para ver si están Online
                .ToListAsync();
        }
    }
}