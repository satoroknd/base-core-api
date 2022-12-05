using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using AutoMapper;
using Microsoft.AspNetCore.Http;
using System.Reflection;
using Microsoft.EntityFrameworkCore;
using App.Config.DIAutoRegister;
using App.Infrastructure.Database.Context;

namespace App.Config.Dependencies
{
    public class Container
    {
        public static void Register(IServiceCollection services, IConfiguration configuration)
        {
            #region Mapper

            services.AddMemoryCache();

            services.AddAutoMapper(typeof(Container));

            var configMapper = new MapperConfiguration(cfg =>
            {
                cfg.AddProfile(new AutoMapperProfile());
            });

            var mapper = configMapper.CreateMapper();

            services.AddSingleton(mapper);

            #endregion

            #region Conexion Base de datos

            services.AddDbContext<ApplicationContext>(options =>
            {
                options.UseSqlServer(configuration.GetConnectionString("DefaultConnection"), b => b.MigrationsAssembly("AppRigoRigo"));
            });

            services.AddSingleton<IConfiguration>(configuration);

            services.AddScoped<ApplicationContext, ApplicationContext>();
            services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();

            #endregion

            #region Register DI
            var assembliesToScan = new[]
            {
                Assembly.GetExecutingAssembly(),
                Assembly.Load("App.Domain"),
                Assembly.Load("App.Infraestructure"),
                Assembly.Load("App.Common"),
            };

            services.RegisterAssemblyPublicNonGenericClasses(assembliesToScan)
                .Where(c => c.Name.EndsWith("Repository") ||
                       c.Name.EndsWith("Service") ||
                       c.Name.EndsWith("Validator") ||
                       c.Name.EndsWith("Resource"))
                .AsPublicImplementedInterfaces();

            #endregion Register DI
        }

        public static void CreateDatabase(IWebHost host)
        {
            using var scope = host.Services.CreateScope();
            var services = scope.ServiceProvider;
            try
            {
                var context = services.GetRequiredService<ApplicationContext>();
                DbInitializer.Initialize(context);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
