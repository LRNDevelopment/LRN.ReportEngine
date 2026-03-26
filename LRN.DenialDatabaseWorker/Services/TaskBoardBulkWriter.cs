using System;
using System.Data;
using System.IO;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace DenialDatabaseProcessorWorker.Services;

public sealed class TaskBoardBulkWriter
{
	private readonly string _connectionString;
	private readonly TaskBoardMapper _mapper;

	public TaskBoardBulkWriter(IConfiguration configuration)
	{
		_connectionString = configuration.GetConnectionString("DenialDatabase")
							?? throw new InvalidOperationException("Connection string 'DenialDatabase' not found.");

		var mapperPath = configuration["DenialDatabaseProcessor:TaskBoardMapperPath"];
		if (string.IsNullOrWhiteSpace(mapperPath) || !File.Exists(mapperPath))
			throw new FileNotFoundException("TaskBoard mapper JSON not found.", mapperPath);

		var json = File.ReadAllText(mapperPath);
		_mapper = JsonSerializer.Deserialize<TaskBoardMapper>(json)
				  ?? throw new InvalidOperationException("Failed to deserialize TaskBoardMapper.json");
	}

	public async Task BulkInsertAsync(
		System.Collections.Generic.List<System.Collections.Generic.Dictionary<string, string>> taskRows,
		int labId)
	{
		if (taskRows == null || taskRows.Count == 0)
			return;

		using var dt = new DataTable();

		foreach (var col in _mapper.Columns)
		{
			var type = GetTypeFromDataType(col.DataType);
			dt.Columns.Add(col.SqlColumn, type);
		}

		foreach (var row in taskRows)
		{
			var dr = dt.NewRow();
			foreach (var col in _mapper.Columns)
			{
				var excelKey = col.ExcelColumn;
				var sqlCol = col.SqlColumn;
				var dataType = col.DataType;

				var raw = row.TryGetValue(excelKey, out var v) ? v : null;
				dr[sqlCol] = ConvertValue(raw, dataType);
			}
			dt.Rows.Add(dr);
		}

		await using var conn = new SqlConnection(_connectionString);
		await conn.OpenAsync().ConfigureAwait(false);

		// Delete existing rows for this LabId
		const string deleteSql = "DELETE FROM dbo.DenialTaskBoard WHERE LabId = @LabId";
		await using (var deleteCmd = new SqlCommand(deleteSql, conn))
		{
			deleteCmd.Parameters.AddWithValue("@LabId", labId);
			await deleteCmd.ExecuteNonQueryAsync().ConfigureAwait(false);
		}

		using var bulk = new SqlBulkCopy(conn)
		{
			DestinationTableName = _mapper.TargetTable
		};

		foreach (var col in _mapper.Columns)
			bulk.ColumnMappings.Add(col.SqlColumn, col.SqlColumn);

		await bulk.WriteToServerAsync(dt).ConfigureAwait(false);
	}

	private static Type GetTypeFromDataType(string dataType) =>
		dataType.ToLowerInvariant() switch
		{
			"int" => typeof(int),
			"date" => typeof(DateTime),
			"datetime" => typeof(DateTime),
			"datetime2" => typeof(DateTime),
			"string" => typeof(string),
			_ => typeof(string)
		};

	private static object ConvertValue(string? raw, string dataType)
	{
		if (string.IsNullOrWhiteSpace(raw))
			return DBNull.Value;

		return dataType.ToLowerInvariant() switch
		{
			"int" => int.TryParse(raw, out var i) ? i : DBNull.Value,
			"date" or "datetime" or "datetime2" =>
				DateTime.TryParse(raw, out var dt) ? dt : DBNull.Value,
			_ => raw
		};
	}
}