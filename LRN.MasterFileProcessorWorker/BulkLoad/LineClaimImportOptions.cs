namespace LRN.MasterFileProcessorWorker.BulkLoad;

/// <summary>
/// Worker-level switches for the line-level / claim-level bulk copy. Per-lab and per-level
/// behaviour lives in the lab mapping JSONs; this is only the global on/off and the paths.
/// </summary>
public sealed class LineClaimImportOptions
{
    public const string SectionName = "LineClaimImport";

    /// <summary>
    /// Master switch. Defaults to FALSE so that deploying this change is inert until the SQL
    /// scripts have been run and a lab has been opted in.
    /// </summary>
    public bool Enabled { get; set; }

    /// <summary>Folder holding the per-lab mapping JSONs. Relative paths resolve from the content root.</summary>
    public string LabMappingsFolder { get; set; } = "Schemas/LabMappings";

    /// <summary>
    /// Fail the whole worker at startup when a mapping JSON is invalid. True is the safe default:
    /// a mapping error otherwise shows up as silent NULL columns days later.
    /// </summary>
    public bool FailFastOnInvalidMapping { get; set; } = true;
}
