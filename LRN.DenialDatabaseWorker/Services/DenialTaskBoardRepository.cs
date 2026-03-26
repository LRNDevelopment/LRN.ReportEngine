using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace DenialDatabaseProcessorWorker.Services;

public sealed class DenialTaskBoardRepository
{
	private readonly string _connectionString;

	public DenialTaskBoardRepository(IConfiguration configuration)
	{
		_connectionString = configuration.GetConnectionString("DenialDatabase")
							?? throw new InvalidOperationException("Connection string 'DenialDatabase' not found.");
	}

	public sealed class ExistingTaskInfo
	{
		public string TaskId { get; set; } = "";
		public DateTime? DateOpened { get; set; }
	}

	// Key: VisitNumber|CPTCode|DenialCode
	public async Task<Dictionary<string, ExistingTaskInfo>> GetExistingTasksAsync(int labId)
	{
		const string sql = @"
SELECT TaskID, UniqueTrackId, DateOpened
FROM dbo.DenialTaskBoard
WHERE LabId = @LabId";

		var result = new Dictionary<string, ExistingTaskInfo>(StringComparer.OrdinalIgnoreCase);

		await using var conn = new SqlConnection(_connectionString);
		await using var cmd = new SqlCommand(sql, conn);
		cmd.Parameters.AddWithValue("@LabId", labId);
		await conn.OpenAsync().ConfigureAwait(false);

		await using var reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false);
		while (await reader.ReadAsync().ConfigureAwait(false))
		{
			var taskId = reader["TaskID"] as string ?? "";
			var uniqueTrackId = reader["UniqueTrackId"] as string ?? "";
			DateTime? dateOpened = reader["DateOpened"] is DateTime dt ? dt : (DateTime?)null;

			// UniqueTrackId is VisitNumber|CPTCode|DenialCode
			if (string.IsNullOrWhiteSpace(uniqueTrackId))
				continue;

			var key = uniqueTrackId; // already in Visit|CPT|Denial format
			if (!result.ContainsKey(key))
			{
				result[key] = new ExistingTaskInfo
				{
					TaskId = taskId,
					DateOpened = dateOpened
				};
			}
		}

		return result;
	}
}