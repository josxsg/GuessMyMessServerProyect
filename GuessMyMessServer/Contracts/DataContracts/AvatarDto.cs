using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class AvatarDto
    {
        [DataMember]
        public int IdAvatar { get; set; }

        [DataMember]
        public string AvatarName { get; set; } 

        [DataMember]
        public byte[] AvatarData { get; set; } 
    }
}
