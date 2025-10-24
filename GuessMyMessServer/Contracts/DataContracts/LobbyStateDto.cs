using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class LobbyStateDto
    {
        [DataMember]
        public string LobbyId { get; set; }

        [DataMember]
        public string HostUsername { get; set; }

        [DataMember]
        public List<string> Players { get; set; } 

        [DataMember]
        public LobbySettingsDto CurrentSettings { get; set; }
    }
}
