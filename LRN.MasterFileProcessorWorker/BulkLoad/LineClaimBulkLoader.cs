using System.Data;
using System.Diagnostics;
using Microsoft.Data.SqlClient;

namespace LRN.MasterFileProcessorWorker.BulkLoad;

public sealed record BulkLoadResult(
    bool Skipped,
    string? SkipReason,
    long RowsRead,
    long RowsInTable,
    TimeSpan Duration,
    IReadOnlyList<string> MissingCsvHeaders,
    IReadOnlyList<string> UnmappedCsvHeaders);

/// <summary>
/// Loads one standardized CSV into a lab's line-level or claim-level table.
/// </summary>
/// <remarks>
/// <para><b>Strategy: staging table, then swap.</b> Chosen over "TRUNCATE + SqlBulkCopy in one
/// transaction" because a bare truncate followed by a failed load leaves a lab with an empty table,
/// and the single-transaction variant holds a TABLOCK on the live table for the whole load. Here:</para>
/// <list type="number">
///   <item>TRUNCATE the staging table (private to this load) and bulk copy into it, outside any
///         long transaction. The live table stays readable and populated throughout.</item>
///   <item>Verify the staged row count equals the CSV row count. A mismatch aborts BEFORE the live
///         table is touched, so a bad load costs nothing.</item>
///   <item>TRUNCATE live + INSERT...SELECT from staging inside one short transaction.</item>
/// </list>
/// <para>Truncate scope is per run per level. Discovery confirmed the pipeline produces exactly one
/// line-level and one claim-level CSV per lab per run, so per-file and per-run truncation are
/// equivalent today; keeping it per-load is safe as long as that stays true. If a run ever produces
/// two files of the same level, this must move to truncate-once-per-run.</para>
/// </remarks>
public sealed class LineClaimBulkLoader
{
    private readonly ILogger<LineClaimBulkLoader> _logger;

    public LineClaimBulkLoader(ILogger<LineClaimBulkLoader> logger) => _logger = logger;

    public async Task<BulkLoadResult> LoadAsync(
        ResolvedLab lab,
        LevelMapping level,
        string fileType,
        string csvPath,
        AuditColumns.AuditValues audit,
        CancellationToken ct)
    {
        var stopwatch = Stopwatch.StartNew();

        if (!File.Exists(csvPath))
        {
            return new BulkLoadResult(true, $"CSV not found: {csvPath}", 0, 0, stopwatch.Elapsed,
                Array.Empty<string>(), Array.Empty<string>());
        }

        var target = QuoteTableName(level.SqlTableName);
        var staging = QuoteTableName(level.ResolveStagingTableName());

        await using var conn = new SqlConnection(lab.ConnectionString);
        await conn.OpenAsync(ct).ConfigureAwait(false);

        await EnsureTableExistsAsync(conn, level.SqlTableName, ct).ConfigureAwait(false);
        await EnsureTableExistsAsync(conn, level.ResolveStagingTableName(), ct).ConfigureAwait(false);

        // ---- 1. stage ----
        await ExecuteAsync(conn, null, $"TRUNCATE TABLE {staging};", ct).ConfigureAwait(false);

        long rowsRead;
        IReadOnlyList<string> missing;
        IReadOnlyList<string> unmapped;
        IReadOnlyList<string> columnNames;

        using (var reader = new CsvBulkDataReader(csvPath, level.Fields, audit))
        {
            missing = reader.MissingCsvHeaders;
            unmapped = reader.UnmappedCsvHeaders;
            columnNames = reader.ColumnNames;   // effective, de-duplicated - reused for the swap

            if (missing.Count > 0)
            {
                _logger.LogWarning(
                    "Lab {LabId} [{FileType}]: {Count} mapped field(s) are absent from the CSV and will load as NULL: {Fields}",
                    lab.LabId, fileType, missing.Count, string.Join(", ", missing));
            }

            if (unmapped.Count > 0)
            {
                _logger.LogWarning(
                    "Lab {LabId} [{FileType}]: {Count} CSV column(s) have no mapping and will be dropped: {Columns}",
                    lab.LabId, fileType, unmapped.Count, string.Join(", ", unmapped));
            }

            using var bulk = new SqlBulkCopy(conn, SqlBulkCopyOptions.TableLock | SqlBulkCopyOptions.KeepNulls, null)
            {
                DestinationTableName = staging,
                BatchSize = level.BatchSize,
                BulkCopyTimeout = level.BulkCopyTimeoutSeconds,
                EnableStreaming = true
            };

            // Explicit, by name, for every column - never ordinal.
            foreach (var columnName in reader.ColumnNames)
                bulk.ColumnMappings.Add(columnName, columnName);

            await bulk.WriteToServerAsync(reader, ct).ConfigureAwait(false);
            rowsRead = reader.RowsRead;
        }

        var staged = await CountAsync(conn, staging, ct).ConfigureAwait(false);

        // ---- 2. verify BEFORE touching the live table ----
        if (staged != rowsRead)
        {
            throw new InvalidOperationException(
                $"Lab {lab.LabId} [{fileType}]: staged row count {staged} does not match CSV row count {rowsRead}. " +
                $"The live table {level.SqlTableName} was not modified.");
        }

        if (rowsRead == 0)
        {
            _logger.LogWarning(
                "Lab {LabId} [{FileType}]: CSV {Csv} contained no data rows. Live table left unchanged.",
                lab.LabId, fileType, Path.GetFileName(csvPath));

            return new BulkLoadResult(true, "CSV contained no data rows.", 0,
                await CountAsync(conn, target, ct).ConfigureAwait(false), stopwatch.Elapsed, missing, unmapped);
        }

        // ---- 3. swap, in one short transaction ----
        // Exactly the columns the reader wrote to staging, in the same order. Deriving this list a
        // second time from level.Fields is how LabID/LabName ended up duplicated in the INSERT.
        var columnList = string.Join(", ", columnNames.Select(n => "[" + n + "]"));

        await using (var tx = (SqlTransaction)await conn.BeginTransactionAsync(ct).ConfigureAwait(false))
        {
            try
            {
                if (level.TruncateBeforeLoad)
                    await ExecuteAsync(conn, tx, $"TRUNCATE TABLE {target};", ct).ConfigureAwait(false);

                await ExecuteAsync(conn, tx,
                    $"INSERT INTO {target} ({columnList}) SELECT {columnList} FROM {staging};",
                    ct, level.BulkCopyTimeoutSeconds).ConfigureAwait(false);

                await tx.CommitAsync(ct).ConfigureAwait(false);
            }
            catch
            {
                await tx.RollbackAsync(CancellationToken.None).ConfigureAwait(false);
                throw;
            }
        }

        var finalCount = await CountAsync(conn, target, ct).ConfigureAwait(false);

        // ---- 4. verify the live table ----
        if (finalCount != rowsRead)
        {
            throw new InvalidOperationException(
                $"Lab {lab.LabId} [{fileType}]: {level.SqlTableName} has {finalCount} rows after load but the CSV had {rowsRead}.");
        }

        // Reclaim the staged copy now that the live table is loaded and verified. Holding a second
        // full copy of every lab's data is what filled NWL_LRN's PRIMARY filegroup; the CSV on disk
        // is the real forensic record. KeepStagingAfterLoad=true opts back in while debugging.
        if (!level.KeepStagingAfterLoad)
        {
            try
            {
                await ExecuteAsync(conn, null, $"TRUNCATE TABLE {staging};", ct).ConfigureAwait(false);
            }
            catch (Exception ex)
            {
                // The load succeeded; failing to reclaim space must not fail the run.
                _logger.LogWarning(ex,
                    "Lab {LabId} [{FileType}]: loaded successfully but could not truncate {Staging}.",
                    lab.LabId, fileType, level.ResolveStagingTableName());
            }
        }

        stopwatch.Stop();

        _logger.LogInformation(
            "Lab {LabId} [{FileType}]: loaded {Rows} rows into {Table} in {Ms} ms.",
            lab.LabId, fileType, finalCount, level.SqlTableName, stopwatch.ElapsedMilliseconds);

        return new BulkLoadResult(false, null, rowsRead, finalCount, stopwatch.Elapsed, missing, unmapped);
    }

