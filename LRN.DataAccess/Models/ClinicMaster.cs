using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class ClinicMaster
{
    public int ClinicId { get; set; }

    public string ClinicName { get; set; } = null!;

    public bool ClinicStatus { get; set; }

    public DateTime? CreatedOn { get; set; }

    public virtual ICollection<Lismaster> Lismasters { get; set; } = new List<Lismaster>();
}
