using GuessMyMessServer.DataAccess.Abstractions;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;

namespace GuessMyMessServer.DataAccess.Repositories
{
    public class WordRepository : IWordRepository
    {
        private readonly GuessMyMessDBEntities _context;

        public WordRepository(GuessMyMessDBEntities context)
        {
            _context = context;
        }

        public async Task<List<Word>> GetRandomWordsAsync(int count, int difficultyId)
        {
            return await _context.Word
                .Where(w => w.WordDifficulty_idWordDifficulty == difficultyId) 
                .OrderBy(w => Guid.NewGuid())
                .Take(count)
                .ToListAsync();
        }
    }
}