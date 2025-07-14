namespace LRN.ExcelToSqlETL.Core.Models
{
    public class ValidationResult
    {
        public bool IsValid => !Errors.Any();
        public List<string> Errors { get; set; } = new();
    }

    public class FileLog
    {
        public int ImportFileId { get; set; }
        public string LogMessage { get; set; }

        public string LogType { get; set; }

        public int RowNo { get; set; }

        public string ColumnName { get; set; }
    }
}
