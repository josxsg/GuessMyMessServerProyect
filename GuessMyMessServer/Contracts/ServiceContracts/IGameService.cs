using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;

namespace GuessMyMessServer.Contracts.ServiceContracts
{
    [ServiceContract(CallbackContract = typeof(IGameServiceCallback))] 
    public interface IGameService
    {
        [OperationContract(IsOneWay = true)]
        void Connect(string username, string matchId);

        [OperationContract(IsOneWay = true)]
        void Disconnect(string username, string matchId);

        [OperationContract(IsOneWay = true)] 
        void SelectWord(string username, string matchId, string selectedWord);

        [OperationContract]
        Task<List<WordDto>> GetRandomWordsAsync();

        [OperationContract(IsOneWay = true)] 
        void SubmitDrawing(string username, string matchId, byte[] drawingData);

        [OperationContract(IsOneWay = true)] 
        void SubmitGuess(string username, string matchId, int drawingId, string guess);

        [OperationContract(IsOneWay = true)] 
        void SendInGameChatMessage(string username, string matchId, string message);
    }

    [ServiceContract]
    public interface IGameServiceCallback
    {
        [OperationContract(IsOneWay = true)] 
        void OnRoundStart(int roundNumber, List<string> wordOptions);

        [OperationContract(IsOneWay = true)]
        void OnDrawingPhaseStart(int durationSeconds);

        [OperationContract(IsOneWay = true)]
        void OnGuessingPhaseStart(DrawingDto drawing);

        [OperationContract(IsOneWay = true)]
        void OnInGameMessageReceived(string sender, string message);

        [OperationContract(IsOneWay = true)]
        void OnAnswersPhaseStart(DrawingDto[] allDrawings, GuessDto[] allGuesses, PlayerScoreDto[] currentScores);

        [OperationContract(IsOneWay = true)]
        void OnShowNextDrawing(DrawingDto nextDrawing);

        [OperationContract(IsOneWay = true)]
        void OnGameEnd(List<PlayerScoreDto> finalScores);
    }
}
