using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.Contracts.DataContracts;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.Utilities;
using GuessMyMessServer.Utilities.Email;
using Moq;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Linq.Expressions;
using System.Threading;
using System.Threading.Tasks;
using Xunit;

namespace GuessMyMessServer.Tests
{
    public class AuthenticationLogicTests
    {
        private readonly Mock<GuessMyMessDBEntities> _mockContext;
        private readonly Mock<IEmailService> _mockEmailService;
        private readonly AuthenticationLogic _authLogic;

        public AuthenticationLogicTests()
        {
            _mockContext = new Mock<GuessMyMessDBEntities>();
            _mockEmailService = new Mock<IEmailService>();
            _authLogic = new AuthenticationLogic(_mockEmailService.Object, _mockContext.Object);
        }

        [Fact]
        public async Task LoginAsyncShouldThrowExceptionWhenUserDoesNotExist()
        {
            var playersData = new List<Player>().AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>()
                .SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.LoginAsync("usuario_falso", "cualquier_pass")
            );
            Assert.Equal("Credenciales incorrectas.", exception.Message);
        }

        [Fact]
        public async Task LoginAsyncShouldThrowExceptionWhenPasswordIsIncorrect()
        {
            string username = "usuarioExiste";
            string correctPassword = "passCorrecta";
            string incorrectPassword = "passIncorrecta"; 
            string correctPasswordHash = GuessMyMessServer.Utilities.PasswordHasher.HashPassword(correctPassword);

            var playersData = new List<Player> {
                new Player {
                    username = username,
                    email = "existe@test.com",
                    password = correctPasswordHash, 
                    is_verified = 1 
                }
            }.AsQueryable();

            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.LoginAsync(username, incorrectPassword)
            );
            Assert.Equal("Credenciales incorrectas.", exception.Message);
        }

        [Fact]
        public async Task LoginAsyncShouldThrowExceptionWhenUserIsNotVerified()
        {
            string username = "usuarioNoVerificado";
            string correctPassword = "passCorrecta";
            string correctPasswordHash = GuessMyMessServer.Utilities.PasswordHasher.HashPassword(correctPassword);
            var playersData = new List<Player> {
                new Player {
                    username = username,
                    email = "noverif@test.com",
                    password = correctPasswordHash,
                    is_verified = 0 
                }
            }.AsQueryable();

            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.LoginAsync(username, correctPassword)
            );
            Assert.Equal("La cuenta no ha sido verificada. Por favor, revisa tu correo.", exception.Message);
        }

        [Fact]
        public async Task LoginAsyncShouldReturnSuccessWhenCredentialsAreCorrect()
        {
            string username = "usuarioValido";
            string password = "passCorrecta";
            string correctPasswordHash = GuessMyMessServer.Utilities.PasswordHasher.HashPassword(password);
            var playerEntity = new Player
            {
                username = username,
                email = "valido@test.com",
                password = correctPasswordHash,
                is_verified = 1, 
                UserStatus_idUserStatus = 1 
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);
            _mockContext.Setup(c => c.SaveChangesAsync()) 
             .ReturnsAsync(1);

            var result = await _authLogic.LoginAsync(username, password);

            Assert.True(result.Success);
            Assert.Equal(username, result.Message);
            Assert.Equal(2, playerEntity.UserStatus_idUserStatus);

            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once); 
        }

        [Fact]
        public async Task RegisterPlayerAsyncShouldThrowExceptionWhenUsernameExists()
        {
            string existingUsername = "usuarioExistente";
            var newUserProfile = new UserProfileDto
            {
                Username = existingUsername,
                Email = "nuevo@email.com",
                FirstName = "Nuevo",
                LastName = "Usuario",
                GenderId = 1,
                AvatarId = 1
            };
            string newUserPassword = "passwordValido12!";
            var playersData = new List<Player> {
                new Player { username = existingUsername, email = "existente@email.com" }
            }.AsQueryable();

            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.RegisterPlayerAsync(newUserProfile, newUserPassword)
            );

            Assert.Equal("El nombre de usuario ya está en uso.", exception.Message);
        }

        [Fact]
        public async Task RegisterPlayerAsyncShouldThrowExceptionWhenEmailExists()
        {
            string existingEmail = "existente@email.com";
            var newUserProfile = new UserProfileDto
            {
                Username = "nuevoUsuario",
                Email = existingEmail,      
                FirstName = "Nuevo",
                LastName = "Usuario",
                GenderId = 1,
                AvatarId = 1
            };
            string newUserPassword = "PasswordSegura123!";
            var playersData = new List<Player> {
                new Player {
                    username = "usuarioExistente",
                    email = existingEmail           
                }
            }.AsQueryable();

            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.RegisterPlayerAsync(newUserProfile, newUserPassword)
            );

            Assert.Equal("El correo electrónico ya está registrado.", exception.Message);
        }

        [Fact]
        public async Task RegisterPlayerAsyncShouldReturnSuccessWhenDataIsValid()
        {
            var newUserProfile = new UserProfileDto
            {
                Username = "nuevoUsuarioValido",
                Email = "valido@email.com",
                FirstName = "Valido",
                LastName = "Usuario",
                GenderId = 1,
                AvatarId = 1
            };
            string newUserPassword = "PasswordSegura123!";
            var playersData = new List<Player>().AsQueryable();
            Player addedPlayer = null;

            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            mockDbSet.Setup(m => m.Add(It.IsAny<Player>()))
                     .Returns<Player>(entity => entity)
                     .Callback<Player>(p => addedPlayer = p);

            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);
            _mockContext.Setup(c => c.SaveChangesAsync())
                        .ReturnsAsync(1);
            _mockEmailService.Setup(e => e.SendEmailAsync(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<IEmailTemplate>()))
                             .Returns(Task.CompletedTask);

            var result = await _authLogic.RegisterPlayerAsync(newUserProfile, newUserPassword);

            Assert.True(result.Success);
            Assert.Equal("Registro exitoso. Se ha enviado un código de verificación a tu correo.", result.Message);

            _mockEmailService.Verify(e => e.SendEmailAsync(newUserProfile.Email, newUserProfile.Username, It.IsAny<VerificationEmailTemplate>()), Times.Once);
            mockDbSet.Verify(db => db.Add(It.IsAny<Player>()), Times.Once);

            Assert.NotNull(addedPlayer);
            Assert.Equal(newUserProfile.Username, addedPlayer.username);
            Assert.Equal(newUserProfile.Email, addedPlayer.email);
            Assert.Equal(newUserProfile.FirstName, addedPlayer.name);
            Assert.Equal(newUserProfile.LastName, addedPlayer.lastName);
            Assert.Equal(newUserProfile.GenderId, addedPlayer.Gender_idGender);
            Assert.Equal(newUserProfile.AvatarId, addedPlayer.Avatar_idAvatar);
            Assert.Equal(0, addedPlayer.is_verified);
            Assert.Equal(1, addedPlayer.UserStatus_idUserStatus);
            Assert.NotNull(addedPlayer.verification_code);
            Assert.True(addedPlayer.code_expiry_date > DateTime.UtcNow);
            Assert.NotEmpty(addedPlayer.password);
            Assert.NotEqual(newUserPassword, addedPlayer.password);
            Assert.True(PasswordHasher.VerifyPassword(newUserPassword, addedPlayer.password));

            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once);
        }

        [Fact]
        public async Task RegisterPlayerAsyncShouldThrowExceptionWhenEmailServiceFails()
        {
            var newUserProfile = new UserProfileDto
            {
                Username = "usuarioEmailFalla",
                Email = "emailfalla@test.com",
                FirstName = "Email",
                LastName = "Falla",
                GenderId = 1,
                AvatarId = 1
            };
            string newUserPassword = "PasswordSegura123!";

            var playersData = new List<Player>().AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);
            _mockEmailService.Setup(e => e.SendEmailAsync(
                                        It.IsAny<string>(),
                                        It.IsAny<string>(),
                                        It.IsAny<IEmailTemplate>()))
                             .ThrowsAsync(new Exception("Error simulado de envío de correo")); 

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.RegisterPlayerAsync(newUserProfile, newUserPassword)
            );

            Assert.Equal("No se pudo enviar el correo de verificación. Revisa que el correo sea correcto.", exception.Message);
            mockDbSet.Verify(db => db.Add(It.IsAny<Player>()), Times.Never);
        }

        [Fact]
        public async Task RegisterPlayerAsyncShouldThrowExceptionWhenDatabaseSaveFails()
        {
            var newUserProfile = new UserProfileDto
            {
                Username = "usuarioDbFalla",
                Email = "dbfalla@test.com",
                FirstName = "DB",
                LastName = "Falla",
                GenderId = 1,
                AvatarId = 1
            };
            string newUserPassword = "PasswordSegura123!";
            var playersData = new List<Player>().AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            mockDbSet.Setup(m => m.Add(It.IsAny<Player>()))
                    .Returns<Player>(entity => entity);

            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);
            _mockEmailService.Setup(e => e.SendEmailAsync(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<IEmailTemplate>()))
                             .Returns(Task.CompletedTask);

            _mockContext.Setup(c => c.SaveChangesAsync())
                        .ThrowsAsync(new DbUpdateException("Error simulado al guardar en BD"));

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.RegisterPlayerAsync(newUserProfile, newUserPassword)
            );

            Assert.Equal("Error al guardar el usuario. Verifica los datos proporcionados.", exception.Message);

            _mockEmailService.Verify(e => e.SendEmailAsync(newUserProfile.Email, newUserProfile.Username, It.IsAny<VerificationEmailTemplate>()), Times.Once);
            mockDbSet.Verify(db => db.Add(It.IsAny<Player>()), Times.Once);

            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once);
        }

        [Fact]
        public async Task VerifyAccountAsyncShouldThrowExceptionWhenEmailNotFound()
        {
            string nonExistentEmail = "noexiste@test.com";
            string anyCode = "123456"; 
            var playersData = new List<Player>().AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.VerifyAccountAsync(nonExistentEmail, anyCode)
            );

            Assert.Equal("No se encontró una cuenta para este correo.", exception.Message);
        }

        [Fact]
        public async Task VerifyAccountAsyncShouldThrowExceptionWhenAccountIsAlreadyVerified()
        {
            string existingVerifiedEmail = "verificado@test.com";
            string anyCode = "123456"; 
            var playersData = new List<Player> {
                new Player {
                    username = "usuarioVerificado",
                    email = existingVerifiedEmail,
                    is_verified = 1 
                }
            }.AsQueryable();

            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.VerifyAccountAsync(existingVerifiedEmail, anyCode)
            );

            Assert.Equal("Esta cuenta ya está verificada.", exception.Message);
        }
     
        [Fact]
        public async Task VerifyAccountAsyncShouldThrowExceptionWhenCodeIsInvalid()
        {
            string existingEmail = "porverificar@test.com";
            string correctCode = "123456"; 
            string incorrectCode = "654321"; 
            var playersData = new List<Player> {
                new Player {
                    username = "usuarioPorVerificar",
                    email = existingEmail,
                    is_verified = 0, 
                    verification_code = correctCode, 
                    code_expiry_date = DateTime.UtcNow.AddMinutes(10) 
                }
            }.AsQueryable();

            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.VerifyAccountAsync(existingEmail, incorrectCode) 
            );

            Assert.Equal("Código de verificación inválido o expirado.", exception.Message);
        }
       
        [Fact]
        public async Task VerifyAccountAsyncShouldThrowExceptionWhenCodeIsExpired()
        {
            string existingEmail = "codigoexpirado@test.com";
            string correctCode = "789012"; 
            var playersData = new List<Player> {
                new Player {
                    username = "usuarioExpirado",
                    email = existingEmail,
                    is_verified = 0, 
                    verification_code = correctCode, 
                    code_expiry_date = DateTime.UtcNow.AddMinutes(-10) 
                }
            }.AsQueryable();

            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.VerifyAccountAsync(existingEmail, correctCode) 
            );

            Assert.Equal("Código de verificación inválido o expirado.", exception.Message);
        }
       
        [Fact]
        public async Task VerifyAccountAsyncShouldReturnSuccessWhenCodeIsValidAndNotExpired()
        {
            string existingEmail = "verificacionexitosa@test.com";
            string correctCode = "112233";
            var playerEntity = new Player
            {
                username = "usuarioAVerificar",
                email = existingEmail,
                is_verified = 0, 
                verification_code = correctCode,
                code_expiry_date = DateTime.UtcNow.AddMinutes(15), 
                UserStatus_idUserStatus = 1 
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);
            _mockContext.Setup(c => c.SaveChangesAsync()) 
                        .ReturnsAsync(1); 

            var result = await _authLogic.VerifyAccountAsync(existingEmail, correctCode);

            Assert.True(result.Success);
            Assert.Equal("Cuenta verificada con éxito. ¡Bienvenido!", result.Message);

            Assert.Equal(1, playerEntity.is_verified); 
            Assert.Null(playerEntity.verification_code); 
            Assert.Null(playerEntity.code_expiry_date); 
            Assert.Equal(2, playerEntity.UserStatus_idUserStatus); 

            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once); 
        }

        [Fact]
        public void LogOutShouldSetUserStatusToOfflineWhenUserExists()
        {
            string existingUsername = "usuarioOnline";
            const int StatusOnline = 2;
            const int StatusOffline = 1;
            var playerEntity = new Player
            {
                username = existingUsername,
                email = "online@test.com",
                UserStatus_idUserStatus = StatusOnline
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);
            _mockContext.Setup(c => c.SaveChanges()).Returns(1);

            _authLogic.LogOut(existingUsername);

            Assert.Equal(StatusOffline, playerEntity.UserStatus_idUserStatus);
            _mockContext.Verify(c => c.SaveChanges(), Times.Once); 
        }

        [Fact]
        public void LogOutShouldDoNothingWhenUserDoesNotExist()
        {
            string nonExistentUsername = "usuarioNoExiste";
            var playersData = new List<Player>().AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            _authLogic.LogOut(nonExistentUsername);

            _mockContext.Verify(c => c.SaveChanges(), Times.Never);
        }
    }   
}