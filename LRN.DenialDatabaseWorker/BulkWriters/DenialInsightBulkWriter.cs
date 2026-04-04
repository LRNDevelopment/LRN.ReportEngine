using DenialDatabaseProcessorWorker.Services;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Text.Json;

namespace DenialDatabaseProcessorWorker.BulkWriters;

public sealed class DenialInsightBulkWriter
{
	private readonly string _connectionString;

	public DenialInsightBulkWriter(IConfiguration config)
	{
		_connectionString = config.GetConnectionString("DenialDatabase");
	}

	public async Task BulkInsertAsync(List<Dictionary<string, string>> insightRows, LabContext context)
	{
		// Load mapper
		var json = await File.ReadAllTextAsync("MapperJon/DenialInsightMapper.json");
		var mapper = JsonSerializer.Deserialize<TaskBoardMapper>(json);

		// Build DataTable
		var table = new DataTable();
		foreach (var col in mapper.Columns)
			table.Columns.Add(col.SqlColumn, ResolveType(col.DataType));

		// Fill rows
		foreach (var row in insightRows)
		{
			var dr = table.NewRow();

			foreach (var col in mapper.Columns)
			{
				var val = row.GetValueOrDefault(col.ExcelColumn) ?? "";
				dr[col.SqlColumn] = ConvertValue(val, col.DataType);
			}

			// Inject common fields
			dr["LabId"] = context.LabId;
			dr["LabName"] = context.LabName;
			dr["RunId"] = context.RunId;
			dr["CreatedOn"] = context.CreatedOn;

			table.Rows.Add(dr);
		}

		await using var conn = new SqlConnection(_connectionString);
		await conn.OpenAsync();

		// Delete existing rows for this lab
		var deleteSql = $"DELETE FROM {mapper.TargetTable} WHERE LabId = @LabId";
		await using (var cmd = new SqlCommand(deleteSql, conn))
		{
			cmd.Parameters.AddWithValue("@LabId", context.LabId);
			await cmd.ExecuteNonQueryAsync();
		}

		// Bulk copy
		using var bulk = new SqlBulkCopy(conn)
		{
			DestinationTableName = mapper.TargetTable
		};

		foreach (var col in mapper.Columns)
			bulk.ColumnMappings.Add(col.SqlColumn, col.SqlColumn);

		await bulk.WriteToServerAsync(table);
	}

	private static Type ResolveType(string type) =>
		type.ToLower() switch
		{
			"int" => typeof(int),
			"decimal" => typeof(decimal),
			"datetime" => typeof(DateTime),
			"date" => typeof(DateTime),
			_ => typeof(string)
		};

	private static object ConvertValue(string val, string type)
	{
		if (string.IsNullOrWhiteSpace(val))
			return DBNull.Value;

		return type.ToLower() switch
		{
			"int" => int.TryParse(val, out var i) ? i : 0,
			"decimal" => decimal.TryParse(val, out var d) ? d : 0,
			"datetime" => DateTime.TryParse(val, out var dt) ? dt : DateTime.UtcNow,
			"date" => DateTime.TryParse(val, out var dt2) ? dt2 : DateTime.UtcNow,
			_ => val
		};
	}
}