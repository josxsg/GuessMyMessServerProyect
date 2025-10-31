using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities; 
using GuessMyMessServer.Utilities.Email;
using GuessMyMessServer.Utilities.Email.Templates;
using Moq;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Threading;
using System.Threading.Tasks;
using Xunit;

namespace GuessMyMessServer.Tests
{
    public class UserProfileLogicTests
    {
        private readonly Mock<GuessMyMessDBEntities> _mockContext;
        private readonly Mock<IEmailService> _mockEmailService;
        private readonly UserProfileLogic _profileLogic;

        public UserProfileLogicTests()
        {
            _mockContext = new Mock<GuessMyMessDBEntities>();
            _mockEmailService = new Mock<IEmailService>();
            _profileLogic = new UserProfileLogic(_mockEmailService.Object, _mockContext.Object);
        }

        [Fact]
        public async Task GetUserProfileAsyncShouldThrowExceptionWhenUserNotFound()
        {
            string nonExistentUsername = "usuarioNoExiste";
            var playersData = new List<Player>().AsQueryable(); 
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _profileLogic.GetUserProfileAsync(nonExistentUsername)
            );
            Assert.Equal("Usuario no encontrado.", exception.Message);
        }

        [Fact]
        public async Task GetUserProfileAsyncShouldReturnProfileWhenUserFound()
        {
            string existingUsername = "usuarioExiste";
            var playerEntity = new Player
            {
                username = existingUsername,
                name = "Nombre",
                lastName = "Apellido",
                email = "correo@ejemplo.com",
                Gender_idGender = 1,
                Avatar_idAvatar = 2,
                Gender = new Gender { idGender = 1, gender1="Masculino" }, 
                Avatar = new Avatar { idAvatar = 2, avatarName = "Avatar2" }   
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>()
                .SetupData(playersData);
            mockDbSet.Setup(m => m.Include(It.IsAny<string>())).Returns(mockDbSet.Object);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);


            var result = await _profileLogic.GetUserProfileAsync(existingUsername);

            Assert.NotNull(result);
            Assert.Equal(existingUsername, result.Username);
            Assert.Equal(playerEntity.name, result.FirstName);
            Assert.Equal(playerEntity.lastName, result.LastName);
            Assert.Equal(playerEntity.email, result.Email);
            Assert.Equal(playerEntity.Gender_idGender, result.GenderId);
            Assert.Equal(playerEntity.Avatar_idAvatar, result.AvatarId);
        }

