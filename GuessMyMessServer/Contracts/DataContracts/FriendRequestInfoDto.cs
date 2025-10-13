using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class FriendRequestInfoDto
    {

        [DataMember]
        public string requesterUsername { get; set; }

        [DataMember]
        public DateTime requestDate { get; set; }
    }
}
