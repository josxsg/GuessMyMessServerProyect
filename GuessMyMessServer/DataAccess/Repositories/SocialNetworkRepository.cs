using GuessMyMessServer.DataAccess.Abstractions;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;

namespace GuessMyMessServer.DataAccess.Repositories
{
    public class SocialNetworkRepository : ISocialNetworkRepository
    {
        private readonly GuessMyMessDBEntities _context;

        public SocialNetworkRepository(GuessMyMessDBEntities context)
        {
            _context = context;
        }

        public async Task<TypeSocialNetwork> GetTypeByNameAsync(string typeName)
        {
            return await _context.TypeSocialNetwork
                .FirstOrDefaultAsync(t => t.type == typeName);
        }

        public async Task<SocialNetwork> GetPlayerSocialNetworkAsync(int playerId, int typeId)
        {
            return await _context.SocialNetwork
                .FirstOrDefaultAsync(s => s.Player_idPlayer == playerId &&
                                          s.TypeSocialNetwork_idTypeSocialNetwork == typeId);
        }

        public void AddSocialNetwork(SocialNetwork socialNetwork)
        {
            _context.SocialNetwork.Add(socialNetwork);
        }

        public async Task<int> SaveChangesAsync()
        {
            return await _context.SaveChangesAsync();
        }

        public async Task<List<SocialNetwork>> GetSocialNetworksAsync(int playerId)
        {
            return await _context.SocialNetwork
                .Include(s => s.TypeSocialNetwork) 
                .Where(s => s.Player_idPlayer == playerId)
                .ToListAsync();
        }
    }
}