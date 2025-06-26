using System;
using System.Collections.Generic;

namespace LRN.DataAccess.Models;

public partial class OperationsGroupMaster
{
    public int OperationGroupId { get; set; }

    public string OperationsGroup { get; set; } = null!;

    public bool IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }
}
