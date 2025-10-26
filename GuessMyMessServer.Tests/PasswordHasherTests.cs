using Xunit;
using GuessMyMessServer.Utilities;

namespace GuessMyMessServer.Tests
{
    public class PasswordHasherTests
    {
        [Fact]
        public void VerifyPasswordShouldReturnTrueForCorrectPassword()
        {
            string plainPassword = "miPasswordSeguro123";
            string hashedPassword = PasswordHasher.HashPassword(plainPassword);

            bool isVerified = PasswordHasher.VerifyPassword(plainPassword, hashedPassword);

            Assert.True(isVerified);
        }

        [Fact]
        public void VerifyPasswordShouldReturnFalseForIncorrectPassword()
        {
            string correctPassword = "miPasswordSeguro123";
            string wrongPassword = "PasswordIncorrecto";

            string hashedPassword = PasswordHasher.HashPassword(correctPassword);

            bool isVerified = PasswordHasher.VerifyPassword(wrongPassword, hashedPassword);

            Assert.False(isVerified);
        }

        [Fact]
        public void HashPasswordShouldNotReturnOriginalPassword()
        {
            string plainPassword = "unPasswordCualquiera";
            string hashedPassword = PasswordHasher.HashPassword(plainPassword);

            Assert.NotEmpty(hashedPassword);
            Assert.NotEqual(plainPassword, hashedPassword);
        }
    }
}