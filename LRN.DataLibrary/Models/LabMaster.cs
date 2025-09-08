using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

public partial class LabMaster
{
    public int LabId { get; set; }

    public string LabName { get; set; } = null!;

    public string ConnectionKey { get; set; }

    public bool IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public virtual ICollection<Lismaster> Lismasters { get; set; } = new List<Lismaster>();
}


