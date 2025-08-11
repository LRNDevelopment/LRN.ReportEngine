using System.Data;
using Microsoft.Data.SqlClient;

namespace LRN.DataLibrary;

public class DapperContext
{
    private readonly IConnectionStringProvider _provider;

    public DapperContext(IConnectionStringProvider provider)
    {
        _provider = provider;
    }

    public IDbConnection CreateConnection()
        => new SqlConnection(_provider.GetConnectionString());
}
