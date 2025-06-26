namespace LRN.ExcelToSqlETL.Core.Models
{
    public class ExcelSheetMapping
    {
        public string SheetName { get; set; }
        public string TargetTable { get; set; }
        public bool UseSheetName { get; set; }
        public bool UseDynamicSchema { get; set; }
        public List<ColumnMapping> Columns { get; set; }
    }
}
