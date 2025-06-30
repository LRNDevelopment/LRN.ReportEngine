using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class TestTypeMaster
{
    public int TestTypeId { get; set; }

    public string TestTypeName { get; set; } = null!;

    public bool IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public virtual ICollection<Lismaster> Lismasters { get; set; } = new List<Lismaster>();
}
