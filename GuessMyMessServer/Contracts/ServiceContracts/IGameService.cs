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
        void SelectWord(string username, string matchId, string selectedWord);

        [OperationContract(IsOneWay = true)] 
        void SubmitDrawing(string username, string matchId, byte[] drawingData);

        [OperationContract(IsOneWay = true)] 
        void SubmitGuess(string username, string matchId, string guess);

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
        void OnGuessingPhaseStart(byte[] drawingData, string artistUsername);

        [OperationContract(IsOneWay = true)] 
        void OnPlayerGuessedCorrectly(string username);

        [OperationContract(IsOneWay = true)] 
        void OnTimeUpdate(int remainingSeconds);

        [OperationContract(IsOneWay = true)] 
        void OnRoundEnd(List<PlayerScoreDto> roundScores, string correctWord);

        [OperationContract(IsOneWay = true)] 
        void OnGameEnd(List<PlayerScoreDto> finalScores);
    }
}
