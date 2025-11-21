using System;
using System.Collections.Generic;
using System.Data.Entity.Core;
using System.ServiceModel;
using System.Threading.Tasks;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.Properties;
using GuessMyMessServer.Properties.Langs;
using log4net;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class GameService : IGameService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(GameService));

        public void Connect(string username, string matchId)
        {
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(matchId))
            {
                _log.Warn("GameService: Connect attempt with empty username or matchId.");
                return;
            }

            try
            {
                var callback = OperationContext.Current.GetCallbackChannel<IGameServiceCallback>();
                GameLogic.Instance.ConnectPlayer(username, matchId, callback);
            }
            catch (Exception ex)
            {
                _log.Error($"Error connecting player '{username}' to match '{matchId}'", ex);
            }
        }

        public void Disconnect(string username, string matchId)
        {
            try
            {
                if (string.IsNullOrEmpty(username)) return;
                GameLogic.Instance.DisconnectPlayer(username, matchId);
            }
            catch (Exception ex)
            {
                _log.Warn($"Error disconnecting player '{username}' from match '{matchId}'", ex);
            }
        }

        public void SelectWord(string username, string matchId, string selectedWord)
        {
            try
            {
                GameLogic.Instance.RegisterSelectedWord(username, matchId, selectedWord);
            }
            catch (Exception ex)
            {
                _log.Error($"Error registering word selection for '{username}' in match '{matchId}'", ex);
            }
        }

        public async Task<List<WordDto>> GetRandomWordsAsync()
        {
            try
            {
                return await GameLogic.Instance.GetRandomWordsAsync();
            }
            catch (EntityException ex)
            {
                _log.Fatal("Database unavailable when retrieving random words.", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.DatabaseError, Lang.Error_DatabaseConnectionError),
                    new FaultReason("Database Unavailable"));
            }
            catch (Exception ex)
            {
                _log.Error("Critical error retrieving random words.", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_GameWordsFailed),
                    new FaultReason("Server Error"));
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
                _log.Error($"Error submitting drawing for '{username}' in match '{matchId}'", ex);
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
                _log.Error($"Error processing guess from '{username}' in match '{matchId}'", ex);
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
                _log.Warn($"Error sending in-game chat message from '{username}' in match '{matchId}'", ex);
            }
        }
    }
}
