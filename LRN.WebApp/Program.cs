using AutoMapper;
using Common.Logging;
using LRN.DataAccess.Context;
using LRN.DataAccess.Repository;
using LRN.DataAccess.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Constants;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add MVC
builder.Services.AddControllersWithViews();

// Auth
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

// 🔧 Register AutoMapper
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

var app = builder.Build();

// Middleware
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Upload}/{action=Index}/{id?}");

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


app.Run();
