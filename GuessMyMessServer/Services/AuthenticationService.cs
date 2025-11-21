using System;
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
    public class AuthenticationService : IAuthenticationService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(AuthenticationService));

        public async Task<OperationResultDto> LoginAsync(string emailOrUsername, string password)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new AuthenticationLogic(emailService, context);

                    _log.Info($"Login attempt for: {emailOrUsername}");
                    return await logic.LoginAsync(emailOrUsername, password);
                }
            }
            catch (InvalidOperationException ex)
            {
                ServiceErrorType errorType = ServiceErrorType.OperationFailed;
                string userMessage = Lang.Error_InvalidCredentials;

                if (ex.Message.Contains("verified"))
                {
                    errorType = ServiceErrorType.AccountNotVerified;
                    userMessage = Lang.Error_AccountNotVerified;
                }
                else if (ex.Message.Contains("credentials"))
                {
                    errorType = ServiceErrorType.InvalidCredentials;
                    userMessage = Lang.Error_InvalidCredentials;
                }

                _log.Info($"Login logic rejection for '{emailOrUsername}': {ex.Message}");

                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(errorType, userMessage),
                    new FaultReason(userMessage));
            }
            catch (ArgumentException ex)
            {
                _log.Info($"Login validation failed: {ex.Message}");
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.OperationFailed, Lang.Error_FieldsRequired),
                    new FaultReason("Validation Error"));
            }
            catch (EntityException ex)
            {
                _log.Fatal($"Database unavailable during login for '{emailOrUsername}'", ex);

                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.DatabaseError, Lang.Error_DatabaseConnectionError),
                    new FaultReason("Database Unavailable"));
            }
            catch (TimeoutException ex)
            {
                _log.Error($"Timeout during login for '{emailOrUsername}'", ex);

                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.ConnectionTimeout, Lang.Error_ServerGeneric),
                    new FaultReason("Service Timeout"));
            }
            catch (Exception ex)
            {
                _log.Fatal($"Unhandled exception in LoginAsync for '{emailOrUsername}'", ex);

                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_ServerGeneric),
                    new FaultReason("Internal Server Error"));
            }
        }

        public async Task<OperationResultDto> RegisterAsync(UserProfileDto userProfile, string password)
        {
            string usernameLog = userProfile?.Username ?? "Unknown";
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new AuthenticationLogic(emailService, context);

                    _log.Info($"Register attempt for user: {usernameLog}");
                    return await logic.RegisterPlayerAsync(userProfile, password);
                }
            }
            catch (InvalidOperationException ex)
            {
                ServiceErrorType errorType = ServiceErrorType.OperationFailed;
                string userMessage = ex.Message;

                if (ex.Message.Contains("username"))
                {
                    errorType = ServiceErrorType.UserAlreadyExists;
                    userMessage = Lang.Error_UserAlreadyExists;
                }
                else if (ex.Message.Contains("email"))
                {
                    errorType = ServiceErrorType.EmailAlreadyRegistered;
                    userMessage = Lang.Error_EmailAlreadyRegistered;
                }

                _log.Info($"Registration logic rejection for '{usernameLog}': {ex.Message}");

                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(errorType, userMessage),
                    new FaultReason(userMessage));
            }
            catch (ArgumentException ex)
            {
                _log.Info($"Registration validation failed: {ex.Message}");
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.OperationFailed, Lang.Error_FieldsRequired),
                    new FaultReason("Validation Error"));
            }
            catch (EntityException ex)
            {
                _log.Fatal($"Database unavailable during registration for '{usernameLog}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.DatabaseError, Lang.Error_DatabaseConnectionError),
                    new FaultReason("Database Unavailable"));
            }
            catch (Exception ex)
            {
                _log.Fatal($"Unhandled exception in RegisterAsync for '{usernameLog}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_ServerGeneric),
                    new FaultReason("Internal Server Error"));
            }
        }

        public async Task<OperationResultDto> VerifyAccountAsync(string email, string verificationCode)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new AuthenticationLogic(emailService, context);

                    return await logic.VerifyAccountAsync(email, verificationCode);
                }
            }
            catch (InvalidOperationException ex)
            {
                _log.Info($"Verification logic rejection for '{email}': {ex.Message}");
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.OperationFailed, Lang.Error_InvalidOrExpiredCode),
                    new FaultReason("Verification Failed"));
            }
            catch (EntityException ex)
            {
                _log.Fatal($"Database unavailable during verification for '{email}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.DatabaseError, Lang.Error_DatabaseConnectionError),
                    new FaultReason("Database Unavailable"));
            }
            catch (Exception ex)
            {
                _log.Fatal($"Unhandled exception in VerifyAccountAsync for '{email}'", ex);
                throw new FaultException<ServiceFaultDto>(
                    new ServiceFaultDto(ServiceErrorType.Unknown, Lang.Error_ServerGeneric),
                    new FaultReason("Internal Server Error"));
            }
        }

        public void LogOut(string username)
        {
            try
            {
                using (var context = new GuessMyMessDBEntities())
                {
                    var emailService = new SmtpEmailService();
                    var logic = new AuthenticationLogic(emailService, context);
                    logic.LogOut(username);
                    _log.Info($"User {username} logged out successfully.");
                }
            }
            catch (Exception ex)
            {
                _log.Warn($"Error in LogOut (OneWay) for user '{username}': {ex.Message}", ex);
            }
        }

        public Task<OperationResultDto> LoginAsGuestAsync(string username, string avatarPath)
        {
            var fault = new ServiceFaultDto(ServiceErrorType.OperationFailed, "Guest login not implemented yet.");
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason("Not Implemented"));
        }

        public Task<OperationResultDto> SendPasswordRecoveryCodeAsync(string email)
        {
            var fault = new ServiceFaultDto(ServiceErrorType.OperationFailed, "Password recovery not implemented yet.");
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason("Not Implemented"));
        }

        public Task<OperationResultDto> ResetPasswordWithCodeAsync(string email, string code, string newPassword)
        {
            var fault = new ServiceFaultDto(ServiceErrorType.OperationFailed, "Password reset not implemented yet.");
            throw new FaultException<ServiceFaultDto>(fault, new FaultReason("Not Implemented"));
        }
    }
}
