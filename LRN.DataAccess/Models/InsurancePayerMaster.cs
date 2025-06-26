using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class InsurancePayerMaster
{
    public int InsurancePayerId { get; set; }

    public string PayerName { get; set; } = null!;

    public bool IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }
}
