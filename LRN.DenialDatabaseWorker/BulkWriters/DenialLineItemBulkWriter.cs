using Microsoft.Data.SqlClient;

public sealed class DenialLineItemBulkWriter
{
	private readonly string _connectionString;
	private readonly string _mapperPath;

	public DenialLineItemBulkWriter(string connectionString, string mapperPath)
	{
		_connectionString = connectionString;
		_mapperPath = mapperPath;
	}

	public async Task BulkInsertAsync(List<Dictionary<string, string>> rows, LabContext lab)
	{
		// 1. Delete existing rows for this lab/run
		using (var conn = new SqlConnection(_connectionString))
		{
			await conn.OpenAsync();

			using (var cmd = conn.CreateCommand())
			{
				cmd.CommandText = @"DELETE FROM dbo.DenialLineItem
									WHERE LabId = @LabId AND RunId = @RunId;";
				cmd.Parameters.AddWithValue("@LabId", lab.LabId);
				cmd.Parameters.AddWithValue("@RunId", lab.RunId); // or passed in
				await cmd.ExecuteNonQueryAsync();
			}

			// 2. Bulk copy using mapper JSON (unchanged)
			//    Use _mapperPath = "MapperJon/DenialLineItemMapper.json"
			//    and SqlBulkCopy to dbo.DenialLineItem
		}
	}
}