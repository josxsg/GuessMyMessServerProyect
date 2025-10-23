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
        void selectWord(string username, string matchId, string selectedWord);

        [OperationContract(IsOneWay = true)] 
        void submitDrawing(string username, string matchId, byte[] drawingData);

        [OperationContract(IsOneWay = true)] 
        void submitGuess(string username, string matchId, string guess);

        [OperationContract(IsOneWay = true)] 
        void sendInGameChatMessage(string username, string matchId, string message);
    }

    [ServiceContract]
    public interface IGameServiceCallback
    {
        [OperationContract(IsOneWay = true)] 
        void onRoundStart(int roundNumber, List<string> wordOptions);

        [OperationContract(IsOneWay = true)]
        void onDrawingPhaseStart(int durationSeconds);

        [OperationContract(IsOneWay = true)] 
        void onGuessingPhaseStart(byte[] drawingData, string artistUsername);

        [OperationContract(IsOneWay = true)] 
        void onPlayerGuessedCorrectly(string username);

        [OperationContract(IsOneWay = true)] 
        void onTimeUpdate(int remainingSeconds);

        [OperationContract(IsOneWay = true)] 
        void onRoundEnd(List<PlayerScoreDto> roundScores, string correctWord);

        [OperationContract(IsOneWay = true)] 
        void onGameEnd(List<PlayerScoreDto> finalScores);
    }
}
