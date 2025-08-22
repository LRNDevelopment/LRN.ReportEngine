using Common.Logging;
using LRN.DataLibrary;
using LRN.DataLibrary.Repository;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelETL.Service.Services;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.Interface;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Configuration;
using System.IO;
using System.Windows.Forms;

namespace ExcelETLWinApp
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            var host = Host.CreateDefaultBuilder()
                .ConfigureAppConfiguration((context, config) =>
                {
                    config.SetBasePath(Directory.GetCurrentDirectory());
                    config.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
                })
                .ConfigureServices((context, services) =>
                {
                    // Register config sections
                    services.Configure<AppSettings>(context.Configuration.GetSection("AppSettings"));

                    IConfiguration configuration = context.Configuration;

                    // Register DbContext
                    //services.AddDbContext<LRNDbContext>(options =>
                    //    options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

                    // Register application services
                    services.AddSingleton<ILoggerService, LogManagerService>();
                    services.AddSingleton<IExcelMapperLoader, JsonExcelMapperLoader>();
                    services.AddSingleton<IFileReader, ExcelFileReader>();
                    services.AddSingleton<IDataValidator, MappingValidator>();
                    services.AddSingleton<IDataImporter, SqlDataImporter>();
                    services.AddSingleton<ExcelEtlProcessor>();

                    // Register repository with scoped lifetime
                    //services.AddScoped<IImportFilesRepository, ImportFilesRepository>();
                    services.AddAutoMapper(typeof(MappingProfile));

                    // Add logging
                    services.AddLogging(configure => configure.AddConsole());

                    // Set static config
                    ConfigStaticSettings(configuration);

                    // Register MainForm
                    services.AddTransient<MainForm>();
                })
                .Build();

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            // Resolve and run form
            var mainForm = host.Services.GetRequiredService<MainForm>();
            Application.Run(mainForm);
        }

        static void ConfigStaticSettings(IConfiguration config)
        {
            CommonConst.InputFilePath = config["FilePaths:InputFilePath"];
            CommonConst.JSONPath = config["FilePaths:JSONPath"];
            CommonConst.MappingJSONPath = config["FilePaths:MappingJSONPath"];
        }
    }

    public class AppSettings
    {
        public string UploadApiUrl { get; set; }
        public string DownloadApiUrl { get; set; }
        public string ETLApiUrl { get; set; }
    }

    public class DatabaseConfig
    {
        public string ConnectionString { get; set; }
    }
}
