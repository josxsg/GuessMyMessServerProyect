using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class GameService : IGameService
    {
        public void Connect(string username, string matchId)
        {
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(matchId)) return;

            try
            {
                var callback = OperationContext.Current.GetCallbackChannel<IGameServiceCallback>();
                GameLogic.Instance.ConnectPlayer(username, matchId, callback);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error Connecting: {ex.Message}");
            }
        }

        public void Disconnect(string username, string matchId)
        {
            if (string.IsNullOrEmpty(username)) return;
            GameLogic.Instance.DisconnectPlayer(username, matchId);
        }

        public void SelectWord(string username, string matchId, string selectedWord)
        {
            GameLogic.Instance.RegisterSelectedWord(username, matchId, selectedWord);
        }

        public async Task<List<WordDto>> GetRandomWordsAsync()
        {
            try
            {
                return await GameLogic.Instance.GetRandomWordsAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error GetRandomWords: {ex.Message}");
                throw new FaultException("Error retrieving words from server.");
            }
        }

        public void SubmitDrawing(string username, string matchId, byte[] drawingData)
        {
            try
            {
                GameLogic.Instance.AddDrawing(username, matchId, drawingData);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error SubmitDrawing: {ex.Message}");
            }
        }

        public void SendInGameChatMessage(string username, string matchId, string message)
        {
            try
            {
                GameLogic.Instance.BroadcastChatMessage(username, matchId, message);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error Chat: {ex.Message}");
            }
        }

        public void SubmitGuess(string username, string matchId, int drawingId, string guess)
        {
            try
            {
                GameLogic.Instance.ProcessGuess(username, matchId, drawingId, guess);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error SubmitGuess: {ex.Message}");
            }
        }
    }
}