using AutoMapper;
using Common.Logging;
using LRN.DataAccess.Context;
using LRN.DataAccess.Repository;
using LRN.DataAccess.Repository.Interfaces;
using LRN.DataAccess.Repository.InterFaces;
using LRN.ExcelToSqlETL.Core.Constants;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Load configuration
var configuration = builder.Configuration;

// Add services to the container
builder.Services.AddControllersWithViews();

// Authentication setup
builder.Services.AddAuthentication("Cookies")
    .AddCookie("Cookies", options =>
    {
        options.LoginPath = "/Account/Login";
    });

// Register EF DbContext
builder.Services.AddDbContext<LRNDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));


// Register dependencies
builder.Services.AddScoped<ILoggerService, LogManagerService>();
builder.Services.AddScoped<IImportFilesRepository, ImportFilesRepository>();
builder.Services.AddScoped<ILookUpRepository, LookUpRepository>();

// Register AutoMapper
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

var app = builder.Build();

// Configure static settings after building the app
ConfigStaticSettings(app.Configuration);

// Middleware
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

// MVC route
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Upload}/{action=Index}/{id?}");

// Static config initializer
static void ConfigStaticSettings(IConfiguration config)
{
    CommonConst.InputFilePath = config["FilePaths:InputFilePath"];
    CommonConst.JSONPath = config["FilePaths:JSONPath"];
    CommonConst.MappingJSONPath = config["FilePaths:MappingJSONPath"];
    CommonConst.LISMaster_Template = config["TemplatePath:LISMaster"];
    CommonConst.ProdMaster_Template = config["TemplatePath:ProdMaster"];
    CommonConst.DefaultConnection = config.GetConnectionString("DefaultConnection"); // ✅ Correct way
    CommonConst.DownloadFilePath = config["FilePaths:DownloadFilePath"];
    CommonConst.CollectionTemplate = config["TemplatePath:CollectionTemplate"];
    CommonConst.ImportFilePath = config["FilePaths:ImportFilePath"];
}

app.Run();
