using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;

namespace GuessMyMessServer.Contracts.ServiceContracts
{
    [ServiceContract(CallbackContract = typeof(IMatchmakingServiceCallback))] // [cite: 719]
    public interface IMatchmakingService
    {
        [OperationContract] // GetPublicMatches [cite: 721]
        List<MatchInfoDto> getPublicMatches();

        [OperationContract] // CreateMatch [cite: 723]
        OperationResultDto createMatch(string hostUsername, LobbySettingsDto settings);

        [OperationContract(IsOneWay = true)] // JoinPublicMatch [cite: 724]
        void joinPublicMatch(string username, string matchId);

        [OperationContract] // JoinPrivateMatch [cite: 725]
        OperationResultDto joinPrivateMatch(string username, string matchCode);

        // Operación para el host que invita a un amigo
        [OperationContract(IsOneWay = true)]
        void inviteToMatch(string inviterUsername, string invitedUsername, string matchId);
    }

    [ServiceContract]
    public interface IMatchmakingServiceCallback
    {
        [OperationContract(IsOneWay = true)]
        void receiveMatchInvite(string fromUsername, string matchId);

        [OperationContract(IsOneWay = true)]
        void matchUpdate(MatchInfoDto matchInfo); // Actualiza la lista de partidas

        [OperationContract(IsOneWay = true)]
        void matchJoined(string matchId); // Indica que el cliente debe pasar a la vista de Lobby

        [OperationContract(IsOneWay = true)]
        void matchmakingFailed(string reason);
    }
}
