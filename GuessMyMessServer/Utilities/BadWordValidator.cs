using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace GuessMyMessServer.Utilities
{
    public static class BadWordValidator
    {
        // HashSet es muy rápido para búsquedas.
        // StringComparer.OrdinalIgnoreCase hace que "TONTO" == "tonto"
        private static readonly HashSet<string> _bannedWords = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
        {
            "tonto",
            "idiota",
            "estupido",
            "fuck",
            "nigga",
            "imbecil",
            "mierda",
            "pendejo",
            "shit",
            "inutil",
            "puto",
            "maldito"
            // Añade más aquí según necesites
        };

        public static string BanMessage(string message)
        {
            if (string.IsNullOrWhiteSpace(message)) return message;

            string processedMessage = message;

            foreach (var badWord in _bannedWords)
            {
                // \b asegura que sea palabra completa (evita censurar "computadora" por "puta")
                // Regex.Escape evita errores si la grosería tiene símbolos raros
                string pattern = $@"\b{Regex.Escape(badWord)}\b";

                processedMessage = Regex.Replace(processedMessage, pattern, match =>
                {
                    // Reemplaza con asteriscos del mismo largo que la palabra encontrada
                    return new string('*', match.Length);
                }, RegexOptions.IgnoreCase);
            }

            return processedMessage;
        }
    }
}