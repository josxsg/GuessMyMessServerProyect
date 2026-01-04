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
        public bool Success { get; set; }

        [DataMember]
        public string Message { get; set; }

        [DataMember]
        public ServiceErrorType ErrorCode { get; set; } 

        [DataMember]
        public Dictionary<string, string> Data { get; set; }

        public OperationResultDto()
        {
            Success = false;
            ErrorCode = ServiceErrorType.Unknown;
            Data = new Dictionary<string, string>();
        }
    }
}
