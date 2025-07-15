using System;
using System.Collections.Generic;

namespace LRN.DataLibrary.Models;

public partial class PanelGroup
{
    public int PanelGroupId { get; set; }

    public string PanelName { get; set; } = null!;

    public string OrderInfo { get; set; } = null!;

    public string PanelCategory { get; set; } = null!;

    public bool? IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public virtual ICollection<Lismaster> Lismasters { get; set; } = new List<Lismaster>();
}
