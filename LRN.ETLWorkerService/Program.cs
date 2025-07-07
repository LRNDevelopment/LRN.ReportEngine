using Common.Logging;
using LRN.DataLibrary;
using LRN.DataLibrary.Repository;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelETL.Service.Services;
using LRN.ExcelGenerator.Utils;
using LRN.ExcelToSqlETL.Core.Interface;
using Microsoft.EntityFrameworkCore;

namespace LRN.ETLWorkerService
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args)
        {
            return Host.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration((context, config) =>
                {
                    config.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
                })
                .ConfigureServices((hostContext, services) =>
                {
                    IConfiguration configuration = hostContext.Configuration;

                    // Register services for the database context
                    services.AddDbContext<LRNDbContext>(options =>
                        options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

                    // Register AutoMapper and specify the assembly containing your profiles
                    services.AddAutoMapper(typeof(Program).Assembly);

                    // Register DapperContext (Singleton is fine here since it's a database connection context that doesn't depend on per-request lifetimes)
                    services.AddSingleton<DapperContext>(sp =>
                        new DapperContext(configuration.GetConnectionString("DefaultConnection")));

                    // Register scoped services (ExcelETL services depend on DB Context and Repo)
                    services.AddScoped<ILoggerService, LogManagerService>();
                    services.AddScoped<IExcelMapperLoader, JsonExcelMapperLoader>();
                    services.AddScoped<IFileReader, ExcelFileReader>();
                    services.AddScoped<IDataValidator, MappingValidator>();
                    services.AddScoped<IDataImporter, SqlDataImporter>();
                    services.AddScoped<ExcelEtlProcessor>();
                    services.AddScoped<ExcelWriter>();

                    // Add Repositories (Scoped since they depend on DB Context)
                    services.AddScoped<IImportFilesRepository, ImportFilesRepository>();
                    services.AddScoped<IReportRepository, ReportRepository>();

                    // Register the worker service as scoped (it consumes scoped services)
                    services.AddScoped<FileProcessingWorker>();

                    // Register the hosted service (background worker)
                    services.AddHostedService<FileProcessingWorker>();
                });
        }
    }
}
