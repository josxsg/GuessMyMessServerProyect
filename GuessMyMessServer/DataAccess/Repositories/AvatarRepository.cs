using GuessMyMessServer.DataAccess.Abstractions;
using System.Collections.Generic;
using System.Data.Entity;
using System.Threading.Tasks;

namespace GuessMyMessServer.DataAccess.Repositories
{
    public class AvatarRepository : IAvatarRepository
    {
        private readonly GuessMyMessDBEntities _context;

        public AvatarRepository(GuessMyMessDBEntities context)
        {
            _context = context;
        }

        public async Task<List<Avatar>> GetAllAvatarsAsync()
        {
            return await _context.Avatar.AsNoTracking().ToListAsync();
        }

        public async Task<Avatar> GetAvatarByIdAsync(int id)
        {
            return await _context.Avatar.FindAsync(id);
        }
    }
}