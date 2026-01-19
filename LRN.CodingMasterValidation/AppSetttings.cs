using System.Collections.Generic;

namespace LRN.CodingMasterValidation
{
    public class ValidationSettings
    {
        public List<string> FallbackPayerPatterns { get; set; } = new List<string>();
        public CodingMasterSettings CodingMaster { get; set; } = new CodingMasterSettings();
        public OutputSettings Output { get; set; } = new OutputSettings();
    }

    public class CodingMasterSettings
    {
        public string FilePath { get; set; } = @"E:\LRN-Data\CodingMaster\Inputs\PCRDX-CodingMaster.xlsx";
        public ColumnMappings ColumnMappings { get; set; } = new ColumnMappings();
    }

    public class ColumnMappings
    {
        public string ProductionPanelName { get; set; } = "Production Panel Name";
        public string Payer { get; set; } = "Payer";
        public string Procedure { get; set; } = "Procedure";
    }

    public class OutputSettings
    {
        public string OutputDirectory { get; set; } = @"E:\LRN-Data\CodingMaster\Outputs";
        public string ValidationReportSuffix { get; set; } = "_Validated";
    }
}