using System.Runtime.Serialization;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class WordDto
    {
        [DataMember]
        public int WordId { get; set; }

        [DataMember]
        public string WordKey { get; set; }
    }
}