    /// <summary>
    /// Confirms a config-supplied table name exists before it is ever concatenated into a statement.
    /// The name has already passed the identifier whitelist in <see cref="LabMappingLoader"/>; this
    /// is the second gate.
    /// </summary>
    private static async Task EnsureTableExistsAsync(SqlConnection conn, string tableName, CancellationToken ct)
    {
        var parts = tableName.Replace("[", "").Replace("]", "").Split('.', 2);
        var schema = parts.Length == 2 ? parts[0] : "dbo";
        var table = parts.Length == 2 ? parts[1] : parts[0];

        const string sql = @"
SELECT COUNT(1)
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id = t.schema_id
WHERE s.name = @Schema AND t.name = @Table;";

        await using var cmd = new SqlCommand(sql, conn);
        cmd.Parameters.Add("@Schema", SqlDbType.NVarChar, 128).Value = schema;
        cmd.Parameters.Add("@Table", SqlDbType.NVarChar, 128).Value = table;

        var count = Convert.ToInt32(await cmd.ExecuteScalarAsync(ct).ConfigureAwait(false));

        if (count == 0)
        {
            throw new InvalidOperationException(
                $"Table {tableName} does not exist in database '{conn.Database}'. Run the sql/ deployment scripts for this lab first.");
        }
    }

    private static async Task ExecuteAsync(SqlConnection conn, SqlTransaction? tx, string sql, CancellationToken ct, int timeoutSeconds = 120)
    {
        await using var cmd = new SqlCommand(sql, conn, tx) { CommandTimeout = timeoutSeconds };
        await cmd.ExecuteNonQueryAsync(ct).ConfigureAwait(false);
    }

    private static async Task<long> CountAsync(SqlConnection conn, string quotedTable, CancellationToken ct)
    {
        await using var cmd = new SqlCommand($"SELECT COUNT_BIG(1) FROM {quotedTable};", conn) { CommandTimeout = 300 };
        return Convert.ToInt64(await cmd.ExecuteScalarAsync(ct).ConfigureAwait(false));
    }

    private static string QuoteTableName(string tableName)
    {
        var parts = tableName.Replace("[", "").Replace("]", "").Split('.', 2);
        return parts.Length == 2 ? $"[{parts[0]}].[{parts[1]}]" : $"[dbo].[{parts[0]}]";
    }
}
