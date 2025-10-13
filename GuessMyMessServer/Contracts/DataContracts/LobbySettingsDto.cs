using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class LobbySettingsDto
    {
        [DataMember]
        public string matchName { get; set; }

        [DataMember]
        public int maxPlayers { get; set; } 

        [DataMember]
        public int rounds { get; set; } 

        [DataMember]
        public int difficultyId { get; set; }

        [DataMember]
        public bool isPrivate { get; set; }
    }
}
