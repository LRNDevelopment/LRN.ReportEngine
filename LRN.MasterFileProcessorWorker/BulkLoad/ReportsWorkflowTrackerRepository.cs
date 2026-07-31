using System.Data;
using Microsoft.Data.SqlClient;

namespace LRN.MasterFileProcessorWorker.BulkLoad;

public static class WorkflowReportNames
{
    public const string LineLevelMaster = "Line Level Master";
    public const string ClaimLevelMaster = "Claim Level Master";
}

public static class WorkflowStatus
{
    public const string Success = "Success";
    public const string Failed = "Failed";
    public const string Skipped = "Skipped";
    public const string InProgress = "InProgress";
}

/// <summary>
/// Upserts <c>LRNMaster.dbo.ReportsWorkflowTracker</c>.
/// <para>
/// Stored TALL (one row per RunId + Lab + ReportName) by decision, rather than mirroring the wide
/// layout of Reports_Workflow_Tracker_v1.0.xlsx. Tall means a new report type needs no ALTER TABLE,
/// and the unique key makes the write idempotent on re-run. The workbook's wide shape is reproduced
/// by the view <c>dbo.vw_ReportsWorkflowTracker_Wide</c> created alongside the table.
/// </para>
/// </summary>
public sealed class ReportsWorkflowTrackerRepository
{
    // MERGE on the natural key so a re-run updates in place instead of duplicating.
    private const string UpsertSql = @"
MERGE dbo.ReportsWorkflowTracker WITH (HOLDLOCK) AS target
USING (SELECT @RunId AS RunId, @LabID AS LabID, @ReportName AS ReportName) AS source
    ON  target.RunId      = source.RunId
    AND target.LabID      = source.LabID
    AND target.ReportName = source.ReportName
WHEN MATCHED THEN
    UPDATE SET LabName     = @LabName,
               WeekFolder  = @WeekFolder,
               ReportType  = @ReportType,
               Status      = @Status,
               [RowCount]  = @RowCountValue,
               StartedOn   = ISNULL(target.StartedOn, @StartedOn),
               CompletedOn = @CompletedOn,
               Remarks     = @Remarks
WHEN NOT MATCHED THEN
    INSERT (RunId, LabID, LabName, WeekFolder, ReportName, ReportType, Status, [RowCount],
            StartedOn, CompletedOn, Remarks, CreatedOn, CreatedBy)
    VALUES (@RunId, @LabID, @LabName, @WeekFolder, @ReportName, @ReportType, @Status, @RowCountValue,
            @StartedOn, @CompletedOn, @Remarks, @CreatedOn, @CreatedBy);";

    private readonly string _masterConnectionString;
    private readonly ILogger<ReportsWorkflowTrackerRepository> _logger;
    private readonly string _createdBy;

    public ReportsWorkflowTrackerRepository(IConfiguration configuration, ILogger<ReportsWorkflowTrackerRepository> logger)
    {
        _masterConnectionString = configuration.GetConnectionString("DefaultConnection")
            ?? throw new InvalidOperationException("Missing DefaultConnection connection string (LRNMaster).");

        _logger = logger;
        _createdBy = $"LRN.MasterFileProcessorWorker/{Environment.UserName}@{Environment.MachineName}";
    }

    public async Task UpsertAsync(
        string runId,
        int labId,
        string labName,
        string? weekFolder,
        string reportName,
        string? reportType,
        string status,
        long? rowCount,
        DateTime? startedOn,
        DateTime? completedOn,
        string? remarks,
        CancellationToken ct)
    {
        if (string.IsNullOrWhiteSpace(runId))
            return;

        try
        {
            await using var conn = new SqlConnection(_masterConnectionString);
            await using var cmd = new SqlCommand(UpsertSql, conn) { CommandTimeout = 60 };

            cmd.Parameters.Add("@RunId", SqlDbType.VarChar, 50).Value = runId;
            cmd.Parameters.Add("@LabID", SqlDbType.Int).Value = labId;
            cmd.Parameters.Add("@LabName", SqlDbType.VarChar, 200).Value = (object?)labName ?? DBNull.Value;
            cmd.Parameters.Add("@WeekFolder", SqlDbType.VarChar, 200).Value = (object?)weekFolder ?? DBNull.Value;
            cmd.Parameters.Add("@ReportName", SqlDbType.VarChar, 200).Value = reportName;
            cmd.Parameters.Add("@ReportType", SqlDbType.VarChar, 100).Value = (object?)reportType ?? DBNull.Value;
            cmd.Parameters.Add("@Status", SqlDbType.VarChar, 50).Value = status;
            cmd.Parameters.Add("@RowCountValue", SqlDbType.BigInt).Value = (object?)rowCount ?? DBNull.Value;
            cmd.Parameters.Add("@StartedOn", SqlDbType.DateTime2).Value = (object?)startedOn ?? DBNull.Value;
            cmd.Parameters.Add("@CompletedOn", SqlDbType.DateTime2).Value = (object?)completedOn ?? DBNull.Value;
            cmd.Parameters.Add("@Remarks", SqlDbType.NVarChar, -1).Value = (object?)remarks ?? DBNull.Value;
            cmd.Parameters.Add("@CreatedOn", SqlDbType.DateTime2).Value = ReportRunIdInfoLogger.IstNow();
            cmd.Parameters.Add("@CreatedBy", SqlDbType.VarChar, 100).Value = _createdBy;

            await conn.OpenAsync(ct).ConfigureAwait(false);
            await cmd.ExecuteNonQueryAsync(ct).ConfigureAwait(false);
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex,
                "ReportsWorkflowTracker upsert failed (RunId={RunId}, Lab={LabId}, Report={ReportName}, Status={Status}).",
                runId, labId, reportName, status);
        }
    }
}
