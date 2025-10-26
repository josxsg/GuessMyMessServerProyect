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
        public async Task LoginAsync_ShouldThrowException_WhenUserDoesNotExist()
        {
            // --- 1. Arrange (Organizar) ---

            // Creamos una lista VACÍA de jugadores.
            var playersData = new List<Player>().AsQueryable();

            // Creamos un Mock del DbSet<Player> que funcione con Async
            // (Usa los métodos Helper definidos más abajo)
            var mockDbSet = new Mock<DbSet<Player>>()
                .SetupData(playersData);

            // Le decimos al Contexto Falso que use nuestro DbSet Falso
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // --- 2. Act & 3. Assert (Actuar y Afirmar) ---

            // CAMBIO 4: Verificamos que se lance una Excepción,
            // ya que tu lógica no devuelve 'Success=false', sino que lanza un error.
            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.LoginAsync("usuario_falso", "cualquier_pass")
            );

            // CAMBIO 5: Verificamos que sea el mensaje de error correcto
            Assert.Equal("Credenciales incorrectas.", exception.Message);
        }

        [Fact]
        public async Task LoginAsync_ShouldThrowException_WhenPasswordIsIncorrect()
        {
            // --- 1. Arrange (Organizar) ---

            // Definimos un usuario y su contraseña CORRECTA
            string username = "usuarioExiste";
            string correctPassword = "passCorrecta";
            string incorrectPassword = "passIncorrecta"; // <-- La contraseña que usaremos

            // Hasheamos la contraseña CORRECTA (esto es lo que estaría en la BD)
            string correctPasswordHash = GuessMyMessServer.Utilities.PasswordHasher.HashPassword(correctPassword);

            // Creamos una lista con UN jugador que SÍ existe y está verificado
            var playersData = new List<Player> {
                new Player {
                    username = username,
                    email = "existe@test.com",
                    password = correctPasswordHash, // Guardamos el hash correcto
                    is_verified = 1 // ¡Importante! El usuario está verificado
                }
            }.AsQueryable();

            // Configuramos el Mock del DbSet para usar nuestra lista con el usuario
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);

            // Configuramos el Contexto Falso
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // --- 2. Act & 3. Assert (Actuar y Afirmar) ---

            // Intentamos hacer login con el usuario correcto, pero la contraseña INCORRECTA
            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.LoginAsync(username, incorrectPassword)
            );

            // Verificamos que la excepción sea la esperada
            Assert.Equal("Credenciales incorrectas.", exception.Message);
        }

        [Fact]
        public async Task LoginAsync_ShouldThrowException_WhenUserIsNotVerified()
        {
            // --- 1. Arrange (Organizar) ---

            // Definimos un usuario y su contraseña CORRECTA
            string username = "usuario_no_verificado";
            string correctPassword = "passCorrecta";

            // Hasheamos la contraseña correcta
            string correctPasswordHash = GuessMyMessServer.Utilities.PasswordHasher.HashPassword(correctPassword);

            // Creamos una lista con UN jugador que SÍ existe,
            // PERO tiene 'is_verified' en 0.
            var playersData = new List<Player> {
                new Player {
                    username = username,
                    email = "noverif@test.com",
                    password = correctPasswordHash,
                    is_verified = 0 // <-- ¡NO VERIFICADO!
                }
            }.AsQueryable();

            // Configuramos el Mock del DbSet
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);

            // Configuramos el Contexto Falso
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // --- 2. Act & 3. Assert (Actuar y Afirmar) ---

            // Intentamos hacer login con credenciales correctas, pero usuario no verificado
            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.LoginAsync(username, correctPassword)
            );

            // Verificamos que la excepción sea la específica para cuenta no verificada
            Assert.Equal("La cuenta no ha sido verificada. Por favor, revisa tu correo.", exception.Message);
        }

        [Fact]
        public async Task LoginAsync_ShouldReturnSuccess_WhenCredentialsAreCorrect()
        {
            // --- 1. Arrange (Organizar) ---

            // Definimos credenciales VÁLIDAS
            string username = "usuario_valido";
            string password = "passCorrecta";
            string correctPasswordHash = GuessMyMessServer.Utilities.PasswordHasher.HashPassword(password);

            // Creamos un jugador VÁLIDO y VERIFICADO en nuestra "base de datos"
            var playerEntity = new Player
            {
                username = username,
                email = "valido@test.com",
                password = correctPasswordHash,
                is_verified = 1, // <-- VERIFICADO
                UserStatus_idUserStatus = 1 // Estado inicial Offline (1)
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();

            // Configuramos el Mock del DbSet
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // ¡MUY IMPORTANTE! Tu lógica llama a SaveChangesAsync después de
            // cambiar el estado del usuario. Debemos simular que esto funciona.
            // Le decimos al Mock que cuando llamen a SaveChangesAsync,
            // devuelva un Task<int> con valor 1 (simulando 1 fila afectada).
            _mockContext.Setup(c => c.SaveChangesAsync()) // <-- Sin CancellationToken
             .ReturnsAsync(1);
            // Usamos It.IsAny<CancellationToken>() si tu método lo acepta, si no, usa .ReturnsAsync(1) directo.

            // --- 2. Act (Actuar) ---

            // Ejecutamos el login con las credenciales correctas
            var result = await _authLogic.LoginAsync(username, password);

            // --- 3. Assert (Afirmar) ---

            // Verificamos que el resultado sea exitoso
            Assert.True(result.Success);

            // Verificamos que el mensaje devuelto sea el nombre de usuario (según tu lógica)
            Assert.Equal(username, result.Message);

            // Verificación ADICIONAL (buenas prácticas):
            // Asegurarnos de que el estado del jugador se cambió a Online (2)
            Assert.Equal(2, playerEntity.UserStatus_idUserStatus);

            // Asegurarnos de que se intentó guardar los cambios en la BD una vez
            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once); // <-- Sin CancellationToken
            // De nuevo, ajusta CancellationToken si no lo usas.
        }

        [Fact]
        public async Task RegisterPlayerAsync_ShouldThrowException_WhenUsernameExists()
        {
            // --- 1. Arrange (Organizar) ---
            string existingUsername = "usuario_existente";

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

            // BD Falsa: Lista con el usuario existente
            var playersData = new List<Player> {
                new Player { username = existingUsername, email = "existente@email.com" }
            }.AsQueryable();

            // Usamos el helper SetupData para configurar el DbSet
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);

            // Configuramos el Contexto Falso
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // --- 2. Act & 3. Assert (Actuar y Afirmar) ---
            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.RegisterPlayerAsync(newUserProfile, newUserPassword)
            );

            Assert.Equal("El nombre de usuario ya está en uso.", exception.Message);
        }

        [Fact]
        public async Task RegisterPlayerAsync_ShouldThrowException_WhenEmailExists()
        {
            // --- 1. Arrange (Organizar) ---

            // Correo electrónico que YA EXISTE en nuestra BD falsa
            string existingEmail = "existente@email.com";

            // Creamos el perfil del NUEVO usuario que intenta registrarse
            // con un nombre de usuario NUEVO, pero el email EXISTENTE.
            var newUserProfile = new UserProfileDto
            {
                Username = "nuevo_usuario", // <-- Username diferente
                Email = existingEmail,      // <-- Mismo email
                FirstName = "Nuevo",
                LastName = "Usuario",
                GenderId = 1,
                AvatarId = 1
            };
            // Usamos una contraseña que SÍ sea segura
            string newUserPassword = "PasswordSegura123!";

            // BD Falsa: Contiene UN jugador con el email existente.
            // Es importante que el username sea DIFERENTE al que intentamos registrar.
            var playersData = new List<Player> {
                new Player {
                    username = "usuario_existente", // Username distinto
                    email = existingEmail           // Email que queremos probar
                }
            }.AsQueryable();

            // Configuramos el Mock del DbSet usando el helper
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);

            // Configuramos el Contexto Falso
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // No necesitamos simular _mockEmailService ni SaveChangesAsync para esta prueba.

            // --- 2. Act & 3. Assert (Actuar y Afirmar) ---

            // Intentamos registrar al nuevo usuario con el email existente.
            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.RegisterPlayerAsync(newUserProfile, newUserPassword)
            );

            // Verificamos que se lanzó la excepción correcta para email duplicado
            Assert.Equal("El correo electrónico ya está registrado.", exception.Message);
        }

        [Fact]
        public async Task RegisterPlayerAsync_ShouldReturnSuccess_WhenDataIsValid()
        {
            // --- 1. Arrange (Organizar) ---

            var newUserProfile = new UserProfileDto
            {
                Username = "nuevo_usuario_valido",
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

            // ---- CORRECCIÓN AQUÍ: Setup SIN CancellationToken ----
            _mockContext.Setup(c => c.SaveChangesAsync())
                        .ReturnsAsync(1);

            _mockEmailService.Setup(e => e.SendEmailAsync(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<IEmailTemplate>()))
                             .Returns(Task.CompletedTask);

            // --- 2. Act (Actuar) ---
            var result = await _authLogic.RegisterPlayerAsync(newUserProfile, newUserPassword);

            // --- 3. Assert (Afirmar) ---
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

            // ---- CORRECCIÓN AQUÍ: Verify SIN CancellationToken ----
            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once);
        }

        [Fact]
        public async Task RegisterPlayerAsync_ShouldThrowException_WhenEmailServiceFails()
        {
            // --- 1. Arrange (Organizar) ---

            // Datos válidos para un nuevo usuario
            var newUserProfile = new UserProfileDto
            {
                Username = "usuario_email_falla",
                Email = "emailfalla@test.com",
                FirstName = "Email",
                LastName = "Falla",
                GenderId = 1,
                AvatarId = 1
            };
            string newUserPassword = "PasswordSegura123!";

            // BD Falsa: Vacía, para que las validaciones de duplicados pasen
            var playersData = new List<Player>().AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // ---- SIMULACIÓN DEL FALLO DEL EMAIL ----
            // Le decimos al Mock del servicio de email que cuando llamen a SendEmailAsync,
            // LANCE una excepción (simulando un problema de red, SMTP, etc.)
            _mockEmailService.Setup(e => e.SendEmailAsync(
                                        It.IsAny<string>(),
                                        It.IsAny<string>(),
                                        It.IsAny<IEmailTemplate>()))
                             .ThrowsAsync(new Exception("Error simulado de envío de correo")); // <-- Lanza excepción

            // No necesitamos simular SaveChangesAsync, la excepción debe ocurrir antes.

            // --- 2. Act & 3. Assert (Actuar y Afirmar) ---

            // Intentamos registrar al usuario
            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.RegisterPlayerAsync(newUserProfile, newUserPassword)
            );

            // Verificamos que se lanzó la excepción correcta debido al fallo del email
            Assert.Equal("No se pudo enviar el correo de verificación. Revisa que el correo sea correcto.", exception.Message);

            // (Opcional) Verificar que NO se intentó añadir el jugador a la BD,
            // ya que el error ocurrió antes de context.Player.Add()
            mockDbSet.Verify(db => db.Add(It.IsAny<Player>()), Times.Never);
        }

        [Fact]
        public async Task RegisterPlayerAsync_ShouldThrowException_WhenDatabaseSaveFails()
        {
            // --- 1. Arrange (Organizar) ---

            var newUserProfile = new UserProfileDto
            {
                Username = "usuario_db_falla",
                Email = "dbfalla@test.com",
                FirstName = "DB",
                LastName = "Falla",
                GenderId = 1,
                AvatarId = 1
            };
            string newUserPassword = "PasswordSegura123!";
            var playersData = new List<Player>().AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);

            // Simular Add para que el Callback funcione si es necesario, aunque no es el foco
            mockDbSet.Setup(m => m.Add(It.IsAny<Player>()))
                    .Returns<Player>(entity => entity);

            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // Simular que el envío de email SÍ funciona
            _mockEmailService.Setup(e => e.SendEmailAsync(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<IEmailTemplate>()))
                             .Returns(Task.CompletedTask);

            // ---- CORRECCIÓN: Simular fallo de SaveChangesAsync SIN CancellationToken ----
            _mockContext.Setup(c => c.SaveChangesAsync())
                        .ThrowsAsync(new DbUpdateException("Error simulado al guardar en BD"));

            // --- 2. Act & 3. Assert (Actuar y Afirmar) ---

            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.RegisterPlayerAsync(newUserProfile, newUserPassword)
            );

            Assert.Equal("Error al guardar el usuario. Verifica los datos proporcionados.", exception.Message);

            // Verificaciones opcionales (deben seguir funcionando)
            _mockEmailService.Verify(e => e.SendEmailAsync(newUserProfile.Email, newUserProfile.Username, It.IsAny<VerificationEmailTemplate>()), Times.Once);
            mockDbSet.Verify(db => db.Add(It.IsAny<Player>()), Times.Once);

            // Verificar SaveChangesAsync SIN CancellationToken
            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once);
        }

        [Fact]
        public async Task VerifyAccountAsync_ShouldThrowException_WhenEmailNotFound()
        {
            // --- 1. Arrange (Organizar) ---

            // Correo y código para la verificación (el correo NO existe en la BD)
            string nonExistentEmail = "noexiste@test.com";
            string anyCode = "123456"; // El código no importa para esta prueba

            // BD Falsa: Lista VACÍA de jugadores.
            var playersData = new List<Player>().AsQueryable();

            // Configuramos el Mock del DbSet usando el helper SetupData
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);

            // Configuramos el Contexto Falso
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // No necesitamos simular SaveChangesAsync aquí, la excepción ocurre antes.

            // --- 2. Act & 3. Assert (Actuar y Afirmar) ---

            // Intentamos verificar la cuenta con el correo inexistente
            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.VerifyAccountAsync(nonExistentEmail, anyCode)
            );

            // Verificamos que se lanzó la excepción correcta
            Assert.Equal("No se encontró una cuenta para este correo.", exception.Message);
        }

        [Fact]
        public async Task VerifyAccountAsync_ShouldThrowException_WhenAccountIsAlreadyVerified()
        {
            // --- 1. Arrange (Organizar) ---

            // Correo de un jugador que SÍ existe y YA está verificado
            string existingVerifiedEmail = "verificado@test.com";
            string anyCode = "123456"; // El código no importa aquí

            // BD Falsa: Contiene un jugador con el email dado y is_verified = 1
            var playersData = new List<Player> {
                new Player {
                    username = "usuario_verificado",
                    email = existingVerifiedEmail,
                    is_verified = 1 // <-- YA VERIFICADO
                    // Otros campos no son relevantes para esta prueba específica
                }
            }.AsQueryable();

            // Configuramos Mocks de BD
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // No necesitamos simular SaveChangesAsync.

            // --- 2. Act & 3. Assert (Actuar y Afirmar) ---

            // Intentamos verificar la cuenta ya verificada
            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.VerifyAccountAsync(existingVerifiedEmail, anyCode)
            );

            // Verificamos el mensaje de error específico
            Assert.Equal("Esta cuenta ya está verificada.", exception.Message);
        }
     
        [Fact]
        public async Task VerifyAccountAsync_ShouldThrowException_WhenCodeIsInvalid()
        {
            // --- 1. Arrange (Organizar) ---

            // Email de un jugador que SÍ existe y NO está verificado
            string existingEmail = "porverificar@test.com";
            string correctCode = "123456"; // El código correcto guardado en la BD
            string incorrectCode = "654321"; // El código INCORRECTO que envía el usuario

            // BD Falsa: Contiene un jugador con el email, no verificado,
            // con el código correcto y una fecha de expiración futura.
            var playersData = new List<Player> {
                new Player {
                    username = "usuario_por_verificar",
                    email = existingEmail,
                    is_verified = 0, // <-- NO VERIFICADO
                    verification_code = correctCode, // <-- Código correcto guardado
                    code_expiry_date = DateTime.UtcNow.AddMinutes(10) // <-- Código NO expirado
                }
            }.AsQueryable();

            // Configuramos Mocks de BD
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // No necesitamos simular SaveChangesAsync.

            // --- 2. Act & 3. Assert (Actuar y Afirmar) ---

            // Intentamos verificar la cuenta con el código INCORRECTO
            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.VerifyAccountAsync(existingEmail, incorrectCode) // <-- Pasamos el código incorrecto
            );

            // Verificamos el mensaje de error específico para código inválido/expirado
            Assert.Equal("Código de verificación inválido o expirado.", exception.Message);
        }
       
        [Fact]
        public async Task VerifyAccountAsync_ShouldThrowException_WhenCodeIsExpired()
        {
            // --- 1. Arrange (Organizar) ---

            // Email de un jugador existente y no verificado
            string existingEmail = "codigoexpirado@test.com";
            string correctCode = "789012"; // El código correcto

            // BD Falsa: Contiene un jugador con el email, no verificado,
            // código correcto, PERO fecha de expiración EN EL PASADO.
            var playersData = new List<Player> {
                new Player {
                    username = "usuario_expirado",
                    email = existingEmail,
                    is_verified = 0, // <-- NO VERIFICADO
                    verification_code = correctCode, // <-- Código correcto
                    code_expiry_date = DateTime.UtcNow.AddMinutes(-10) // <-- EXPIRADO (hace 10 mins)
                }
            }.AsQueryable();

            // Configuramos Mocks de BD
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // No necesitamos simular SaveChangesAsync.

            // --- 2. Act & 3. Assert (Actuar y Afirmar) ---

            // Intentamos verificar la cuenta con el código correcto pero expirado
            var exception = await Assert.ThrowsAsync<Exception>(() =>
                _authLogic.VerifyAccountAsync(existingEmail, correctCode) // <-- Pasamos el código correcto
            );

            // Verificamos el mensaje de error específico para código inválido/expirado
            Assert.Equal("Código de verificación inválido o expirado.", exception.Message);
        }
       
        [Fact]
        public async Task VerifyAccountAsync_ShouldReturnSuccess_WhenCodeIsValidAndNotExpired()
        {
            // --- 1. Arrange (Organizar) ---

            // Datos para la verificación exitosa
            string existingEmail = "verificacionexitosa@test.com";
            string correctCode = "112233";

            // Creamos el jugador en la BD falsa: existe, NO verificado,
            // código CORRECTO, fecha NO expirada.
            var playerEntity = new Player
            {
                username = "usuario_a_verificar",
                email = existingEmail,
                is_verified = 0, // <-- NO VERIFICADO
                verification_code = correctCode, // <-- Código correcto
                code_expiry_date = DateTime.UtcNow.AddMinutes(15), // <-- NO expirado
                UserStatus_idUserStatus = 1 // Estado inicial Offline
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();

            // Configuramos Mocks de BD
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // Simulamos que SaveChangesAsync funciona correctamente
            _mockContext.Setup(c => c.SaveChangesAsync()) // Sin CancellationToken
                        .ReturnsAsync(1); // Simula 1 fila afectada

            // --- 2. Act (Actuar) ---

            // Ejecutamos la verificación con datos correctos
            var result = await _authLogic.VerifyAccountAsync(existingEmail, correctCode);

            // --- 3. Assert (Afirmar) ---

            // 1. Verificar que la operación fue exitosa
            Assert.True(result.Success);
            Assert.Equal("Cuenta verificada con éxito. ¡Bienvenido!", result.Message);

            // 2. Verificar que el estado del jugador se actualizó correctamente en la BD "falsa"
            Assert.Equal(1, playerEntity.is_verified); // Ahora debe ser 1 (verificado)
            Assert.Null(playerEntity.verification_code); // El código debe limpiarse
            Assert.Null(playerEntity.code_expiry_date); // La fecha de expiración debe limpiarse
            Assert.Equal(2, playerEntity.UserStatus_idUserStatus); // El estado debe ser Online (2)

            // 3. Verificar que se intentó guardar los cambios UNA VEZ
            _mockContext.Verify(c => c.SaveChangesAsync(), Times.Once); // Sin CancellationToken
        }

        [Fact]
        public void LogOut_ShouldSetUserStatusToOffline_WhenUserExists()
        {
            // --- 1. Arrange (Organizar) ---

            // Nombre de usuario existente que está "Online"
            string existingUsername = "usuario_online";
            const int StatusOnline = 2;
            const int StatusOffline = 1;

            // Creamos el jugador en la BD "falsa" con estado Online
            var playerEntity = new Player
            {
                username = existingUsername,
                email = "online@test.com",
                UserStatus_idUserStatus = StatusOnline // <-- Estado inicial Online
                // Otros campos no son relevantes
            };
            var playersData = new List<Player> { playerEntity }.AsQueryable();

            // Configuramos Mocks de BD (usando SetupData)
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // Simular SaveChanges() SÍNCRONO para que no falle
            // Devuelve 1 para simular 1 fila afectada
            _mockContext.Setup(c => c.SaveChanges()).Returns(1);

            // --- 2. Act (Actuar) ---

            // Ejecutamos el método LogOut (NO es async, así que no hay await)
            _authLogic.LogOut(existingUsername);

            // --- 3. Assert (Afirmar) ---

            // 1. Verificar que el estado del jugador se cambió a Offline (1)
            Assert.Equal(StatusOffline, playerEntity.UserStatus_idUserStatus);

            // 2. Verificar que se intentó guardar los cambios UNA VEZ
            _mockContext.Verify(c => c.SaveChanges(), Times.Once); // <-- Usamos SaveChanges() síncrono
        }

        [Fact]
        public void LogOut_ShouldDoNothing_WhenUserDoesNotExist()
        {
            // --- 1. Arrange (Organizar) ---
            string nonExistentUsername = "usuario_no_existe";

            // BD Falsa: VACÍA
            var playersData = new List<Player>().AsQueryable();
            var mockDbSet = new Mock<DbSet<Player>>().SetupData(playersData);
            _mockContext.Setup(c => c.Player).Returns(mockDbSet.Object);

            // No necesitamos simular SaveChanges, no debería llamarse.

            // --- 2. Act (Actuar) ---
            // Ejecutamos LogOut con un usuario que no existe
            _authLogic.LogOut(nonExistentUsername);

            // --- 3. Assert (Afirmar) ---
            // La principal afirmación es que NO se lanzó ninguna excepción.
            // Adicionalmente, verificamos que SaveChanges NUNCA fue llamado.
            _mockContext.Verify(c => c.SaveChanges(), Times.Never);
        }
    }   
}