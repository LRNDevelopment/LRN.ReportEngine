using Microsoft.Data.SqlClient;

namespace LRN.MasterFileProcessorWorker.BulkLoad;

/// <summary>One active lab, joined from LabMaster to its mapping JSON and its connection string.</summary>
public sealed record ResolvedLab(
    int LabId,
    string LabName,
    string ConnectionKey,
    string ConnectionString,
    LabMappingConfig Mapping);

/// <summary>
/// Resolves the authoritative lab list from <c>LRNMaster.dbo.LabMaster</c> and joins each row to its
/// mapping JSON.
/// <para>
/// LabMaster is the source of truth by decision: the four candidate lists in the repo
/// (appsettings.Labs, Schemas/LabMappings/*.json, ClaimLevelLineLevel_Fields.xlsx and LabMaster)
/// all disagreed, and only LabMaster is maintained outside the deployment artifact.
/// </para>
/// <para>
/// The connection string comes from configuration under <c>LabMaster.ConnectionKey</c>; it is never
/// read from the mapping JSON and never hard-coded.
/// </para>
/// </summary>
public sealed class LabRegistry
{
    private const string LabMasterSql = @"
SELECT  LabId,
        LabName,
        ConnectionKey
FROM    dbo.LabMaster
WHERE   IsActive = 1
ORDER BY LabId;";

    private readonly IConfiguration _configuration;
    private readonly LabMappingLoader _loader;
    private readonly ILogger<LabRegistry> _logger;
    private readonly string _masterConnectionString;

    public LabRegistry(IConfiguration configuration, LabMappingLoader loader, ILogger<LabRegistry> logger)
    {
        _configuration = configuration;
        _loader = loader;
        _logger = logger;

        _masterConnectionString = configuration.GetConnectionString("DefaultConnection")
            ?? throw new InvalidOperationException("Missing DefaultConnection connection string (LRNMaster).");
    }

    /// <summary>
    /// Returns every active lab that has a usable mapping. A lab that cannot be resolved is logged
    /// and skipped rather than throwing, so one bad row never stops the other labs loading.
    /// </summary>
    public async Task<IReadOnlyList<ResolvedLab>> GetActiveLabsAsync(string mappingFolderPath, CancellationToken ct)
    {
        var mappings = _loader.LoadAll(mappingFolderPath);
        var rows = await ReadLabMasterAsync(ct).ConfigureAwait(false);

        var resolved = new List<ResolvedLab>();

        foreach (var (labId, labName, connectionKey) in rows)
        {
            var mapping = MatchMapping(mappings, labId, labName);

            if (mapping is null)
            {
                _logger.LogWarning(
                    "LabMaster lab {LabId} '{LabName}' has no mapping file in the LabMappings folder. Skipping bulk load for this lab.",
                    labId, labName);
                continue;
            }

            var connectionString = ResolveConnectionString(connectionKey);

            if (string.IsNullOrWhiteSpace(connectionString))
            {
                _logger.LogWarning(
                    "LabMaster lab {LabId} '{LabName}' has ConnectionKey '{Key}' but no matching connection string in configuration. Skipping bulk load for this lab.",
                    labId, labName, connectionKey);
                continue;
            }

            resolved.Add(new ResolvedLab(labId, labName, connectionKey, connectionString!, mapping));
        }

        var unused = mappings
            .Where(m => !resolved.Any(r => ReferenceEquals(r.Mapping, m)))
            .Select(m => m.SourceFile)
            .ToList();

        if (unused.Count > 0)
        {
            _logger.LogInformation(
                "Mapping files not matched to any active LabMaster row (ignored): {Files}",
                string.Join(", ", unused));
        }

        return resolved;
    }

    private async Task<List<(int LabId, string LabName, string ConnectionKey)>> ReadLabMasterAsync(CancellationToken ct)
    {
        var rows = new List<(int, string, string)>();

        await using var conn = new SqlConnection(_masterConnectionString);
        await using var cmd = new SqlCommand(LabMasterSql, conn) { CommandTimeout = 60 };

        await conn.OpenAsync(ct).ConfigureAwait(false);
        await using var reader = await cmd.ExecuteReaderAsync(ct).ConfigureAwait(false);

        while (await reader.ReadAsync(ct).ConfigureAwait(false))
        {
            rows.Add((
                reader.GetInt32(0),
                reader.IsDBNull(1) ? "" : reader.GetString(1).Trim(),
                reader.IsDBNull(2) ? "" : reader.GetString(2).Trim()));
        }

        return rows;
    }

    /// <summary>
    /// LabId wins; then LabName; then the file-name stem. The stem fallback exists because the
    /// current file names do not match lab names exactly (PCRLOA / PCRLabsofAmerica,
    /// PHILIFE / PhiLife, InHEalthDTR / InHealthDTR).
    /// </summary>
    private static LabMappingConfig? MatchMapping(IReadOnlyList<LabMappingConfig> mappings, int labId, string labName)
    {
        var byId = mappings.FirstOrDefault(m => m.LabId == labId);
        if (byId is not null)
            return byId;

        var byName = mappings.FirstOrDefault(m =>
            !string.IsNullOrWhiteSpace(m.LabName) &&
            string.Equals(Squash(m.LabName!), Squash(labName), StringComparison.OrdinalIgnoreCase));

        if (byName is not null)
            return byName;

        var stem = Squash(labName);

        return mappings.FirstOrDefault(m =>
        {
            var fileStem = Squash(Path.GetFileNameWithoutExtension(m.SourceFile).Replace("FieldMappings", "", StringComparison.OrdinalIgnoreCase));
            return fileStem.Length > 0 && string.Equals(fileStem, stem, StringComparison.OrdinalIgnoreCase);
        });
    }

    private static string Squash(string value) =>
        new(value.Where(char.IsLetterOrDigit).Select(char.ToLowerInvariant).ToArray());

    /// <summary>ConnectionStrings:&lt;key&gt; first, then a bare configuration key of the same name.</summary>
    private string? ResolveConnectionString(string connectionKey)
    {
        if (string.IsNullOrWhiteSpace(connectionKey))
            return null;

        return _configuration.GetConnectionString(connectionKey)
            ?? _configuration[connectionKey];
    }
}