        [Fact]
        public async Task UpdateProfileAsyncShouldThrowExceptionWhenUserNotFound()
        {
            string nonExistentUsername = "usuarioNoExiste";
            var profileData = new UserProfileDto { };
            var playersData = new List<Player>().AsQueryable(); 
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _profileLogic.UpdateProfileAsync(nonExistentUsername, profileData)
            );
            Assert.Equal("Usuario no encontrado.", exception.Message);
        }

        [Fact]
        public async Task UpdateProfileAsyncShouldUpdateProfileAndReturnSuccessWhenUserFound()
        {
            string existingUsername = "usuarioAActualizar";
            var playerEntity = new Player
            {
                username = existingUsername,
                name = "Nombre Viejo",
                lastName = "Apellido Viejo",
                Gender_idGender = 1,
                Avatar_idAvatar = 1
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();

            var profileDataToUpdate = new UserProfileDto
            {
                FirstName = "Nombre Nuevo",
                LastName = "Apellido Nuevo",
                GenderId = 2,
                AvatarId = 3
            };

            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);
            _mockContext.Setup(c => c.SaveChangesAsync()).ReturnsAsync(1);

            var result = await _profileLogic.UpdateProfileAsync(existingUsername, profileDataToUpdate);

            Assert.True(result.Success);
            Assert.Equal("Perfil actualizado correctamente.", result.Message);

            Assert.Equal(profileDataToUpdate.FirstName, playerEntity.name);
            Assert.Equal(profileDataToUpdate.LastName, playerEntity.lastName);
            Assert.Equal(profileDataToUpdate.GenderId, playerEntity.Gender_idGender);
            Assert.Equal(profileDataToUpdate.AvatarId, playerEntity.Avatar_idAvatar);

            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once);
        }

        [Fact]
        public async Task RequestChangePasswordAsyncShouldThrowExceptionWhenUserNotFound()
        {
            string nonExistentUsername = "noExiste";
            var playersData = new List<Player>().AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var ex = await Assert.ThrowsAsync<Exception>(() => _profileLogic.RequestChangePasswordAsync(nonExistentUsername));
            Assert.Equal("Usuario no encontrado.", ex.Message);
        }

        [Fact]
        public async Task RequestChangePasswordAsyncShouldSetTempCodeAndSendEmailWhenUserFound()
        {
            string existingUsername = "userPassChange";
            string userEmail = "passchange@test.com";
            var playerEntity = new Player { username = existingUsername, email = userEmail, temp_code = null, temp_code_expiry = null };
            var playersData = new List<Player> { playerEntity }.AsQueryable();

            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);
            _mockContext.Setup(c => c.SaveChangesAsync()).ReturnsAsync(1); 
            _mockEmailService.Setup(e => e.SendEmailAsync(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<IEmailTemplate>()))
                            .Returns(Task.CompletedTask); 

            var result = await _profileLogic.RequestChangePasswordAsync(existingUsername);

            Assert.True(result.Success);
            Assert.Equal("Se ha enviado un código de verificación a tu correo registrado.", result.Message); 
            Assert.NotNull(playerEntity.temp_code);
            Assert.True(playerEntity.temp_code.Length == 6);
            Assert.NotNull(playerEntity.temp_code_expiry);
            Assert.True(playerEntity.temp_code_expiry > DateTime.UtcNow); 

            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once); 
            _mockEmailService.Verify(e => e.SendEmailAsync(userEmail, existingUsername, It.IsAny<PasswordChangeVerificationEmailTemplate>()), Times.Once); 
        }

        [Fact]
        public async Task RequestChangeEmailAsyncShouldThrowExceptionWhenUserNotFound()
        {
            string nonExistentUsername = "noExiste";
            string newEmail = "nuevo@valido.com";
            var playersData = new List<Player>().AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var ex = await Assert.ThrowsAsync<Exception>(() => _profileLogic.RequestChangeEmailAsync(nonExistentUsername, newEmail));
            Assert.Equal("Usuario no encontrado.", ex.Message);
        }

        [Fact]
        public async Task RequestChangeEmailAsyncShouldThrowExceptionWhenNewEmailExists()
        {
            string existingUsername = "userEmailChange";
            string currentEmail = "actual@test.com";
            string existingNewEmail = "nuevoYaExiste@test.com";
            var playerRequesting = new Player { username = existingUsername, email = currentEmail };
            var playerWithNewEmail = new Player { username = "otro_user", email = existingNewEmail };
            var playersData = new List<Player> { playerRequesting, playerWithNewEmail }.AsQueryable();

            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var ex = await Assert.ThrowsAsync<Exception>(() => _profileLogic.RequestChangeEmailAsync(existingUsername, existingNewEmail));
            Assert.Equal("El nuevo correo ya está registrado.", ex.Message);
        }

        [Fact]
        public async Task RequestChangeEmailAsyncShouldSetPendingEmailAndSendVerificationWhenValid()
        {
            string existingUsername = "userEmailChangeValid";
            string currentEmail = "actualValido@test.com";
            string newValidEmail = "nuevoValido@test.com";
            var playerEntity = new Player { username = existingUsername, email = currentEmail, temp_code = null, temp_code_expiry = null, new_email_pending = null };
            var playersData = new List<Player> { playerEntity }.AsQueryable(); 

            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);
            _mockContext.Setup(c => c.SaveChangesAsync()).ReturnsAsync(1);
            _mockEmailService.Setup(e => e.SendEmailAsync(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<IEmailTemplate>()))
                             .Returns(Task.CompletedTask);

            var result = await _profileLogic.RequestChangeEmailAsync(existingUsername, newValidEmail);

            Assert.True(result.Success);
            Assert.Equal($"Se ha enviado un código a tu correo actual ({currentEmail}) para confirmar.", result.Message);
            Assert.NotNull(playerEntity.temp_code);
            Assert.True(playerEntity.temp_code.Length == 6);
            Assert.NotNull(playerEntity.temp_code_expiry);
            Assert.True(playerEntity.temp_code_expiry > DateTime.UtcNow);
            Assert.Equal(newValidEmail, playerEntity.new_email_pending); 

            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once);
            _mockEmailService.Verify(e => e.SendEmailAsync(currentEmail, existingUsername, It.IsAny<EmailChangeVerificationEmailTemplate>()), Times.Once); 
        }

        [Fact]
        public async Task ConfirmChangePasswordAsyncShouldThrowExceptionWhenUserNotFound()
        {
            string nonExistentUsername = "noExiste";
            string newPassword = "NewSecurePassword123!";
            string code = "123456";
            var playersData = new List<Player>().AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var ex = await Assert.ThrowsAsync<Exception>(() =>
                _profileLogic.ConfirmChangePasswordAsync(nonExistentUsername, newPassword, code));
            Assert.Equal("Usuario no encontrado.", ex.Message);
        }

        [Fact]
        public async Task ConfirmChangePasswordAsyncShouldThrowExceptionWhenCodeIsInvalid()
        {
            string existingUsername = "userConfirmPass";
            string correctCode = "123456";
            string incorrectCode = "654321";
            string newPassword = "NewSecurePassword123!";
            var playerEntity = new Player
            {
                username = existingUsername,
                temp_code = correctCode,
                temp_code_expiry = DateTime.UtcNow.AddMinutes(5)
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var ex = await Assert.ThrowsAsync<Exception>(() =>
                _profileLogic.ConfirmChangePasswordAsync(existingUsername, newPassword, incorrectCode));
            Assert.Equal("Código de verificación inválido o expirado.", ex.Message);
        }

        [Fact]
        public async Task ConfirmChangePasswordAsyncShouldThrowExceptionWhenCodeIsExpired()
        {
            string existingUsername = "userConfirmPassExp";
            string correctCode = "123456";
            string newPassword = "NewSecurePassword123!";
            var playerEntity = new Player
            {
                username = existingUsername,
                temp_code = correctCode,
                temp_code_expiry = DateTime.UtcNow.AddMinutes(-5)
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var ex = await Assert.ThrowsAsync<Exception>(() =>
                _profileLogic.ConfirmChangePasswordAsync(existingUsername, newPassword, correctCode)); 
            Assert.Equal("Código de verificación inválido o expirado.", ex.Message);
        }

        [Fact]
        public async Task ConfirmChangePasswordAsyncShouldUpdatePasswordAndReturnSuccessWhenValid()
        {
            string existingUsername = "userConfirmPassValid";
            string oldPasswordHash = PasswordHasher.HashPassword("OldPassword123!");
            string newPassword = "NewSecurePassword123!";
            string correctCode = "123456";
            var playerEntity = new Player
            {
                username = existingUsername,
                password = oldPasswordHash,
                temp_code = correctCode,
                temp_code_expiry = DateTime.UtcNow.AddMinutes(5) 
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);
            _mockContext.Setup(c => c.SaveChangesAsync()).ReturnsAsync(1); 

            var result = await _profileLogic.ConfirmChangePasswordAsync(existingUsername, newPassword, correctCode);

            Assert.True(result.Success);
            Assert.Equal("Contraseña actualizada con éxito.", result.Message);
            Assert.NotEqual(oldPasswordHash, playerEntity.password); 
            Assert.True(PasswordHasher.VerifyPassword(newPassword, playerEntity.password)); 
            Assert.Null(playerEntity.temp_code); 
            Assert.Null(playerEntity.temp_code_expiry); 
            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once); 
        }

        [Fact]
        public async Task ConfirmChangeEmailAsyncShouldThrowExceptionWhenUserNotFound()
        {
            string nonExistentUsername = "noExiste";
            string code = "123456";
            var playersData = new List<Player>().AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var ex = await Assert.ThrowsAsync<Exception>(() =>
                _profileLogic.ConfirmChangeEmailAsync(nonExistentUsername, code));

            Assert.Equal("Usuario no encontrado.", ex.Message);
        }

        [Fact]
        public async Task ConfirmChangeEmailAsyncShouldThrowExceptionWhenNoPendingEmail()
        {
            string existingUsername = "userNoPending";
            string code = "123456";
            var playerEntity = new Player { username = existingUsername, new_email_pending = null }; 
            var playersData = new List<Player> { playerEntity }.AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var ex = await Assert.ThrowsAsync<Exception>(() =>
               _profileLogic.ConfirmChangeEmailAsync(existingUsername, code));

            Assert.Equal("No hay un cambio de email pendiente.", ex.Message);
        }

        [Fact]
        public async Task ConfirmChangeEmailAsyncShouldThrowExceptionWhenCodeIsInvalid()
        {
            string existingUsername = "userConfirmEmailInvalid";
            string correctCode = "123456";
            string incorrectCode = "654321";
            var playerEntity = new Player
            {
                username = existingUsername,
                new_email_pending = "nuevo@test.com",
                temp_code = correctCode,
                temp_code_expiry = DateTime.UtcNow.AddMinutes(5)
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var ex = await Assert.ThrowsAsync<Exception>(() =>
                 _profileLogic.ConfirmChangeEmailAsync(existingUsername, incorrectCode)); 

            Assert.Equal("Código de verificación inválido o expirado.", ex.Message);
        }

        [Fact]
        public async Task ConfirmChangeEmailAsyncShouldThrowExceptionWhenCodeIsExpired()
        {
            string existingUsername = "userConfirmEmailExpired";
            string correctCode = "123456";
            var playerEntity = new Player
            {
                username = existingUsername,
                new_email_pending = "nuevo@test.com",
                temp_code = correctCode,
                temp_code_expiry = DateTime.UtcNow.AddMinutes(-5) 
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var ex = await Assert.ThrowsAsync<Exception>(() =>
                _profileLogic.ConfirmChangeEmailAsync(existingUsername, correctCode)); 

            Assert.Equal("Código de verificación inválido o expirado.", ex.Message);
        }

        [Fact]
        public async Task ConfirmChangeEmailAsyncShouldThrowAndCleanupWhenNewEmailIsTakenByAnotherUser()
        {
            string user1Username = "user1ConfirmEmail";
            string user2Username = "user2HasEmail";
            string pendingEmail = "nuevoTomado@test.com";
            string correctCode = "123456";

            var user1Entity = new Player
            { 
                idPlayer = 1,
                username = user1Username,
                email = "viejo1@test.com",
                new_email_pending = pendingEmail,
                temp_code = correctCode,
                temp_code_expiry = DateTime.UtcNow.AddMinutes(5)
            };
            var user2Entity = new Player
            { 
                idPlayer = 2,
                username = user2Username,
                email = pendingEmail 
            };
            var playersData = new List<Player> { user1Entity, user2Entity }.AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);
            _mockContext.Setup(c => c.SaveChangesAsync()).ReturnsAsync(1); 

            var ex = await Assert.ThrowsAsync<Exception>(() =>
                _profileLogic.ConfirmChangeEmailAsync(user1Username, correctCode));

            Assert.Equal("El nuevo correo electrónico ya fue registrado por otro usuario.", ex.Message);

            Assert.Null(user1Entity.temp_code);
            Assert.Null(user1Entity.temp_code_expiry);
            Assert.Null(user1Entity.new_email_pending);
            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once); 
        }

        [Fact]
        public async Task ConfirmChangeEmailAsyncShouldUpdateEmailAndReturnSuccessWhenValid()
        {
            string existingUsername = "userConfirmEmailValid";
            string oldEmail = "viejoValido@test.com";
            string newEmail = "nuevoConfirmado@test.com";
            string correctCode = "123456";
            var playerEntity = new Player
            {
                idPlayer = 1,
                username = existingUsername,
                email = oldEmail,
                new_email_pending = newEmail,
                temp_code = correctCode,
                temp_code_expiry = DateTime.UtcNow.AddMinutes(5)
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);
            _mockContext.Setup(c => c.SaveChangesAsync()).ReturnsAsync(1);

            var result = await _profileLogic.ConfirmChangeEmailAsync(existingUsername, correctCode);

            Assert.True(result.Success);
            Assert.Equal("Email actualizado con éxito.", result.Message);
            Assert.Equal(newEmail, playerEntity.email); 
            Assert.Null(playerEntity.new_email_pending);
            Assert.Null(playerEntity.temp_code); 
            Assert.Null(playerEntity.temp_code_expiry);
            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once);
        }

        [Fact]
        public async Task GetAvailableAvatarsAsyncShouldReturnAvatarsFromDb()
        {
            var avatarsData = new List<Avatar> {
                new Avatar { idAvatar = 1, avatarName = "Avatar1", avatarUrl = "path/to/avatar1.png" },
                new Avatar { idAvatar = 2, avatarName = "Avatar2", avatarUrl = "path/to/avatar2.png" }
            }.AsQueryable();

            var mockDbSet = new Mock<DbSet<Avatar>>().SetupData(avatarsData); 
            _mockContext.Setup(c => c.Avatar).Returns(mockDbSet.Object);

            var result = await _profileLogic.GetAvailableAvatarsAsync();

            Assert.NotNull(result);
            Assert.Equal(2, result.Count);
            Assert.Equal(1, result[0].IdAvatar);
            Assert.Equal("Avatar1", result[0].AvatarName);
            Assert.Equal(2, result[1].IdAvatar);
            Assert.Equal("Avatar2", result[1].AvatarName);
            Assert.Null(result[0].AvatarData); 
            Assert.Null(result[1].AvatarData);
        }
    }    
}