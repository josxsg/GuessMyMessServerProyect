using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class MatchInfoDto
    {
        [DataMember]
        public string matchId { get; set; }

        [DataMember]
        public string matchName { get; set; }

        [DataMember]
        public string hostUsername { get; set; }

        [DataMember]
        public int currentPlayers { get; set; }

        [DataMember]
        public int maxPlayers { get; set; }

        [DataMember]
        public string difficultyName { get; set; }
    }
}
