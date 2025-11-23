using System;
using System.Collections.Concurrent;
using System.Linq;

namespace GuessMyMessServer.BusinessLogic
{
    public class GuestInvite
    {
        public string Email { get; set; }
        public string Code { get; set; }
        public string MatchId { get; set; }
        public DateTime Expiration { get; set; }
    }

    public static class GuestInviteManager
    {
        private static readonly ConcurrentDictionary<string, GuestInvite> _invites = new ConcurrentDictionary<string, GuestInvite>();

        public static string CreateInvite(string email, string matchId)
        {
            var code = new Random().Next(100000, 999999).ToString();
            var invite = new GuestInvite
            {
                Email = email,
                Code = code,
                MatchId = matchId,
                Expiration = DateTime.UtcNow.AddMinutes(15)
            };

            _invites.AddOrUpdate(email, invite, (k, v) => invite);
            return code;
        }

        public static bool ValidateInvite(string email, string code, out string matchId)
        {
            matchId = null;
            if (_invites.TryGetValue(email, out var invite))
            {
                if (invite.Code == code && invite.Expiration > DateTime.UtcNow)
                {
                    matchId = invite.MatchId;
                    _invites.TryRemove(email, out _);
                    return true;
                }
            }
            return false;
        }
    }
}