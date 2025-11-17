using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;

namespace GuessMyMessServer.BusinessLogic
{
    public class GameLogic
    {
        private readonly GuessMyMessDBEntities _context;
        private static readonly Random _random = new Random();

        public GameLogic(GuessMyMessDBEntities context)
        {
            _context = context;
        }

        public async Task<List<WordDto>> GetRandomWordsAsync()
        {
            const int WordsToSelect = 3;

            var allWords = await _context.Word
                .Select(w => new WordDto
                {
                    WordId = w.idWord,
                    WordKey = w.word1
                })
                .ToListAsync();

            if (allWords.Count < WordsToSelect)
            {
                throw new InvalidOperationException("Not enough words in the database to start the game.");
            }

            var randomWords = allWords
                .OrderBy(w => _random.Next())
                .Take(WordsToSelect)
                .ToList();

            return randomWords;
        }
    }
}