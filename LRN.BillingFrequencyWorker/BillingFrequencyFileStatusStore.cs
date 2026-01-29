using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;

public sealed class BillingFrequencyFileStatusStore
{
    private readonly string _connStr;
    private readonly string _tableName;

    public BillingFrequencyFileStatusStore(IConfiguration config, IOptions<ImportOptions> opt)
    {
        _connStr = config.GetConnectionString("DefaultConnection")
                  ?? throw new InvalidOperationException("Missing DefaultConnection connection string.");
        _tableName = opt.Value.FileStatusTable;
    }

    public async Task<bool> IsProcessedAsync(int labId, string driveId, string itemId, string eTagKey, CancellationToken ct)
    {
        string sql = $@"
SELECT 1
FROM {_tableName}
WHERE LabId=@LabId AND DriveId=@DriveId AND ItemId=@ItemId AND ETagKey=@ETagKey AND Status='PROCESSED';";

        using var conn = new SqlConnection(_connStr);
        await conn.OpenAsync(ct);

        using var cmd = new SqlCommand(sql, conn);
        cmd.Parameters.AddWithValue("@LabId", labId);
        cmd.Parameters.AddWithValue("@DriveId", driveId);
        cmd.Parameters.AddWithValue("@ItemId", itemId);
        cmd.Parameters.AddWithValue("@ETagKey", eTagKey ?? string.Empty);

        var obj = await cmd.ExecuteScalarAsync(ct);
        return obj != null;
    }

    public async Task UpsertStatusAsync(
        int labId,
        string driveId,
        string itemId,
        string eTagKey,
        string fileName,
        string sharePointPath,
        DateTimeOffset? lastModifiedUtc,
        string status,
        string? statusMessage,
        DateTimeOffset? processedAtUtc,
        CancellationToken ct)
    {
        string sql = $@"
IF EXISTS (SELECT 1 FROM {_tableName} WHERE LabId=@LabId AND ItemId=@ItemId AND ETagKey=@ETagKey)
BEGIN
    UPDATE {_tableName}
    SET DriveId=@DriveId,
        FileName=@FileName,
        SharePointPath=@SharePointPath,
        LastModifiedUtc=@LastModifiedUtc,
        Status=@Status,
        StatusMessage=@StatusMessage,
        Attempts = Attempts + 1,
        LastAttemptUtc = SYSUTCDATETIME(),
        ProcessedAtUtc = COALESCE(@ProcessedAtUtc, ProcessedAtUtc)
    WHERE LabId=@LabId AND ItemId=@ItemId AND ETagKey=@ETagKey;
END
ELSE
BEGIN
    INSERT INTO {_tableName}
    (LabId, DriveId, ItemId, ETagKey, FileName, SharePointPath, LastModifiedUtc, Status, StatusMessage, Attempts, FirstSeenUtc, LastAttemptUtc, ProcessedAtUtc)
    VALUES
    (@LabId, @DriveId, @ItemId, @ETagKey, @FileName, @SharePointPath, @LastModifiedUtc, @Status, @StatusMessage, 1, SYSUTCDATETIME(), SYSUTCDATETIME(), @ProcessedAtUtc);
END";

        using var conn = new SqlConnection(_connStr);
        await conn.OpenAsync(ct);

        using var cmd = new SqlCommand(sql, conn);
        cmd.Parameters.AddWithValue("@LabId", labId);
        cmd.Parameters.AddWithValue("@DriveId", driveId);
        cmd.Parameters.AddWithValue("@ItemId", itemId);
        cmd.Parameters.AddWithValue("@ETagKey", eTagKey ?? string.Empty);
        cmd.Parameters.AddWithValue("@FileName", fileName);
        cmd.Parameters.AddWithValue("@SharePointPath", sharePointPath);
        cmd.Parameters.AddWithValue("@LastModifiedUtc", (object?)lastModifiedUtc?.UtcDateTime ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@Status", status);
        cmd.Parameters.AddWithValue("@StatusMessage", (object?)statusMessage ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@ProcessedAtUtc", (object?)processedAtUtc?.UtcDateTime ?? DBNull.Value);

        await cmd.ExecuteNonQueryAsync(ct);
    }
}
