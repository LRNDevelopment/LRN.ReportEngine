namespace LRN.ExcelToSqlETL.Core.Models
{
    public class MappingConfigRoot
    {
        public List<MappingEntry> Mappings { get; set; }
    }

    public class MappingEntry
    {
        public string FileIdentifier { get; set; }
        public string JsonMappingPath { get; set; }
        public string FileType { get; set; }
    }

    public class ColumnMapping
    {
        public string ExcelColumn { get; set; }
        public string SqlColumn { get; set; }
        public string DataType { get; set; }
        public bool Required { get; set; }
    }
}
