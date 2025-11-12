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
        public string MatchId { get; set; }

        [DataMember]
        public string MatchCode { get; set; }

        [DataMember]
        public string MatchName { get; set; }

        [DataMember]
        public string HostUsername { get; set; }

        [DataMember]
        public int CurrentPlayers { get; set; }

        [DataMember]
        public int MaxPlayers { get; set; }

        [DataMember]
        public string DifficultyName { get; set; }

        [DataMember]
        public bool IsPrivate { get; set; }
    }
}
