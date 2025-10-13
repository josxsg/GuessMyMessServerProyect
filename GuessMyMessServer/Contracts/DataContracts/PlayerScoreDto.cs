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
        public string username { get; set; }

        [DataMember]
        public int score { get; set; }

        [DataMember]
        public int? rank { get; set; } // Posición final
    }
}
