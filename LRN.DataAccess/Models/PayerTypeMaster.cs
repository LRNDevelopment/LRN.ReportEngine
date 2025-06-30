using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class PayerTypeMaster
{
    public int PayerTypeId { get; set; }

    public string PayerType { get; set; } = null!;

    public bool IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public virtual ICollection<BillingMaster> BillingMasters { get; set; } = new List<BillingMaster>();

    public virtual ICollection<Lismaster> Lismasters { get; set; } = new List<Lismaster>();
}
