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
        public string networkType { get; set; } 

        [DataMember]
        public string userLink { get; set; } 
    }
}
