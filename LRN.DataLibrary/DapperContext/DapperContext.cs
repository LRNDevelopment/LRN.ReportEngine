using LRN.DataLibrary;
using Microsoft.Data.SqlClient;
using System.Data;

public class DapperContext
{
    private readonly IConnectionStringProvider _provider;

    public DapperContext(IConnectionStringProvider provider)
    {
        _provider = provider;
    }

    public IDbConnection CreateConnection()
    {
        var cs = _provider.GetConnectionString();
        return new SqlConnection(cs);
    }
}
