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

// Authentication setup (cookie authentication)
builder.Services.AddAuthentication("Cookies")
    .AddCookie("Cookies", options =>
    {
        options.LoginPath = "/Account/Login"; // Define where users will be redirected if not authenticated
    });

// Register EF DbContext with SQL Server
builder.Services.AddDbContext<LRNDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"))
);

// Register scoped dependencies (for Dependency Injection)
builder.Services.AddScoped<ILoggerService, LogManagerService>();
builder.Services.AddScoped<IImportFilesRepository, ImportFilesRepository>();
builder.Services.AddScoped<ILookUpRepository, LookUpRepository>();

// Register AutoMapper (for object-to-object mapping)
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

// Configure static settings (if you have static file paths or config settings)
ConfigStaticSettings(builder.Configuration);

var app = builder.Build();

// Middleware setup
app.UseStaticFiles();    // Serve static files (e.g., images, CSS, JavaScript)
app.UseRouting();        // Enable routing
app.UseAuthentication(); // Enable authentication
app.UseAuthorization();  // Enable authorization

// Define MVC routes (default controller and action)
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Upload}/{action=Index}/{id?}"
);

// Start the application
app.Run();

// Static settings initialization method (configures paths and constants)
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
