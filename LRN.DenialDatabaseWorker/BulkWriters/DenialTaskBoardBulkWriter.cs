using DenialDatabaseProcessorWorker.Models;
using System.Data;

namespace DenialDatabaseProcessorWorker.BulkWriters;

public sealed class DenialTaskBoardBulkWriter : BulkWriterBase
{
	public DenialTaskBoardBulkWriter(string connectionString, string mapperPath)
		: base(connectionString, mapperPath) { }

	public async Task WriteAsync(List<Dictionary<string, string>> rows, LabConfig lab, string runId)
	{
		if (rows == null || rows.Count == 0)
			return;

		var mapper = await LoadMapperAsync();

		// Delete existing rows for this lab/run
		await DeleteExistingAsync(mapper.TargetTable, lab.LabId, runId);

		var table = new DataTable();
		foreach (var col in mapper.Columns)
			table.Columns.Add(col.SqlColumn, ResolveType(col.DataType));

		foreach (var row in rows)
		{
			var dr = table.NewRow();

			foreach (var col in mapper.Columns)
			{
				var val = row.GetValueOrDefault(col.ExcelColumn);
				dr[col.SqlColumn] = ConvertValue(val, col.DataType);
			}

			// If LabId/LabName/RunId/CreatedOn are not mapped via JSON,
			// ensure they exist in mapper and in TaskBoardBuilder rows.
			table.Rows.Add(dr);
		}

		await BulkInsertAsync(table, mapper.TargetTable);
	}
}