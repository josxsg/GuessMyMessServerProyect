using System.Runtime.Serialization;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class DrawingDto
    {
        [DataMember]
        public int DrawingId { get; set; } // ID temporal solo para la partida

        [DataMember]
        public byte[] DrawingData { get; set; }

        [DataMember]
        public string OwnerUsername { get; set; } // Funciona para registrados e invitados

        [DataMember]
        public bool IsGuessed { get; set; }

        [DataMember]
        public string WordKey { get; set; } // La palabra que dibujaron
    }
}