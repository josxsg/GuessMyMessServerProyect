using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;

namespace GuessMyMessServer.Contracts.ServiceContracts
{
    [ServiceContract(CallbackContract = typeof(IMatchmakingServiceCallback))] 
    public interface IMatchmakingService
    {
        [OperationContract] 
        List<MatchInfoDto> getPublicMatches();

        [OperationContract]
        OperationResultDto createMatch(string hostUsername, LobbySettingsDto settings);

        [OperationContract(IsOneWay = true)] 
        void joinPublicMatch(string username, string matchId);

        [OperationContract] 
        OperationResultDto joinPrivateMatch(string username, string matchCode);

        [OperationContract(IsOneWay = true)]
        void inviteToMatch(string inviterUsername, string invitedUsername, string matchId);
    }

    [ServiceContract]
    public interface IMatchmakingServiceCallback
    {
        [OperationContract(IsOneWay = true)]
        void receiveMatchInvite(string fromUsername, string matchId);

        [OperationContract(IsOneWay = true)]
        void matchUpdate(MatchInfoDto matchInfo); 

        [OperationContract(IsOneWay = true)]
        void matchJoined(string matchId); 

        [OperationContract(IsOneWay = true)]
        void matchmakingFailed(string reason);
    }
}
