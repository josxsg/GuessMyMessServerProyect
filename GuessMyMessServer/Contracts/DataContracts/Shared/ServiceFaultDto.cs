using System.Runtime.Serialization;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class ServiceFaultDto
    {
        [DataMember]
        public ServiceErrorType ErrorType { get; set; }

        [DataMember]
        public string Message { get; set; } 

        [DataMember]
        public string Target { get; set; }  

        public ServiceFaultDto(ServiceErrorType type, string debugMessage, string target = null)
        {
            ErrorType = type;
            Message = debugMessage;
            Target = target;
        }
    }
}