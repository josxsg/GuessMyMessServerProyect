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
        [DataMember] public string Username { get; set; }

        [DataMember] public string FirstName { get; set; }

        [DataMember] public string LastName { get; set; }

        [DataMember] public string Email { get; set; }

        [DataMember]
        public int GenderId { get; set; }

        [DataMember]
        public int AvatarId { get; set; }

        [DataMember]
        public List<SocialNetworkDto> socialNetworks { get; set; } 

    }
}
