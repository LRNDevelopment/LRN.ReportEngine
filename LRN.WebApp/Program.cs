using AutoMapper;
using Common.Logging;
using DocumentFormat.OpenXml.InkML;
using DocumentFormat.OpenXml.Office2016.Drawing.ChartDrawing;
using LRN.DataLibrary;
using LRN.DataLibrary.Repository;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelGenerator;
using LRN.ExcelGenerator.Utils;
using LRN.ExcelToSqlETL.Core.Constants;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Http.Features;
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
builder.Services.AddScoped<IReportRepository, ReportRepository>();

builder.Services.AddScoped<IExcelWriter, ExcelWriter>();

builder.Services.Configure<FormOptions>(options =>
{
    options.MultipartBodyLengthLimit = 72428800; // 50 MB
});

// ✅ AutoMapper
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

// ✅ Configure constants and file paths
ConfigStaticSettings(configuration);

// ✅ Build the app
var app = builder.Build();

// ✅ Check setting from appsettings.json
var showDeveloperExceptionPage = configuration.GetValue<bool>("ShowDeveloperExceptionPage");

if (showDeveloperExceptionPage)
{
    app.UseDeveloperExceptionPage(); // Show detailed error page even in production
}
else
{
    // Generic error handler
    app.UseExceptionHandler(errorApp =>
    {
        errorApp.Run(async context =>
        {
            context.Response.StatusCode = 500;
            context.Response.ContentType = "text/html";
            await context.Response.WriteAsync("<h1>Something went wrong</h1>");
            await context.Response.WriteAsync("<p>Please contact support.</p>");
        });
    });
}

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
