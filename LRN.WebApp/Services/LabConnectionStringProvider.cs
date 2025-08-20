using LRN.DataLibrary;

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
        var connKey = _http.HttpContext?.User?.FindFirst("Lab")?.Value
                      ?? "DefaultConnection";

        return _config.GetConnectionString(connKey)
               ?? _config.GetConnectionString("DefaultConnection");
    }
}
