using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class OperationResultDto
    {
        [DataMember]
        public bool success { get; set; }

        [DataMember]
        public string message { get; set; }
    }
}
