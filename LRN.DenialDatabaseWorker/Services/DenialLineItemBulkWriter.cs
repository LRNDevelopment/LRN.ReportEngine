using DenialDatabaseProcessorWorker.Models;
using DocumentFormat.OpenXml.InkML;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Text.Json;

namespace DenialDatabaseProcessorWorker.Services
{
	public class DenialLineItemBulkWriter
	{
		private readonly string _connectionString;

		public DenialLineItemBulkWriter(IConfiguration config)
		{
			_connectionString = config.GetConnectionString("DenialDatabase");
		}

		public async Task BulkInsertAsync(List<Dictionary<string, string>> rows, LabContext lab)
		{
			var json = await File.ReadAllTextAsync("MapperJon/DenialLineItemMapper.json");
			var mapper = JsonSerializer.Deserialize<TaskBoardMapper>(json);

			// Filter: only rows with DenialCode_Normalized
			var filtered = rows
				.Where(r => !string.IsNullOrWhiteSpace(r.GetValueOrDefault("DenialCode_Normalized")))
				.ToList();

			var table = new DataTable();
			foreach (var col in mapper.Columns)
				table.Columns.Add(col.SqlColumn, ResolveType(col.DataType));

			foreach (var row in filtered)
			{
				var dr = table.NewRow();

				foreach (var col in mapper.Columns)
				{
					var val = row.GetValueOrDefault(col.ExcelColumn) ?? "";
					dr[col.SqlColumn] = ConvertValue(val, col.DataType);
				}

				// Inject common fields
				dr["LabId"] = lab.LabId;
				dr["LabName"] = lab.LabName;
				dr["RunId"] = lab.RunId;
				dr["CreatedOn"] = lab.CreatedOn;

				table.Rows.Add(dr);
			}

			await using var conn = new SqlConnection(_connectionString);
			await conn.OpenAsync();

			var deleteSql = $"DELETE FROM {mapper.TargetTable} WHERE LabId = @LabId";
			await using (var cmd = new SqlCommand(deleteSql, conn))
			{
				cmd.Parameters.AddWithValue("@LabId", lab.LabId);
				await cmd.ExecuteNonQueryAsync();
			}

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

}
