using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class SpecimenStatus
{
    public int SpecimenStatusId { get; set; }

    public string SpecimenStatusName { get; set; } = null!;

    public bool IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }
}
