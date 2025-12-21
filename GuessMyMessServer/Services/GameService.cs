using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;
using Autofac;
using GuessMyMessServer.AppStart;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.Properties.Langs;
using log4net;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Reentrant)]
    public class GameService : IGameService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(GameService));
        private readonly IGameServiceCallback _callback;

        // Variables de sesión
        private string _connectedUsername;
        private string _connectedMatchId;

        // Propiedad para resolver la lógica bajo demanda
        private GameLogic Logic => Bootstrapper.Container.Resolve<GameLogic>();

        // Constructor WCF (Predeterminado)
        public GameService()
        {
            Bootstrapper.Init();
            _callback = OperationContext.Current.GetCallbackChannel<IGameServiceCallback>();
            SubscribeToChannelEvents();
        }

        private void SubscribeToChannelEvents()
        {
            IContextChannel channel = OperationContext.Current.Channel;
            channel.Faulted += Channel_FaultedOrClosed;
            channel.Closed += Channel_FaultedOrClosed;
        }

        public void Connect(string username, string matchId)
        {
            try
            {
                _connectedUsername = username;
                _connectedMatchId = matchId;
                // Usamos la propiedad Logic
                Logic.ConnectPlayer(username, matchId, _callback);
            }
            catch (Exception ex) { _log.Error($"Error connecting player", ex); }
        }

        public void Disconnect(string username, string matchId)
        {
            if (ValidateSession(username)) PerformDisconnect();
        }

        public void SelectWord(string username, string matchId, string selectedWord)
        {
            if (ValidateSession(username))
                Logic.RegisterSelectedWord(username, matchId, selectedWord);
        }

        public async Task<List<WordDto>> GetRandomWordsAsync()
        {
            try
            {
                return await Logic.GetRandomWordsAsync();
            }
            catch (Exception ex)
            {
                _log.Error("Error retrieving words.", ex);
                throw new FaultException<ServiceFaultDto>(new ServiceFaultDto(ServiceErrorType.DatabaseError, Lang.Error_GameWordsFailed));
            }
        }

        public void SubmitDrawing(string username, string matchId, byte[] drawingData)
        {
            if (ValidateSession(username))
                Logic.AddDrawing(username, matchId, drawingData);
        }

        public void SubmitGuess(string username, string matchId, int drawingId, string guess)
        {
            if (ValidateSession(username))
                Logic.ProcessGuess(username, matchId, drawingId, guess);
        }

        public void SendInGameChatMessage(string username, string matchId, string message)
        {
            if (ValidateSession(username))
                Logic.BroadcastChatMessage(username, matchId, message);
        }

        public async void StartGame(string matchId, int totalRounds, List<string> playerUsernames)
        {
            try
            {
                await Logic.StartGameAsync(matchId, totalRounds, playerUsernames);
            }
            catch (Exception ex) { _log.Error($"Error starting game", ex); }
        }

        private bool ValidateSession(string username) => _connectedUsername == username;

        private void PerformDisconnect()
        {
            if (!string.IsNullOrEmpty(_connectedUsername))
            {
                // Usamos Logic para desconectar
                Logic.DisconnectPlayer(_connectedUsername, _connectedMatchId);
                _connectedUsername = null;
            }
        }

        private void Channel_FaultedOrClosed(object sender, EventArgs e)
        {
            PerformDisconnect();
        }
    }
}