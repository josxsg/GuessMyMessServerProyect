using System;
using System.Collections.Generic;
using System.Data.Entity.Core;
using System.ServiceModel;
using System.Threading.Tasks;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.Contracts.ServiceContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Properties;
using GuessMyMessServer.Properties.Langs;
using GuessMyMessServer.Utilities.Email;
using log4net;

namespace GuessMyMessServer.Services
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class UserProfileService : IUserProfileService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(UserProfileService));

        public UserProfileService()
        {
        }

        public async Task<UserProfileDto> GetUserProfileAsync(string username)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.GetUserProfileAsync(username);
                }
            }
            catch (InvalidOperationException ex)
            {
                _log.Warn($"GetUserProfileAsync: User '{username}' not found.");
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.NotFound, Lang.Error_UserNotFound),
                    new FaultReason(Lang.Error_UserNotFound));
            }
            catch (Exception ex)
            {
                _log.Error($"Error getting user profile for '{username}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_ServerGeneric),
                    new FaultReason("Server Error"));
            }
        }

        public async Task<OperationResultDto> UpdateProfileAsync(string username, UserProfileDto profileData)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.UpdateProfileAsync(username, profileData);
                }
            }
            catch (ArgumentNullException ex)
            {
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.OperationFailed, Lang.Error_FieldsRequired),
                    new FaultReason("Validation Error"));
            }
            catch (InvalidOperationException ex)
            {
                _log.Warn($"UpdateProfileAsync failed for '{username}': {ex.Message}");
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.NotFound, Lang.Error_UserNotFound),
                    new FaultReason("User Not Found"));
            }
            catch (Exception ex)
            {
                _log.Error($"Error updating profile for '{username}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_ServerGeneric),
                    new FaultReason("Server Error"));
            }
        }

        public async Task<OperationResultDto> RequestChangeEmailAsync(string username, string newEmail)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.RequestChangeEmailAsync(username, newEmail);
                }
            }
            catch (ArgumentException ex)
            {
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.OperationFailed, Lang.Error_EmailFormat),
                    new FaultReason("Invalid Email"));
            }
            catch (InvalidOperationException ex)
            {
                ServiceErrorType errorType = ServiceErrorType.OperationFailed;
                string message = ex.Message;

                if (ex.Message.Contains("registered"))
                {
                    errorType = ServiceErrorType.EmailAlreadyRegistered;
                    message = Lang.Error_EmailAlreadyRegistered;
                }
                else
                {
                    errorType = ServiceErrorType.NotFound;
                    message = Lang.Error_UserNotFound;
                }

                _log.Info($"RequestChangeEmail denied for '{username}': {ex.Message}");

                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(errorType, message),
                    new FaultReason(message));
            }
            catch (Exception ex)
            {
                _log.Error($"Error requesting email change for '{username}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_EmailSendFailed),
                    new FaultReason("Server Error"));
            }
        }

        public async Task<OperationResultDto> ConfirmChangeEmailAsync(string username, string verificationCode)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.ConfirmChangeEmailAsync(username, verificationCode);
                }
            }
            catch (InvalidOperationException ex)
            {
                string message = Lang.Error_InvalidOrExpiredCode;
                if (ex.Message.Contains("taken") || ex.Message.Contains("registered"))
                {
                    message = Lang.Error_EmailAlreadyRegistered;
                }

                _log.Info($"ConfirmChangeEmail failed for '{username}': {ex.Message}");

                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.OperationFailed, message),
                    new FaultReason("Operation Failed"));
            }
            catch (Exception ex)
            {
                _log.Error($"Error confirming email change for '{username}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_ServerGeneric),
                    new FaultReason("Server Error"));
            }
        }

        public async Task<OperationResultDto> RequestChangePasswordAsync(string username)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.RequestChangePasswordAsync(username);
                }
            }
            catch (InvalidOperationException ex)
            {
                _log.Warn($"RequestChangePassword failed: {ex.Message}");
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.NotFound, Lang.Error_UserNotFound),
                    new FaultReason("User Not Found"));
            }
            catch (Exception ex)
            {
                _log.Error($"Error requesting password change for '{username}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_EmailSendFailed),
                    new FaultReason("Server Error"));
            }
        }

        public async Task<OperationResultDto> ConfirmChangePasswordAsync(string username, string newPassword, string verificationCode)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.ConfirmChangePasswordAsync(username, newPassword, verificationCode);
                }
            }
            catch (ArgumentException ex)
            {
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.OperationFailed, Lang.Error_PasswordInsecure),
                    new FaultReason("Validation Error"));
            }
            catch (InvalidOperationException ex)
            {
                string message = Lang.Error_InvalidOrExpiredCode;
                if (ex.Message.Contains("found"))
                {
                    message = Lang.Error_UserNotFound;
                }

                _log.Info($"ConfirmChangePassword failed for '{username}': {ex.Message}");

                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.OperationFailed, message),
                    new FaultReason("Operation Failed"));
            }
            catch (Exception ex)
            {
                _log.Error($"Error confirming password change for '{username}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_ServerGeneric),
                    new FaultReason("Server Error"));
            }
        }

        public async Task<List<AvatarDto>> GetAvailableAvatarsAsync()
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new UserProfileLogic(emailService, context);
                    return await logic.GetAvailableAvatarsAsync();
                }
            }
            catch (Exception ex)
            {
                _log.Error("Error getting available avatars.", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_ServerGeneric),
                    new FaultReason("Server Error"));
            }
        }
    }
}
