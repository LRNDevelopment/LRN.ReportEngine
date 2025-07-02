using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

public partial class SpecimenStatus
{
    public int SpecimenStatusId { get; set; }

    public string SpecimenStatusName { get; set; } = null!;

    public bool IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public virtual ICollection<Lismaster> Lismasters { get; set; } = new List<Lismaster>();
}
