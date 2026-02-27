using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using LRN.DataLibrary.Abstractions;

namespace LRN.DataLibrary.Entities;

[Table("LRN_Run_Log")]
public class LrnRunLog
{
    [Key]
    public long RunID { get; set; }

    public int LabId { get; set; }

    [MaxLength(200)]
    public string LabName { get; set; } = string.Empty;

    public DateTimeOffset StartTimeUSST { get; set; }
    public DateTimeOffset? EndTimeUSST { get; set; }

    [MaxLength(50)]
    public string OverallStatus { get; set; } = LrnStatuses.Pending;

    [MaxLength(100)]
    public string SourceSystem { get; set; } = "LRN.MasterFileProcessor";

    public DateTimeOffset UpdatedOn { get; set; }

    public bool LatestMasterFileFound { get; set; }

    [MaxLength(1000)]
    public string? InputMasterSharePointPath { get; set; }

    [MaxLength(500)]
    public string? InputMasterFileName { get; set; }

    public DateTimeOffset? InputMasterFileModifiedTime { get; set; }

    [MaxLength(50)]
    public string MandatoryColumnCheck { get; set; } = LrnStatuses.Pending;

    [MaxLength(50)]
    public string SplitOutputWrittenToSharePoint { get; set; } = LrnStatuses.Pending;

    [MaxLength(50)]
    public string PayerPolicyValidationStatus { get; set; } = LrnStatuses.Pending;

    [MaxLength(50)]
    public string CodingValidationStatus { get; set; } = LrnStatuses.Pending;

    [MaxLength(50)]
    public string AveragesProcessStatus { get; set; } = LrnStatuses.Pending;

    [MaxLength(50)]
    public string OutputsCopiedToSharePoint { get; set; } = LrnStatuses.Pending;

    public bool MasterSyncPerformed { get; set; }

    public int TotalErrors { get; set; }
    public int TotalWarnings { get; set; }

    [MaxLength(4000)]
    public string? Notes { get; set; }
}
