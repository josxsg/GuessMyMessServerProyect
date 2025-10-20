using System;
using System.Runtime.Serialization; // Necesario para [DataContract] y [DataMember]

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract] // Indica que esta clase se puede enviar/recibir por WCF
    public class DirectMessageDto
    {
        [DataMember] // Incluir el nombre del remitente
        public string senderUsername { get; set; }

        [DataMember] // Incluir el nombre del destinatario
        public string recipientUsername { get; set; }

        [DataMember] // Incluir el contenido del mensaje
        public string content { get; set; }

        [DataMember] // Incluir la fecha y hora del mensaje
        public DateTime timestamp { get; set; }

        
    }
}