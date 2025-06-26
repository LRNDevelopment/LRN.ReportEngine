using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class BillingProviderMaster
{
    public int BillingProviderId { get; set; }

    public string BillingProvider { get; set; } = null!;

    public bool IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }
}
