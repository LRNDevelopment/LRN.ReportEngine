using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LRN.ExcelToSqlETL.Core.Models
{
    public class InsightData
    {
        public string PanelName { get; set; }
        public string PayerName { get; set; }
        public Dictionary<string, decimal> MonthlyAmounts { get; set; } = new();
    }
}
