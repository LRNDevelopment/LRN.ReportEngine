using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

public partial class BillingProviderMaster
{
    public int BillingProviderId { get; set; }

    public string BillingProvider { get; set; } = null!;

    public bool IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public virtual ICollection<BillingMaster> BillingMasters { get; set; } = new List<BillingMaster>();

    public virtual ICollection<Lismaster> Lismasters { get; set; } = new List<Lismaster>();
}
