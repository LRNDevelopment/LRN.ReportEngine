using AutoMapper;
using Common.Logging;
using LRN.DataLibrary;
using LRN.DataLibrary.Repository;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Constants;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;
using System.Configuration;
using System.Data;

var builder = WebApplication.CreateBuilder(args);

// Load configuration
var configuration = builder.Configuration;

// Add services to the container
builder.Services.AddControllersWithViews();

// ✅ Configure Cookie Authentication
builder.Services.AddAuthentication("Cookies")
    .AddCookie("Cookies", options =>
    {
        options.LoginPath = "/Account/Login";
    });

// ✅ Register DapperContext
builder.Services.AddSingleton<DapperContext>(sp =>
    new DapperContext(configuration.GetConnectionString("DefaultConnection")!)
);
builder.Services.AddDbContext<LRNDbContext>(options =>
    options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

// ✅ Optionally register IDbConnection if you inject it directly
builder.Services.AddScoped<IDbConnection>(sp =>
{
    var context = sp.GetRequiredService<DapperContext>();
    return context.CreateConnection();
});

// ✅ Register application services
builder.Services.AddScoped<ILoggerService, LogManagerService>();
builder.Services.AddScoped<IImportFilesRepository, ImportFilesRepository>();
builder.Services.AddScoped<ILookUpRepository, LookUpRepository>();

// ✅ AutoMapper
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

// ✅ Configure constants and file paths
ConfigStaticSettings(configuration);

var app = builder.Build();

// ✅ Middleware
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Upload}/{action=Index}/{id?}"
);

app.Run();

// ✅ Static config method
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
}
