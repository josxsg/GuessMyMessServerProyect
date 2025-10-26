using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.Utilities.Email;
using GuessMyMessServer.DataAccess; // <-- 1. Añadir using de DataAccess

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class UserProfileService : IUserProfileService
    {
        // --- CAMBIO 2: Constructor vacío y sin campos ---
        public UserProfileService()
        {
        }

        public async Task<UserProfileDto> GetUserProfileAsync(string username)
        {
            try
            {
                // --- CAMBIO 3: Crear dependencias en el método ---
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.GetUserProfileAsync(username);
                }
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message); // <-- Mensaje de excepción directo
            }
        }

        public async Task<OperationResultDto> UpdateProfileAsync(string username, UserProfileDto profileData)
        {
            try
            {
                // --- CAMBIO 3: Crear dependencias en el método ---
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.UpdateProfileAsync(username, profileData);
                }
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<OperationResultDto> RequestChangeEmailAsync(string username, string newEmail)
        {
            try
            {
                // --- CAMBIO 3: Crear dependencias en el método ---
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.RequestChangeEmailAsync(username, newEmail);
                }
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<OperationResultDto> ConfirmChangeEmailAsync(string username, string verificationCode)
        {
            try
            {
                // --- CAMBIO 3: Crear dependencias en el método ---
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.ConfirmChangeEmailAsync(username, verificationCode);
                }
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<OperationResultDto> RequestChangePasswordAsync(string username)
        {
            try
            {
                // --- CAMBIO 3: Crear dependencias en el método ---
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.RequestChangePasswordAsync(username);
                }
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<OperationResultDto> ConfirmChangePasswordAsync(string username, string newPassword, string verificationCode)
        {
            try
            {
                // --- CAMBIO 3: Crear dependencias en el método ---
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.ConfirmChangePasswordAsync(username, newPassword, verificationCode);
                }
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }

        public async Task<List<AvatarDto>> GetAvailableAvatarsAsync()
        {
            try
            {
                // --- CAMBIO 3: Crear dependencias en el método ---
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.GetAvailableAvatarsAsync();
                }
            }
            catch (Exception ex)
            {
                throw new FaultException(ex.Message);
            }
        }
    }
}