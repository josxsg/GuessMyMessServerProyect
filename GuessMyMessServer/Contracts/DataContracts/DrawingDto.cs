using System.Runtime.Serialization;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class DrawingDto
    {
        [DataMember]
        public int DrawingId { get; set; } 

        [DataMember]
        public byte[] DrawingData { get; set; }

        [DataMember]
        public string OwnerUsername { get; set; } 

        [DataMember]
        public bool IsGuessed { get; set; }

        [DataMember]
        public string WordKey { get; set; } 
    }
}