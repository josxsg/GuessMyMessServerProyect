using System;
using System.Runtime.Serialization; 

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract] 
    public class DirectMessageDto
    {
        [DataMember] 
        public string senderUsername { get; set; }

        [DataMember]
        public string recipientUsername { get; set; }

        [DataMember] 
        public string content { get; set; }

        [DataMember] 
        public DateTime timestamp { get; set; }

        
    }
}