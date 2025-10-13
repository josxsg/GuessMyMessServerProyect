using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Utilities.Email
{
    public interface IEmailTemplate
    {
        string subject { get; }
        string htmlBody { get; }
    }
}
