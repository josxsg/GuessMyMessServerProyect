using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;

namespace GuessMyMessServer.Services
{
    // PerSession para mantener la conexión Dúplex (callback) activa
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession)]
    public class SocialService : ISocialService
    {
        private ISocialServiceCallback callback;

        public SocialService()
        {
            callback = OperationContext.Current.GetCallbackChannel<ISocialServiceCallback>();
        }

        public List<FriendDto> getFriendsList(string username)
        {
            throw new NotImplementedException();
        }

        public List<FriendRequestInfoDto> getFriendRequests(string username)
        {
            throw new NotImplementedException();
        }

        public List<UserProfileDto> searchUsers(string searchUsername)
        {
            throw new NotImplementedException();
        }

        public void sendFriendRequest(string requesterUsername, string targetUsername)
        {
            // Lógica para enviar solicitud y notificar al target (usando el callback)
            throw new NotImplementedException();
        }

        public void respondToFriendRequest(string targetUsername, string requesterUsername, bool accepted)
        {
            // Lógica para aceptar/rechazar y notificar a ambos jugadores (usando el callback)
            throw new NotImplementedException();
        }

        public void removeFriend(string username, string friendToRemove)
        {
            throw new NotImplementedException();
        }

        public OperationResultDto inviteFriendToGameByEmail(string fromUsername, string friendEmail, string matchCode)
        {
            // Lógica para enviar invitación por correo
            throw new NotImplementedException();
        }
    }
}
