using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class VisitAgaistAccessionStaging
{
    public int Vaaid { get; set; }

    public string? Void { get; set; }

    public string? OfficeKey { get; set; }

    public string? VisitNumber { get; set; }

    public DateOnly? EntryDate { get; set; }

    public DateOnly? ServiceDate { get; set; }

    public string? AccessionNo { get; set; }

    public DateTime? ImportedOn { get; set; }

    public int? ImportedFileId { get; set; }
}
