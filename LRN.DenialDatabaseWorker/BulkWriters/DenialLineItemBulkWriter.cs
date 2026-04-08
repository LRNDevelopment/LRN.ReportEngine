using DenialDatabaseProcessorWorker.Models;
using System.Data;

namespace DenialDatabaseProcessorWorker.BulkWriters;

public sealed class DenialLineItemBulkWriter : BulkWriterBase
{
    public DenialLineItemBulkWriter(string connectionString, string mapperPath)
        : base(connectionString, mapperPath) { }

    public async Task WriteAsync(List<Dictionary<string, string>> rows, LabConfig lab, string runId)
    {
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

            dr["LabId"] = lab.LabId;
            dr["LabName"] = lab.LabName;
            dr["RunId"] = runId;
            dr["CreatedOn"] = DateTime.UtcNow;

            table.Rows.Add(dr);
        }

        await BulkInsertAsync(table, mapper.TargetTable);
    }
}