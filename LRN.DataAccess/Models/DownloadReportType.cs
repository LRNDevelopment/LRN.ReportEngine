using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class DownloadReportType
{
    public int ReportTypeId { get; set; }

    public string ReportName { get; set; } = null!;

    public bool? IsActive { get; set; }

    public int? LabId { get; set; }
}
