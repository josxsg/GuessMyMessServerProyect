using GuessMyMessServer.DataAccess;
using System.Threading.Tasks;

namespace GuessMyMessServer.DataAccess.Abstractions
{
    public interface ISocialNetworkRepository
    {
        Task<TypeSocialNetwork> GetTypeByNameAsync(string typeName);
        Task<SocialNetwork> GetPlayerSocialNetworkAsync(int playerId, int typeId);
        void AddSocialNetwork(SocialNetwork socialNetwork);
        Task<int> SaveChangesAsync();
    }
}