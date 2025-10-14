﻿using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities.Email;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class AuthenticationService : IAuthenticationService
    {
        private readonly AuthenticationLogic authenticationLogic;

        public AuthenticationService()
        {
            authenticationLogic = new AuthenticationLogic(new SmtpEmailService());
        }

        public OperationResultDto Login(string emailOrUsername, string password)
        {
            try
            {
                return authenticationLogic.login(emailOrUsername, password);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error de Login: {ex}");
                return new OperationResultDto { success = false, message = "Error inesperado del servidor." };
            }
        }

        public OperationResultDto Register(UserProfileDto userProfile, string password)
        {
            try
            {
                return authenticationLogic.registerPlayerAsync(userProfile, password).Result;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error de Registro: {ex}");
                return new OperationResultDto { success = false, message = "Error inesperado del servidor durante el registro." };
            }
        }

        public OperationResultDto VerifyAccount(string email, string code)
        {
            try
            {
                return authenticationLogic.verifyAccount(email, code);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error de Verificación: {ex}");
                return new OperationResultDto { success = false, message = "Error inesperado del servidor durante la verificación." };
            }
        }

        public void LogOut(string username)
        {
            try
            {
                authenticationLogic.logOut(username);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error de LogOut: {ex}");
            }
        }

        public OperationResultDto LoginAsGuest(string username, string avatarPath) { throw new NotImplementedException(); }
        public OperationResultDto SendPasswordRecoveryCode(string email) { throw new NotImplementedException(); }
        public OperationResultDto ResetPasswordWithCode(string email, string code, string newPassword) { throw new NotImplementedException(); }
    }
}
