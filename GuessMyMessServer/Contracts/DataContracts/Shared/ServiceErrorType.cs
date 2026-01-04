using System.Runtime.Serialization;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract(Name = "ServiceErrorType")]
    public enum ServiceErrorType
    {
        [EnumMember] None = 0, 
        [EnumMember] Unknown = 1,
        [EnumMember] DatabaseError = 2,
        [EnumMember] OperationFailed = 3,
        [EnumMember] ConnectionTimeout = 4,
        [EnumMember] InvalidCredentials = 10,
        [EnumMember] UserAlreadyExists = 11,
        [EnumMember] EmailAlreadyRegistered = 12,
        [EnumMember] AccountNotVerified = 13,
        [EnumMember] InvalidEmailFormat = 14,
        [EnumMember] InvalidPasswordFormat = 15,
        [EnumMember] LobbyFull = 20,
        [EnumMember] MatchNotFound = 21,
        [EnumMember] GameInProgress = 22,
        [EnumMember] PlayerBanned = 23,
        [EnumMember] NotFound = 24,
        [EnumMember] DuplicateRecord = 25,
        [EnumMember] MaxLobbiesCreated = 26,
        [EnumMember] UserNotConnected = 27
    }
}