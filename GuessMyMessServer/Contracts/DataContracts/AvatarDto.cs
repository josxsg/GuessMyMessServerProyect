using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Contracts.DataContracts
{
    [DataContract]
    public class AvatarDto
    {
        [DataMember]
        public int idAvatar { get; set; }

        [DataMember]
        public string avatarName { get; set; } // Nombre legible del avatar

        [DataMember]
        public byte[] avatarData { get; set; } // Datos binarios de la imagen
    }
}
