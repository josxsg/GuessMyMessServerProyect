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
        public string username { get; set; }

        [DataMember]
        // isOnline representa el estado actual (en línea, en partida, desconectado)
        // Podrías cambiar a un enum para estados más detallados si es necesario.
        public bool isOnline { get; set; }
    }

}
