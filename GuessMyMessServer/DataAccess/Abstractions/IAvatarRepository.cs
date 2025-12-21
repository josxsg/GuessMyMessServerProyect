using GuessMyMessServer.DataAccess;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace GuessMyMessServer.DataAccess.Abstractions
{
    public interface IAvatarRepository
    {
        Task<List<Avatar>> GetAllAvatarsAsync();
        Task<Avatar> GetAvatarByIdAsync(int id);
    }
}