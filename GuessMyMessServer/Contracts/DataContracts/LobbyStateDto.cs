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
        public string lobbyId { get; set; }

        [DataMember]
        public string hostUsername { get; set; }

        [DataMember]
        public List<string> players { get; set; } // Lista de usernames

        [DataMember]
        public LobbySettingsDto currentSettings { get; set; }
    }
}
