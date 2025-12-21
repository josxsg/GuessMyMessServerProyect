using GuessMyMessServer.DataAccess;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace GuessMyMessServer.DataAccess.Abstractions
{
    public interface IWordRepository
    {
        Task<List<Word>> GetRandomWordsAsync(int count);
    }
}