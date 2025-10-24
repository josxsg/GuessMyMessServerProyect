using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class PlayerScoreDto
    {
        [DataMember]
        public string Username { get; set; }

        [DataMember]
        public int Score { get; set; }

        [DataMember]
        public int? Rank { get; set; } 
    }
}
