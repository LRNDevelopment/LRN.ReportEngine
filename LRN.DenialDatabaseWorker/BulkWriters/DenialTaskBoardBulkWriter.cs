using DenialDatabaseProcessorWorker.Models;
using System.Data;

namespace DenialDatabaseProcessorWorker.BulkWriters;
public sealed class DenialTaskBoardBulkWriter : BulkWriterBase
{
    public DenialTaskBoardBulkWriter(string connectionString, string mapperPath)
        : base(connectionString, mapperPath) { }

    /// <summary>
    /// rows here are already the merged result from TaskBoardBuilder:
    /// - New + existing tasks merged
    /// - TaskId reused where key matches
    /// - Old tasks not in new list carried as Closed
    /// </summary>
    public async Task WriteAsync(List<Dictionary<string, string>> rows, LabConfig lab, string runId)
    {
        if (rows == null || rows.Count == 0)
            return;

        var mapper = await LoadMapperAsync();

        // NEW: delete all rows for this lab, irrespective of RunId
        await DeleteByLabAsync(mapper.TargetTable, lab.LabId);

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

            table.Rows.Add(dr);
        }

        await BulkInsertAsync(table, mapper.TargetTable);
    }
}