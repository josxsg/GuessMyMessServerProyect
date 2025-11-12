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
        // ¡Usaremos esta clase Random que ya tenías!
        private static readonly Random _random = new Random();

        public GameLogic(GuessMyMessDBEntities context)
        {
            _context = context;
        }

        public async Task<List<WordDto>> GetRandomWordsAsync()
        {
            const int WordsToSelect = 3;

            // 1. Traemos TODAS las palabras de la BD a la memoria del servidor
            var allWords = await _context.Word
                .Select(w => new WordDto
                {
                    WordId = w.idWord,
                    WordKey = w.word1
                })
                .ToListAsync(); // <-- Primero las obtenemos todas

            // 2. Si hay menos de 3, lanzamos el error
            if (allWords.Count < WordsToSelect)
            {
                throw new InvalidOperationException("No hay suficientes palabras en la base de datos para iniciar la partida.");
            }

            // 3. ¡Aquí está la magia!
            //    Las "barajamos" en la memoria de C# y tomamos 3
            var randomWords = allWords
                .OrderBy(w => _random.Next()) // <-- Aleatorización en C#
                .Take(WordsToSelect)           // <-- Tomamos 3
                .ToList();

            return randomWords;
        }
    }
}