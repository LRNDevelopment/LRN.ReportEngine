using LRN.DataLibrary;
using Microsoft.Extensions.Configuration;

namespace LRN.ETLWorkerService;

public class LabConnectionStringProvider : IConnectionStringProvider
{
    private readonly IConfiguration _config;

    public LabConnectionStringProvider(IConfiguration config) => _config = config;

    public string GetConnectionString()
    {
        var activeLab = _config["ActiveLab"];
        if (!string.IsNullOrWhiteSpace(activeLab))
        {
            var cs = _config.GetConnectionString(activeLab);
            if (!string.IsNullOrWhiteSpace(cs)) return cs;
        }
        return _config.GetConnectionString("DefaultConnection");
    }
}
