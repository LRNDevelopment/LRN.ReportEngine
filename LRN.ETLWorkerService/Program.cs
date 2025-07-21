using Common.Logging;
using LRN.DataLibrary;
using LRN.DataLibrary.Repository;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelETL.Service.Services;
using LRN.ExcelGenerator.Utils;
using LRN.ExcelToSqlETL.Core.Constants;
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
                .UseWindowsService() // ✅ Required for running as a Windows Service
                .ConfigureAppConfiguration((context, config) =>
                {
                    config.AddJsonFile("appsettings.etl.json", optional: false, reloadOnChange: true);
                })
                .ConfigureServices((hostContext, services) =>
                {
                    IConfiguration configuration = hostContext.Configuration;

                    // EF Core DbContext
                    services.AddDbContext<LRNDbContext>(options =>
                        options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

                    // AutoMapper
                    services.AddAutoMapper(typeof(Program).Assembly);

                    // Singleton for Dapper context
                    services.AddSingleton<DapperContext>(sp =>
                        new DapperContext(configuration.GetConnectionString("DefaultConnection")));

                    // Scoped Services
                    services.AddScoped<ILoggerService, LogManagerService>();
                    services.AddScoped<IExcelMapperLoader, JsonExcelMapperLoader>();
                    services.AddScoped<IFileReader, ExcelFileReader>();
                    services.AddScoped<IDataValidator, MappingValidator>();
                    services.AddScoped<IFileCSVReader, CSVFileReader>();
                    services.AddScoped<IDataImporter, SqlDataImporter>();
                    services.AddScoped<ExcelEtlProcessor>();
                    services.AddScoped<ExcelWriter>();

                    // Repositories
                    services.AddScoped<IImportFilesRepository, ImportFilesRepository>();
                    services.AddScoped<IReportRepository, ReportRepository>();

                    // Config shared constants
                    ConfigStaticSettings(configuration);

                    // Register background worker
                    services.AddHostedService<FileProcessingWorker>();
                });
        }

        static void ConfigStaticSettings(IConfiguration config)
        {
            CommonConst.InputFilePath = config["FilePaths:InputFilePath"];
            CommonConst.JSONPath = config["FilePaths:JSONPath"];
            CommonConst.MappingJSONPath = config["FilePaths:MappingJSONPath"];
            CommonConst.LISMaster_Template = config["TemplatePath:LISMaster"];
            CommonConst.ProdMaster_Template = config["TemplatePath:ProdMaster"];
            CommonConst.DefaultConnection = config["ConnectionStrings:DefaultConnection"];
            CommonConst.DownloadFilePath = config["FilePaths:DownloadFilePath"];
            CommonConst.CollectionTemplate = config["TemplatePath:CollectionTemplate"];
            CommonConst.ImportFilePath = config["TemplatePath:ImportFilePath"];
        }
    }
}
