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
        [OperationContract(IsOneWay = true)]
        void Connect(string username);

        [OperationContract(IsOneWay = true)]
        void Disconnect(string username);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        List<MatchInfoDto> GetPublicMatches();

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        OperationResultDto CreateMatch(string hostUsername, LobbySettingsDto settings);

        [OperationContract(IsOneWay = true)]
        void JoinPublicMatch(string username, string matchId);

        [OperationContract]
        [FaultContract(typeof(ServiceFaultDto))]
        OperationResultDto JoinPrivateMatch(string username, string matchCode);

        [OperationContract(IsOneWay = true)]
        void InviteToMatch(string inviterUsername, string invitedUsername, string matchId);
    }

    [ServiceContract]
    public interface IMatchmakingServiceCallback
    {
        [OperationContract(IsOneWay = true)]
        void ReceiveMatchInvite(string fromUsername, string matchId);

        [OperationContract(IsOneWay = true)]
        void MatchUpdate(MatchInfoDto matchInfo);

        [OperationContract(IsOneWay = true)]
        void MatchJoined(string matchId, OperationResultDto result); 

        [OperationContract(IsOneWay = true)]
        void MatchmakingFailed(string reason);

        [OperationContract(IsOneWay = true)]
        void PublicMatchesListUpdated(List<MatchInfoDto> publicMatches);
    }
}