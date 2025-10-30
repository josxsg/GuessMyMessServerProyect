using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class ChatMessageDto
    {
        [DataMember]
        public string SenderUsername { get; set; }

        [DataMember]
        public string MessageContent { get; set; } 

        [DataMember]
        public DateTime Timestamp { get; set; } 
    }
}