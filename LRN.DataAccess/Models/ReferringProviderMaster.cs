using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class ReferringProviderMaster
{
    public int ReferingProviderId { get; set; }

    public string ReferringProviderName { get; set; } = null!;

    public bool IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public virtual ICollection<Lismaster> Lismasters { get; set; } = new List<Lismaster>();
}
