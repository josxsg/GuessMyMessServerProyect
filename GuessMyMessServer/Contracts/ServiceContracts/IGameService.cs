using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;

namespace GuessMyMessServer.Contracts.ServiceContracts
{
    [ServiceContract(CallbackContract = typeof(IGameServiceCallback))] // [cite: 738]
    public interface IGameService
    {
        [OperationContract(IsOneWay = true)] // SelectWord [cite: 740]
        void selectWord(string username, string matchId, string selectedWord);

        [OperationContract(IsOneWay = true)] // SubmitDrawing [cite: 741]
        void submitDrawing(string username, string matchId, byte[] drawingData);

        [OperationContract(IsOneWay = true)] // SubmitGuess [cite: 742]
        void submitGuess(string username, string matchId, string guess);

        [OperationContract(IsOneWay = true)] // SendInGameChatMessage [cite: 743]
        void sendInGameChatMessage(string username, string matchId, string message);
    }

    [ServiceContract]
    public interface IGameServiceCallback
    {
        [OperationContract(IsOneWay = true)] // OnRoundStart [cite: 745]
        void onRoundStart(int roundNumber, List<string> wordOptions);

        [OperationContract(IsOneWay = true)] // OnDrawingPhaseStart [cite: 746]
        void onDrawingPhaseStart(int durationSeconds);

        [OperationContract(IsOneWay = true)] // OnGuessing PhaseStart [cite: 747]
        void onGuessingPhaseStart(byte[] drawingData, string artistUsername);

        [OperationContract(IsOneWay = true)] // OnPlayerGuessedCorrectly [cite: 748]
        void onPlayerGuessedCorrectly(string username);

        [OperationContract(IsOneWay = true)] // OnTimeUpdate [cite: 751]
        void onTimeUpdate(int remainingSeconds);

        [OperationContract(IsOneWay = true)] // OnRoundEnd [cite: 752]
        void onRoundEnd(List<PlayerScoreDto> roundScores, string correctWord);

        [OperationContract(IsOneWay = true)] // OnGameEnd [cite: 753]
        void onGameEnd(List<PlayerScoreDto> finalScores);
    }
}
