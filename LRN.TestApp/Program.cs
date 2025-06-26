using Common.Logging;
using LRN.DataAccess.Context;
using LRN.DataAccess.Repository;
using LRN.DataAccess.Repository.Interfaces;
using LRN.DataAccess.Repository.InterFaces;
using LRN.ExcelETL.Service.Services;
using LRN.ExcelGenerator.Utils;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.Interface;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var host = Host.CreateDefaultBuilder(args)
    .ConfigureAppConfiguration((context, config) =>
    {
        config.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
    })
    .ConfigureServices((context, services) =>
    {
        IConfiguration configuration = context.Configuration;

        // Register DbContext
        services.AddDbContext<LRNDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        // Register application services
        services.AddSingleton<ILoggerService, LogManagerService>();
        services.AddSingleton<IExcelMapperLoader, JsonExcelMapperLoader>();
        services.AddSingleton<IFileReader, ExcelFileReader>();
        services.AddSingleton<IDataValidator, MappingValidator>();
        services.AddSingleton<IDataImporter, SqlDataImporter>();
        services.AddSingleton<ExcelEtlProcessor>();
        services.AddSingleton<ExcelWriter>();

        // Register repository with scoped lifetime
        services.AddScoped<IImportFilesRepository, ImportFilesRepository>();
        services.AddScoped<IReportRepository, ReportRepository>();
        services.AddAutoMapper(typeof(MappingProfile));

        // Set static config
        ConfigStaticSettings(configuration);


    })
    .Build();

//////// Run the ETL processor
//var app = host.Services.GetRequiredService<ExcelEtlProcessor>();
//await app.RunAsync();

var app = host.Services.GetRequiredService<ExcelWriter>();
await app.RunAsync();

static void ConfigStaticSettings(IConfiguration config)
{
    CommonConst.InputFilePath = config["FilePaths:InputFilePath"];
    CommonConst.JSONPath = config["FilePaths:JSONPath"];
    CommonConst.MappingJSONPath = config["FilePaths:MappingJSONPath"];
    CommonConst.LISMaster_Template = config["TemplatePath:LISMaster"];
    CommonConst.ProdMaster_Template = config["TemplatePath:ProdMaster"];
    CommonConst.DefaultConnection = config["ConnectionStrings:DefaultConnection"];
    CommonConst.DownloadFilePath = config["FilePaths:DownloadFilePath"];
}
