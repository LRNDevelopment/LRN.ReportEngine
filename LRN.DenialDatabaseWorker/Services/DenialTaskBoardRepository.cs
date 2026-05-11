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

	// Use this constructor when reading/writing lab-level tables.
	// Example: NorthWest must read dbo.DenialTaskBoard from NWL_Lab / NWL_LRN, not LRNMaster.
	public DenialTaskBoardRepository(string connectionString)
	{
		if (string.IsNullOrWhiteSpace(connectionString))
			throw new ArgumentException("Lab database connection string is required.", nameof(connectionString));

		_connectionString = connectionString;
	}

	public sealed class ExistingTaskInfo
	{
		public string TaskId { get; set; } = "";
		public DateTime? DateOpened { get; set; }
		public Dictionary<string, string> Row { get; set; } = new(StringComparer.OrdinalIgnoreCase);
	}

	// Key: UniqueTrackId (VisitNumber|CPTCode|DenialCode)
	public async Task<Dictionary<string, ExistingTaskInfo>> GetExistingTasksAsync(int labId)
	{
		const string sql = @"
SELECT TaskID, ClaimID, PatientId, CPTCode, DenialCode,
       DenialDescription, DenialClassification, ActionCode, RecommendedAction,
       Task, ActionCategory, Priority, SLADays, Status,
       InsuranceBalance, IsCurrentDenial, AssignedTo,
       DateOpened, DueDate, DateCompleted, DaysRemaining, SLAStatus,
       LabId, LabName, RunId, CreatedOn, UniqueTrackId,
       ICDCodes, CoverageStatus, ICDComplianceStatus, DenialValidity
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
			var uniqueTrackId = reader["UniqueTrackId"] as string ?? "";
			if (string.IsNullOrWhiteSpace(uniqueTrackId))
				continue;

			var info = new ExistingTaskInfo
			{
				TaskId = reader["TaskID"] as string ?? "",
				DateOpened = reader["DateOpened"] is DateTime dt ? dt : (DateTime?)null,
				Row = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
				{
					["Task ID"] = reader["TaskID"]?.ToString() ?? "",
					["Claim ID"] = reader["ClaimID"]?.ToString() ?? "",
					["Patient / Acct #"] = reader["PatientId"]?.ToString() ?? "",
					["CPT Code"] = reader["CPTCode"]?.ToString() ?? "",
					["Denial Code"] = reader["DenialCode"]?.ToString() ?? "",
					["Denial Description"] = reader["DenialDescription"]?.ToString() ?? "",
					["Denial Classification"] = reader["DenialClassification"]?.ToString() ?? "",
					["Action Code"] = reader["ActionCode"]?.ToString() ?? "",
					["Recommended Action"] = reader["RecommendedAction"]?.ToString() ?? "",
					["Task"] = reader["Task"]?.ToString() ?? "",
					["Action Category"] = reader["ActionCategory"]?.ToString() ?? "",
					["Priority"] = reader["Priority"]?.ToString() ?? "",
					["SLA (Days)"] = reader["SLADays"]?.ToString() ?? "",
					["Status"] = reader["Status"]?.ToString() ?? "",
					["Insurance Balance"] = reader["InsuranceBalance"]?.ToString() ?? "",
					["IsCurrentDenial"] = reader["IsCurrentDenial"]?.ToString() ?? "",
					["Assigned To"] = reader["AssignedTo"]?.ToString() ?? "",
					["Date Opened"] = reader["DateOpened"] is DateTime doDt ? doDt.ToString("yyyy-MM-dd") : "",
					["Due Date"] = reader["DueDate"] is DateTime ddDt ? ddDt.ToString("yyyy-MM-dd") : "",
					["Date Completed"] = reader["DateCompleted"] is DateTime dcDt ? dcDt.ToString("yyyy-MM-dd") : "",
					["Days Remaining"] = reader["DaysRemaining"]?.ToString() ?? "",
					["SLA Status"] = reader["SLAStatus"]?.ToString() ?? "",
					["LabId"] = reader["LabId"]?.ToString() ?? "",
					["LabName"] = reader["LabName"]?.ToString() ?? "",
					["RunId"] = reader["RunId"]?.ToString() ?? "",
					["CreatedOn"] = reader["CreatedOn"] is DateTime coDt ? coDt.ToString("O") : "",
					["UniqueTrackId"] = uniqueTrackId,
					["ICDCodes"] = reader["ICDCodes"]?.ToString() ?? "",
					["CoverageStatus"] = reader["CoverageStatus"]?.ToString() ?? "",
					["ICDComplianceStatus"] = reader["ICDComplianceStatus"]?.ToString() ?? "",
					["DenialValidity"] = reader["DenialValidity"]?.ToString() ?? ""
				}
			};

			result[uniqueTrackId] = info;
		}

		return result;
	}
}