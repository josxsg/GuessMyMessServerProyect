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
        public string senderUsername { get; set; }

        [DataMember]
        public string content { get; set; }

        [DataMember]
        public DateTime timestamp { get; set; }

        // Indica si el mensaje es de chat preestablecido (lobby) o escrito (in-game)
        [DataMember]
        public bool isPredefined { get; set; }
    }
}
