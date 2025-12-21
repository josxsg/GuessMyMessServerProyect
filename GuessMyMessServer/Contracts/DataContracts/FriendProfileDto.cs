using System.Collections.Generic;
using System.Runtime.Serialization;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class FriendProfileDto
    {
        [DataMember]
        public string FirstName { get; set; }

        [DataMember]
        public string LastName { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public int GenderId { get; set; }

        [DataMember]
        public List<SocialNetworkDto> SocialNetworks { get; set; }
    }
}