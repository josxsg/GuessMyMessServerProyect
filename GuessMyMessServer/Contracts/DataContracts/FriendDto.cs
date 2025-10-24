using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class FriendDto
    {
        [DataMember]
        public string Username { get; set; }

        [DataMember]
        public bool IsOnline { get; set; }
    }

}
