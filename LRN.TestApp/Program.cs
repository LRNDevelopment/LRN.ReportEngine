using Common.Logging;
using LRN.DataLibrary;
using LRN.DataLibrary.Repository;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelETL.Service.Services;
using LRN.ExcelGenerator.Utils;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.Interface;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using AutoMapper;

var host = Host.CreateDefaultBuilder(args)
    .ConfigureAppConfiguration((context, config) =>
    {
        config.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
    })
    .ConfigureServices((context, services) =>
    {
        IConfiguration configuration = context.Configuration;

        // ✅ EF Core
        services.AddDbContext<LRN.DataLibrary.LRNDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        // ✅ AutoMapper
        services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

        // ✅ Dapper Context
        services.AddSingleton<DapperContext>(sp =>
            new DapperContext(configuration.GetConnectionString("DefaultConnection")!));

        // ✅ Core & Utility Services
        services.AddSingleton<ILoggerService, LogManagerService>();
        services.AddSingleton<IExcelMapperLoader, JsonExcelMapperLoader>();
        services.AddSingleton<IFileReader, ExcelFileReader>();
        services.AddSingleton<IDataValidator, MappingValidator>();
        services.AddSingleton<IDataImporter, SqlDataImporter>();

        // ✅ ETL Runners
        services.AddSingleton<ExcelEtlProcessor>();
        services.AddSingleton<ExcelWriter>();

        // ✅ Repositories
        services.AddScoped<IImportFilesRepository, ImportFilesRepository>();
        services.AddScoped<IReportRepository, ReportRepository>(); // Uses EF Core + manual + Dapper

        // ✅ Static config constants
        ConfigStaticSettings(configuration);
    })
    .Build();


// ✅ Entry Point – you can switch to ETL if needed
var excelWriter = host.Services.GetRequiredService<ExcelWriter>();
await excelWriter.RunAsync();


// ✅ Global Configuration
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
