using Autofac;
using GuessMyMessServer.BusinessLogic;
using GuessMyMessServer.DataAccess;
using GuessMyMessServer.DataAccess.Abstractions;
using GuessMyMessServer.DataAccess.Repositories;
using GuessMyMessServer.Services; 
using GuessMyMessServer.Utilities.Email;
using System;

namespace GuessMyMessServer.AppStart
{
    public static class Bootstrapper
    {
        public static IContainer Container { get; private set; }
        private static bool _isInitialized;
        private static readonly object _lock = new object();

        public static void Init()
        {
            if (_isInitialized) return;

            lock (_lock)
            {
                if (_isInitialized) return;

                try
                {
                    var builder = new ContainerBuilder();

                    RegisterDataAccess(builder);
                    RegisterUtilities(builder);
                    RegisterBusinessLogic(builder);
                    RegisterServices(builder); 

                    Container = builder.Build();
                    _isInitialized = true;
                }
                catch (Exception ex)
                {
                    throw new InvalidOperationException("CRITICAL: Failed to initialize Bootstrapper.", ex);
                }
            }
        }

        private static void RegisterDataAccess(ContainerBuilder builder)
        {
            builder.RegisterType<GuessMyMessDBEntities>()
                .AsSelf()
                .InstancePerDependency();
            builder.RegisterType<PlayerRepository>().As<IPlayerRepository>();
            builder.RegisterType<MatchRepository>().As<IMatchRepository>();
            builder.RegisterType<SocialRepository>().As<ISocialRepository>();
            builder.RegisterType<AvatarRepository>().As<IAvatarRepository>();
            builder.RegisterType<SocialNetworkRepository>().As<ISocialNetworkRepository>();
            builder.RegisterType<WordRepository>().As<IWordRepository>();
        }

        private static void RegisterUtilities(ContainerBuilder builder)
        {
            builder.RegisterType<SmtpEmailService>().As<IEmailService>().SingleInstance();
        }

        private static void RegisterBusinessLogic(ContainerBuilder builder)
        {
            builder.RegisterType<AuthenticationLogic>().AsSelf();
            builder.RegisterType<UserProfileLogic>().AsSelf();
            builder.RegisterType<SocialLogic>().AsSelf();
            builder.RegisterType<MatchmakingLogic>().AsSelf();
            builder.RegisterType<LobbyLogic>().AsSelf();
            builder.RegisterType<GameLogic>().AsSelf();
        }

        private static void RegisterServices(ContainerBuilder builder)
        {
            builder.RegisterType<AuthenticationService>()
                .As<Contracts.ServiceContracts.IAuthenticationService>();

            builder.RegisterType<UserProfileService>()
                .As<Contracts.ServiceContracts.IUserProfileService>();

            builder.RegisterType<SocialService>()
                .As<Contracts.ServiceContracts.ISocialService>();

            builder.RegisterType<MatchmakingService>()
                .As<Contracts.ServiceContracts.IMatchmakingService>();

            builder.RegisterType<LobbyService>()
                .As<Contracts.ServiceContracts.ILobbyService>();

            builder.RegisterType<GameService>()
                .As<Contracts.ServiceContracts.IGameService>();
        }
    }
}