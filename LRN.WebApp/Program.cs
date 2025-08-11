using AutoMapper;
using Common.Logging;
using LRN.DataLibrary;
using LRN.DataLibrary.Repository;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelGenerator;
using LRN.ExcelGenerator.Utils;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.WebApp.Infrastructure;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Data;

var builder = WebApplication.CreateBuilder(args);
var configuration = builder.Configuration;

// MVC
builder.Services.AddControllersWithViews();

// Auth (cookie)
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(o => o.LoginPath = "/Account/Login");

// Needed to read Lab claim
builder.Services.AddHttpContextAccessor();

// ---------- Dapper-only wiring ----------
builder.Services.AddScoped<IConnectionStringProvider, LabConnectionStringProvider>();
builder.Services.AddScoped<DapperContext>();
builder.Services.AddScoped<IDbConnection>(sp =>
    sp.GetRequiredService<DapperContext>().CreateConnection());

// ---------- Your app services ----------
builder.Services.AddScoped<ILoggerService, LogManagerService>();
builder.Services.AddScoped<IImportFilesRepository, ImportFilesRepository>();
builder.Services.AddScoped<ILookUpRepository, LookUpRepository>();
//builder.Services.AddScoped<IReportRepository, ReportRepository>();
//builder.Services.AddScoped<IExcelWriter, ExcelWriter>();

// AutoMapper
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

// (Optional) request size limits
builder.WebHost.ConfigureKestrel(o => o.Limits.MaxRequestBodySize = 104_857_600);

// Constants
ConfigStaticSettings(configuration);

var app = builder.Build();

// Errors
var showDev = configuration.GetValue<bool>("ShowDeveloperExceptionPage");
if (showDev) app.UseDeveloperExceptionPage();
else
{
    app.UseExceptionHandler(errorApp =>
    {
        errorApp.Run(async context =>
        {
            context.Response.StatusCode = 500;
            context.Response.ContentType = "text/html";
            await context.Response.WriteAsync("<h1>Something went wrong</h1><p>Please contact support.</p>");
        });
    });
}

// Pipeline
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute("default", "{controller=Upload}/{action=Index}/{id?}");

app.Run();

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
