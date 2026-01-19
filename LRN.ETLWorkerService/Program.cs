using Common.Logging;
using LRN.DataLibrary;
using LRN.DataLibrary.Repository;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelETL.Service.Services;
using LRN.ExcelGenerator.Utils;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.Interface;
using Microsoft.Extensions.DependencyInjection;
using System.Data;

namespace LRN.ETLWorkerService
{
    public class Program
    {
        public static void Main(string[] args) => CreateHostBuilder(args).Build().Run();

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .UseWindowsService()
                .ConfigureAppConfiguration((context, config) =>
                {
                    config.AddJsonFile("appsettings.etl.json", optional: false, reloadOnChange: true);
                })
                .ConfigureServices((hostContext, services) =>
                {
                    var configuration = hostContext.Configuration;

                    // Dapper-only
                    services.AddSingleton<IConnectionStringProvider, LabConnectionStringProvider>();
                    services.AddScoped<DapperContext>();
                    services.AddScoped<IDbConnection>(sp =>
                        sp.GetRequiredService<DapperContext>().CreateConnection());

                    // App services
                    services.AddAutoMapper(typeof(Program).Assembly);
                    //services.AddScoped<ILoggerService, LogManagerService>();
                    services.AddSingleton<ILoggerService, LogManagerService>();


                    services.AddScoped<IExcelMapperLoader, JsonExcelMapperLoader>();
                    services.AddScoped<IFileReader, ExcelFileReader>();
                    services.AddScoped<IDataValidator, MappingValidator>();
                    services.AddScoped<IFileCSVReader, CSVFileReader>();
                    services.AddScoped<IDataImporter, SqlDataImporter>();
                    services.AddScoped<ExcelEtlProcessor>();
                    //services.AddScoped<ExcelWriter>();

                    // Repos (Dapper)
                    services.AddScoped<IImportFilesRepository, ImportFilesRepository>();
                    //services.AddScoped<IReportRepository, ReportRepository>();
                    services.AddScoped<ILookUpRepository, LookUpRepository>();

                    // Constants
                    ConfigStaticSettings(configuration);

                    // Worker
                    services.AddHostedService<FileProcessingWorker>();
                });

        static void ConfigStaticSettings(IConfiguration config)
        {
            CommonConst.InputFilePath = config["FilePaths:InputFilePath"];
            CommonConst.JSONPath = config["FilePaths:JSONPath"];
            CommonConst.MappingJSONPath = config["FilePaths:MappingJSONPath"];
            CommonConst.LISMaster_Template = config["TemplatePath:LISMaster"];
            CommonConst.ProdMaster_Template = config["TemplatePath:ProdMaster"];
            CommonConst.DefaultConnection = config.GetConnectionString("DefaultConnection");
            CommonConst.DownloadFilePath = config["FilePaths:DownloadFilePath"];
            CommonConst.CollectionTemplate = config["TemplatePath:CollectionTemplate"];
            CommonConst.ImportFilePath = config["FilePaths:ImportFilePath"];
            CommonConst.MasterFilesPath = config["FilePaths:MasterFilesPath"];
            CommonConst.ArchiveFilesPath = config["FilePaths:ArchiveFilesPath"];
        }
    }
}
