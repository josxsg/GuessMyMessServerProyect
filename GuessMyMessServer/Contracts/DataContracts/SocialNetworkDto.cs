using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class SocialNetworkDto
    {
        [DataMember]
        public string networkType { get; set; } // Ejemplo: "Instagram", "Discord", "X"

        [DataMember]
        public string userLink { get; set; } // El handle o enlace del usuario
    }
}
