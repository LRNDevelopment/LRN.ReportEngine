using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

public partial class Lisstaging
{
    public long LisstagingId { get; set; }

    public DateOnly? CollectedDate { get; set; }

    public DateOnly? ReceivedDate { get; set; }

    public DateOnly? AccessionedDate { get; set; }

    public DateOnly? ResultedDate { get; set; }

    public string? Outstanding { get; set; }

    public string? Turnaround { get; set; }

    public string? SpecimenStatus { get; set; }

    public string AccessionNo { get; set; } = null!;

    public string? PerformingLab { get; set; }

    public string? PatientName { get; set; }

    public string? PayerName { get; set; }

    public string? MemberId { get; set; }

    public string? RelToInsured { get; set; }

    public string? SelfPay { get; set; }

    public string? AccountPay { get; set; }

    public string? ContractPay { get; set; }

    public string? ClinicName { get; set; }

    public string? OperationsGroup { get; set; }

    public string? SalesRep { get; set; }

    public string? Reference { get; set; }

    public string? Analtyics { get; set; }

    public string? TestType { get; set; }

    public string? ScrubSettings { get; set; }

    public string? Actions { get; set; }

    public string? OrderInfo { get; set; }

    public DateTime? ImportedOn { get; set; }

    public int? ImportedFileId { get; set; }
}
