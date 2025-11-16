using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class GuessDto
    {
        [DataMember]
        public string GuesserUsername { get; set; }

        [DataMember]
        public string GuessText { get; set; }

        [DataMember]
        public bool IsCorrect { get; set; }

        [DataMember]
        public int DrawingId { get; set; }

        [DataMember]
        public string WordKey { get; set; }
    }
}
