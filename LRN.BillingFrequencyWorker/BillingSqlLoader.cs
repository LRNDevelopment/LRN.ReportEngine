using Microsoft.Data.SqlClient;
using System.Data;

public static class BillingSqlLoader
{
	public static async Task ReplaceLabDataAsync(
		string connStr,
		string destinationTable,
		int labId,
		DataTable countsDt,
		CancellationToken ct)
	{
		using var conn = new SqlConnection(connStr);
		await conn.OpenAsync(ct);

		using var tran = conn.BeginTransaction();

		try
		{
			// 1) Delete existing data for lab
			using (var cmd = new SqlCommand($"DELETE FROM {destinationTable} WHERE LabId = @LabId;", conn, tran))
			{
				cmd.Parameters.AddWithValue("@LabId", labId);
				await cmd.ExecuteNonQueryAsync(ct);
			}

			// 2) Bulk copy new data
			using (var bulk = new SqlBulkCopy(conn, SqlBulkCopyOptions.TableLock, tran))
			{
				bulk.DestinationTableName = destinationTable;
				bulk.BatchSize = 5000;
				bulk.BulkCopyTimeout = 0;

				bulk.ColumnMappings.Add("LabId", "LabId");
				bulk.ColumnMappings.Add("ChartNumber", "ChartNumber");
				bulk.ColumnMappings.Add("PanelCarrier", "PanelCarrier");
				bulk.ColumnMappings.Add("CPTCode", "CPTCode");
				bulk.ColumnMappings.Add("PeriodType", "PeriodType");
				bulk.ColumnMappings.Add("PeriodStart", "PeriodStart");
				bulk.ColumnMappings.Add("UniqueBillingCount", "UniqueBillingCount");

				await bulk.WriteToServerAsync(countsDt, ct);
			}

			await tran.CommitAsync(ct);
		}
		catch
		{
			await tran.RollbackAsync(ct);
			throw;
		}
	}
}
