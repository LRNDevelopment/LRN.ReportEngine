using Microsoft.Data.SqlClient;
using System.Data;
using System.Text.Json;
using DenialDatabaseProcessorWorker.Models;
using DenialDatabaseProcessorWorker.Normalizers;
using static DenialDatabaseProcessorWorker.Services.DenialTaskBoardRepository;

namespace DenialDatabaseProcessorWorker.BulkWriters;

public abstract class BulkWriterBase
{
    protected readonly string _connectionString;
    protected readonly string _mapperPath;

    protected BulkWriterBase(string connectionString, string mapperPath)
    {
        _connectionString = connectionString;
        _mapperPath = mapperPath;
    }

    protected async Task<BulkMapperDefinition> LoadMapperAsync()
    {
        var json = await File.ReadAllTextAsync(_mapperPath);
        return JsonSerializer.Deserialize<BulkMapperDefinition>(json)
               ?? throw new InvalidOperationException("Invalid mapper JSON");
    }

    protected static Type ResolveType(string type) =>
        type.ToLower() switch
        {
            "int" => typeof(int),
            "decimal" => typeof(decimal),
            "datetime" => typeof(DateTime),
            "date" => typeof(DateTime),
            "boolean" => typeof(bool),
            _ => typeof(string)
        };

    protected static object ConvertValue(string? val, string type)
    {
        if (string.IsNullOrWhiteSpace(val))
            return DBNull.Value;

        return type.ToLower() switch
        {
            "int" => int.TryParse(val, out var i) ? i : DBNull.Value,
            "decimal" => decimal.TryParse(val, out var d) ? d : DBNull.Value,
            "datetime" => DateTime.TryParse(val, out var dt) ? dt : DBNull.Value,
            "date" => DateTime.TryParse(val, out var dt2) ? dt2 : DBNull.Value,
            "boolean" => bool.TryParse(val, out var b) ? b : DBNull.Value,
            _ => val
        };
    }

    /// <summary>
    /// Old behavior: delete by LabId + RunId. Kept for compatibility if needed elsewhere.
    /// </summary>
    protected async Task DeleteExistingAsync(string table, int labId, string runId)
    {
        using var conn = new SqlConnection(_connectionString);
        await conn.OpenAsync();

        using var cmd = conn.CreateCommand();
        cmd.CommandText = $"DELETE FROM {table} WHERE LabId=@LabId AND RunId=@RunId";
        cmd.Parameters.AddWithValue("@LabId", labId);
        cmd.Parameters.AddWithValue("@RunId", runId);
        await cmd.ExecuteNonQueryAsync();
    }

    /// <summary>
    /// New behavior: delete all rows for a lab, irrespective of RunId.
    /// </summary>
    protected async Task DeleteByLabAsync(string table, int labId)
    {
        using var conn = new SqlConnection(_connectionString);
        await conn.OpenAsync();

        using var cmd = conn.CreateCommand();
        cmd.CommandText = $"DELETE FROM {table} WHERE LabId=@LabId";
        cmd.Parameters.AddWithValue("@LabId", labId);
        await cmd.ExecuteNonQueryAsync();
    }

    protected async Task BulkInsertAsync(DataTable table, string targetTable)
    {
        using var conn = new SqlConnection(_connectionString);
        await conn.OpenAsync();

        using var bulk = new SqlBulkCopy(conn)
        {
            DestinationTableName = targetTable
        };

        foreach (DataColumn col in table.Columns)
            bulk.ColumnMappings.Add(col.ColumnName, col.ColumnName);

        await bulk.WriteToServerAsync(table);
    }
}

public sealed class BulkMapperDefinition
{
    public string TargetTable { get; set; } = "";
    public List<BulkColumnMap> Columns { get; set; } = new();
}

public sealed class BulkColumnMap
{
    public string ExcelColumn { get; set; } = "";
    public string SqlColumn { get; set; } = "";
    public string DataType { get; set; } = "";
}