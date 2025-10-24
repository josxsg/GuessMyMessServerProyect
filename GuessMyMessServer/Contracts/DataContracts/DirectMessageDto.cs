using System;
using System.Runtime.Serialization; 

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract] 
    public class DirectMessageDto
    {
        [DataMember] 
        public string SenderUsername { get; set; }

        [DataMember]
        public string RecipientUsername { get; set; }

        [DataMember] 
        public string Content { get; set; }

        [DataMember] 
        public DateTime Timestamp { get; set; }

        
    }
}