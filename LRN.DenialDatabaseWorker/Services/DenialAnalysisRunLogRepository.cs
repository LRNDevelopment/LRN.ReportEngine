using Microsoft.Data.SqlClient;

namespace DenialDatabaseProcessorWorker.Services;

public sealed class DenialAnalysisRunLogRepository
{
	private readonly string _connectionString;

	public DenialAnalysisRunLogRepository(IConfiguration configuration)
	{
		_connectionString = configuration.GetConnectionString("DenialDatabase")
							?? throw new InvalidOperationException("Connection string 'DenialDatabase' not found.");
	}

	public async Task<bool> ExistsAsync(string runId)
	{
		const string sql = "SELECT COUNT(1) FROM dbo.DenialAnalysisRunLog WHERE RunId = @RunId";

		await using var conn = new SqlConnection(_connectionString);
		await using var cmd = new SqlCommand(sql, conn);
		cmd.Parameters.AddWithValue("@RunId", runId);
		await conn.OpenAsync().ConfigureAwait(false);

		var count = (int)await cmd.ExecuteScalarAsync().ConfigureAwait(false);
		return count > 0;
	}

	public async Task InsertAsync(string runId, int labId)
	{
		const string sql = @"INSERT INTO dbo.DenialAnalysisRunLog (RunId, LabId, CreatedOn)
                             VALUES (@RunId, @LabId, SYSUTCDATETIME())";

		await using var conn = new SqlConnection(_connectionString);
		await using var cmd = new SqlCommand(sql, conn);
		cmd.Parameters.AddWithValue("@RunId", runId);
		cmd.Parameters.AddWithValue("@LabId", labId);
		await conn.OpenAsync().ConfigureAwait(false);
		await cmd.ExecuteNonQueryAsync().ConfigureAwait(false);
	}
}