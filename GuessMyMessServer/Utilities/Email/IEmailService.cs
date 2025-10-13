﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Utilities.Email
{
    public interface IEmailService
    {
        Task sendEmailAsync(string recipientEmail, string recipientName, IEmailTemplate template);

    }
}
