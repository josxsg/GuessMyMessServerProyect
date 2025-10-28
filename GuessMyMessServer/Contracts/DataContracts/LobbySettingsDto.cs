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
        public string MatchName { get; set; }

        [DataMember]
        public int MaxPlayers { get; set; } 

        [DataMember]
        public int TotalRounds { get; set; } 

        [DataMember]
        public int DifficultyId { get; set; }

        [DataMember]
        public bool IsPrivate { get; set; }
    }
}
