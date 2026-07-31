namespace LRN.MasterFileProcessorWorker.BulkLoad;

/// <summary>
/// One file in <c>Schemas/LabMappings/</c>.
/// <para>
/// The existing shape (SqlTableName / TvpTypeName / SprocName / FileTypeKey / Fields) is kept as-is;
/// this type only ADDS the identity block and the per-level toggles. Every added property has a
/// default that reproduces today's behaviour, so an untouched lab JSON keeps working after deploy.
/// </para>
/// </summary>
public sealed class LabMappingConfig
{
    /// <summary>Set by the loader from the file name; not stored in the JSON.</summary>
    public string SourceFile { get; set; } = "";

    /// <summary>
    /// Joins this mapping to <c>LRNMaster.dbo.LabMaster</c>, which is the authoritative lab list.
    /// Optional in the JSON: when absent the loader falls back to matching <see cref="LabName"/>,
    /// then the file name, against LabMaster.
    /// </summary>
    public int? LabId { get; set; }

    public string? LabName { get; set; }

    /// <summary>
    /// Informational - the real connection comes from LabMaster.ConnectionKey. Used only to make
    /// the generated DDL folder name obvious and to sanity-check the resolved connection.
    /// </summary>
    public string? DatabaseName { get; set; }

    public LevelMapping? LineLevel { get; set; }
    public LevelMapping? ClaimLevel { get; set; }

    public LevelMapping? ForLevel(string fileType) =>
        string.Equals(fileType, FileTypes.LineLevel, StringComparison.OrdinalIgnoreCase)
            ? LineLevel
            : ClaimLevel;
}

/// <summary>Table + field mapping and the load toggles for one level of one lab.</summary>
public sealed class LevelMapping
{
    // ----- existing keys, unchanged -----
    public string SqlTableName { get; set; } = "";
    public string? TvpTypeName { get; set; }
    public string? SprocName { get; set; }
    public string? FileTypeKey { get; set; }
    public List<FieldMapping> Fields { get; set; } = new();

    // ----- added toggles (Phase 1). Defaults preserve current behaviour. -----

    /// <summary>Master switch. False skips the level end to end (logged, never silent).</summary>
    public bool Enabled { get; set; } = true;

    /// <summary>Write the standardized CSV for this level. False also skips the bulk copy.</summary>
    public bool CreateCsv { get; set; } = true;

    /// <summary>
    /// Bulk copy the CSV into <see cref="SqlTableName"/>. Off by default so that deploying this
    /// change does not start writing to lab databases until a lab is explicitly opted in.
    /// </summary>
    public bool BulkCopyToTable { get; set; }

    public bool TruncateBeforeLoad { get; set; } = true;

    public int BatchSize { get; set; } = 10000;

    /// <summary>Seconds. Deliberately not 0 (infinite) - a hung load must fail, not block the run.</summary>
    public int BulkCopyTimeoutSeconds { get; set; } = 900;

    /// <summary>
    /// Staging table used for the load-then-swap strategy. Defaults to
    /// <c>&lt;SqlTableName&gt;_Staging</c> when not set.
    /// </summary>
    public string? StagingTableName { get; set; }

    public string ResolveStagingTableName() =>
        string.IsNullOrWhiteSpace(StagingTableName)
            ? SqlTableName + "_Staging"
            : StagingTableName!;
}

/// <summary>One CSV column to one SQL column.</summary>
public sealed class FieldMapping
{
    public string CsvHeader { get; set; } = "";
    public string SqlColumn { get; set; } = "";

    /// <summary>
    /// Participates in <see cref="RowHasher"/>. This is the repo's pre-existing hash convention and
    /// is reused rather than replaced.
    /// </summary>
    public bool IncludeInHash { get; set; }
}
