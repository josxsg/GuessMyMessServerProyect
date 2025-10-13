using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class UserProfileDto
    {
        [DataMember]
        public string username { get; set; }

        [DataMember]
        public string firstName { get; set; }

        [DataMember]
        public string lastName { get; set; }

        [DataMember]
        public string email { get; set; }

        [DataMember]
        public int genderId { get; set; }

        [DataMember]
        public int avatarId { get; set; }

        [DataMember]
        public DateTime? dateOfBirth { get; set; }

        [DataMember]
        public List<SocialNetworkDto> socialNetworks { get; set; } 

    }
}
