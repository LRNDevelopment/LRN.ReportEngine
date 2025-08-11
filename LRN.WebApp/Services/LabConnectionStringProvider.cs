using LRN.DataLibrary;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;

namespace LRN.WebApp.Infrastructure;

public class LabConnectionStringProvider : IConnectionStringProvider
{
    private readonly IHttpContextAccessor _http;
    private readonly IConfiguration _config;

    public LabConnectionStringProvider(IHttpContextAccessor http, IConfiguration config)
    {
        _http = http;
        _config = config;
    }

    public string GetConnectionString()
    {
        var lab = _http.HttpContext?.User?.FindFirst("Lab")?.Value ?? "DefaultConnection";
        return _config.GetConnectionString(lab) ?? _config.GetConnectionString("DefaultConnection");
    }
}
