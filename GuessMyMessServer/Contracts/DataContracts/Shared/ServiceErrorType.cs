using System.Runtime.Serialization;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract(Name = "ServiceErrorType")]
    public enum ServiceErrorType
    {
        [EnumMember] Unknown = 0,
        [EnumMember] DatabaseError = 1,
        [EnumMember] OperationFailed = 2, 
        [EnumMember] ConnectionTimeout = 3,
        [EnumMember] InvalidCredentials = 10,
        [EnumMember] UserAlreadyExists = 11,
        [EnumMember] EmailAlreadyRegistered = 12,
        [EnumMember] AccountNotVerified = 13,
        [EnumMember] LobbyFull = 20,
        [EnumMember] MatchNotFound = 21,
        [EnumMember] GameInProgress = 22,
        [EnumMember] PlayerBanned = 23,
        [EnumMember] NotFound = 24,
        [EnumMember] DuplicateRecord = 25
    }
}