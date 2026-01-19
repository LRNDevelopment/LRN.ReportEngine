using ClosedXML.Excel;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace LRN.CodingMasterValidation
{
    public partial class Validator
    {
        private readonly string _productionCsvPath;
        private readonly string _codingMasterFile;
        private readonly ValidationSettings _settings;
        private readonly List<string> _fallbackPayerPatterns;
        private List<PayerMasterRecord> _payerMasterList;


        private readonly LabContext _lab;


        //public Validator(string productionCsvPath = null, string codingMasterFile = null)
        //{
        //    // Load configuration from appsettings.json
        //    _settings = LoadConfiguration();
        //    _fallbackPayerPatterns = _settings.FallbackPayerPatterns;

        //    // If no path provided, find the latest generated CSV
        //    _productionCsvPath = productionCsvPath ?? FindLatestProductionCSV();
        //    _codingMasterFile = codingMasterFile ?? _settings.CodingMaster.FilePath;
        //}

        public Validator(string productionCsvPath, LabContext lab)
        {
            _lab = lab;
            _settings = LoadConfiguration();
            _fallbackPayerPatterns = _settings.FallbackPayerPatterns;

            _productionCsvPath = productionCsvPath;
            // _codingMasterFile = lab.CodingMasterFile;
            Console.WriteLine($"📖 Loading Coding Master from: {_codingMasterFile}");

            _codingMasterFile = lab.ValidationCodingMasterFile;
           
            _settings.Output.OutputDirectory = lab.OutputFolder;
        }

        private ValidationSettings LoadConfiguration()
        {
            var settings = new ValidationSettings();

            try
            {
                // Try to load from appsettings.json
                var exePath = AppContext.BaseDirectory;

                var configuration = new ConfigurationBuilder()
                    .SetBasePath(exePath)
                    .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                    .Build();

                // Load FallbackPayerPatterns
                var patterns = configuration.GetSection("ValidationSettings:FallbackPayerPatterns").Get<List<string>>();
                if (patterns != null && patterns.Any())
                {
                    settings.FallbackPayerPatterns = patterns;
                }

                // Load CodingMaster settings - Use the PCRDX-CodingMaster.xlsx for validation
                settings.CodingMaster.FilePath = configuration["ValidationSettings:CodingMaster:FilePath"] ??
                    Path.Combine(
                        configuration["CodingMaster:InputFolder"] ?? @"E:\LRN-Data\CodingMaster\Inputs",
                        "PCRDX-CodingMaster.xlsx"
                    );

                // Load column mappings
                settings.CodingMaster.ColumnMappings.ProductionPanelName =
                    configuration["ValidationSettings:CodingMaster:ColumnMappings:ProductionPanelName"] ??
                    "Production Panel Name";
                settings.CodingMaster.ColumnMappings.Payer =
                    configuration["ValidationSettings:CodingMaster:ColumnMappings:Payer"] ?? "Payer";
                settings.CodingMaster.ColumnMappings.Procedure =
                    configuration["ValidationSettings:CodingMaster:ColumnMappings:Procedure"] ?? "Procedure";

                // Load output settings
                settings.Output.OutputDirectory = configuration["CodingMaster:OutputFolder"] ??
                    configuration["ValidationSettings:Output:OutputDirectory"] ??
                    @"E:\LRN-Data\CodingMaster\Outputs";

                settings.Output.ValidationReportSuffix =
                    configuration["ValidationSettings:Output:ValidationReportSuffix"] ?? "_Validated";

                Console.WriteLine($"📁 Input Folder: {configuration["CodingMaster:InputFolder"]}");
                Console.WriteLine($"📁 Output Folder: {settings.Output.OutputDirectory}");
                Console.WriteLine($"📄 Production Master: {configuration["CodingMaster:ExcelFileName"]}");
                Console.WriteLine($"📄 Coding Master: {Path.GetFileName(settings.CodingMaster.FilePath)}");

            }
            catch (Exception ex)
            {
                Console.WriteLine($"⚠️ Warning: Could not load configuration from appsettings.json: {ex.Message}");
                Console.WriteLine($"Using default settings...");

                // Set default paths
                string inputFolder = @"C:\CodingMasterFiles\Inputs";
                string outputFolder = @"C:\CodingMasterFiles\Outputs";

                settings.CodingMaster.FilePath = Path.Combine(inputFolder, "PCRDX-CodingMaster.xlsx");
                settings.Output.OutputDirectory = outputFolder;
            }

            // Ensure output directory exists
            if (!Directory.Exists(settings.Output.OutputDirectory))
            {
                Directory.CreateDirectory(settings.Output.OutputDirectory);
                Console.WriteLine($"📁 Created output directory: {settings.Output.OutputDirectory}");
            }

            return settings;
        }

        private bool IsFallbackPayer(string payerName)
        {
            if (string.IsNullOrWhiteSpace(payerName))
                return false;

            // Check against configured fallback patterns
            foreach (var pattern in _fallbackPayerPatterns)
            {
                if (string.Equals(payerName.Trim(), pattern.Trim(), StringComparison.OrdinalIgnoreCase))
                    return true;
            }

            return false;
        }

        // ✅ ADD HERE (Validator class, NOT nested class)
        internal string GetEffectivePanelName(ProductionRecord prod)
        {
            // PCRAL-only override
            if (_lab != null &&
                _lab.InputFolder.Contains(@"\PCRAL\", StringComparison.OrdinalIgnoreCase) &&
                !string.IsNullOrWhiteSpace(prod.Panel1))
            {
                return prod.Panel1.Trim();
            }

            return prod.PanelName?.Trim();
        }


        public List<ValidationResult> Execute()
        {
            Console.WriteLine("\n" + "=".PadRight(60, '='));
            Console.WriteLine("STEP 2: VALIDATE WITH CODING MASTER & ADD EXPECTED CODES");
            Console.WriteLine("=".PadRight(60, '='));

            try
            {
                Console.WriteLine($"📥 Loading production data: {_productionCsvPath}");
                Console.WriteLine($"📚 Loading coding master: {_codingMasterFile}");
                Console.WriteLine($"📋 Using {_fallbackPayerPatterns.Count} fallback payer patterns");
                Console.WriteLine($"📁 Output directory: {_settings.Output.OutputDirectory}");

                var productionRecords = LoadProductionData(_productionCsvPath);
                var codingMaster = LoadCodingMaster(_codingMasterFile);

                Console.WriteLine($"🔍 Validating {productionRecords.Count} records...");
                _payerMasterList = LoadPayerMaster(_lab.PayerMasterFile);
                if (_payerMasterList == null || _payerMasterList.Count == 0)
                {
                    Console.WriteLine("⚠️ PayerMaster is empty or not loaded. Fallback only will be used.");
                }

                //var validationResults = ValidateRecords(productionRecords, codingMaster); commented
                // var validationResults = ValidateRecords_UsingPayerMasterOnly(productionRecords, codingMaster);

                var optimized = new PayerMasterOptimizedValidator(this,_payerMasterList,codingMaster);

                var validationResults = optimized.Validate(productionRecords);


                // Generate output path based on input file name
                string outputFilePath = GenerateOutputFilePath(_productionCsvPath);
                GenerateValidationReport(validationResults, outputFilePath);

                return validationResults;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error in Step 2: {ex.Message}");
                Console.WriteLine($"Stack Trace: {ex.StackTrace}");
                return new List<ValidationResult>();
            }
        }
        private List<ValidationResult> ValidateRecords_UsingPayerMasterOnly(
        List<ProductionRecord> production,
        List<CodingMasterRecord> codingMaster)
        {
            var results = new List<ValidationResult>();

            Console.WriteLine("\n🔍 Matching Logic (NEW):");
            Console.WriteLine("  1. Carrier → PayerMaster → Payer_Common_Code");
            Console.WriteLine("  2. Panel + Payer_Common_Code → CodingMaster");
            Console.WriteLine("  3. Fallback payer if Common Code not matched");

            foreach (var prod in production)
            {
                var result = new ValidationResult(prod);
                bool matched = false;

                // ================= PRIMARY: PayerMaster → Common Code =================
                string payerCommonCode = GetPayerCommonCode(prod.Carrier, _payerMasterList);
                result.PayerCommonCode = payerCommonCode;


                if (!string.IsNullOrWhiteSpace(payerCommonCode))
                {
                    var commonCodeMatch = GetExpectedCPTByCommonCode(
                        prod,
                        codingMaster,
                        payerCommonCode);

                    if (commonCodeMatch != null && !string.IsNullOrWhiteSpace(commonCodeMatch.Procedure))
                    {
                        result.HasMatch = true;
                        result.MatchType = "PayerMaster → CommonCode Match";
                        matched = true;

                        ApplyCptComparison(result, prod, commonCodeMatch.Procedure);
                    }
                }

                // ================= FALLBACK: Only if CommonCode NOT matched =================
                if (!matched)
                {
                    var fallbackMatch = codingMaster.FirstOrDefault(m =>
                        string.Equals(m.ProductionPanelName?.Trim(), prod.PanelName?.Trim(), StringComparison.OrdinalIgnoreCase) &&
                        IsFallbackPayer(m.Payer));

                    if (fallbackMatch != null && !string.IsNullOrWhiteSpace(fallbackMatch.Procedure))
                    {
                        result.HasMatch = true;
                        result.MatchType = $"Fallback: {fallbackMatch.Payer}";
                        matched = true;

                        ApplyCptComparison(result, prod, fallbackMatch.Procedure);
                    }
                }

                // ================= NO MATCH =================
                if (!matched)
                {
                    result.HasMatch = false;
                    result.MatchType = "No Match";
                    result.SortedActualCPTCodes = SortCPTCodes(prod.ActualCPTCode);
                }

                results.Add(result);
            }

            Console.WriteLine($"📊 NEW Validation Completed: {results.Count} records");
            return results;
        }

        private void ApplyCptComparison(ValidationResult result,ProductionRecord prod,string expectedProcedure)
        {
            string sortedExpected = SortCPTCodes(expectedProcedure);
            result.ExpectedCPTCodes = new List<string> { sortedExpected };

            result.SortedActualCPTCodes = SortCPTCodes(prod.ActualCPTCode);

            var actualDetails = ParseCPTCodesWithDetails(prod.ActualCPTCode);
            var expectedDetails = ParseCPTCodesWithDetails(expectedProcedure);

            CalculateMismatches(actualDetails, expectedDetails, result);
            AppendModifierOnlyRemarks(actualDetails, expectedDetails, result);
        }

        private string GenerateOutputFilePath(string inputFilePath)
        {
            // Get the input file name without extension
            string inputFileName = Path.GetFileNameWithoutExtension(inputFilePath);

            // Add suffix and .csv extension
            string outputFileName = $"{inputFileName}{_settings.Output.ValidationReportSuffix}.csv";

            // Combine with output directory
            return Path.Combine(_settings.Output.OutputDirectory, outputFileName);
        }

        private string FindLatestProductionCSV()
        {
            string outputFolder = _settings.Output.OutputDirectory;

            // Try to get input folder from configuration
            string inputFolder = "";
            try
            {
                var configuration = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                    .Build();

                inputFolder = configuration["CodingMaster:InputFolder"] ??
                             Path.Combine(Path.GetDirectoryName(outputFolder) ?? @"E:\LRN-Data\CodingMaster", "Inputs");
            }
            catch
            {
                inputFolder = Path.Combine(Path.GetDirectoryName(outputFolder) ?? @"E:\LRN-Data\CodingMaster", "Inputs");
            }

            string fallbackPath = Path.Combine(inputFolder, "ProductionMaster_Extracted.csv");

            try
            {
                // First check output folder for latest generated CSV
                if (Directory.Exists(outputFolder))
                {
                    var files = Directory.GetFiles(outputFolder, "ProductionMaster_Extracted_*.csv");
                    if (files.Length > 0)
                    {
                        // Get the most recent file based on creation time
                        var latestFile = files
                            .Select(f => new FileInfo(f))
                            .OrderByDescending(f => f.CreationTime)
                            .First()
                            .FullName;

                        Console.WriteLine($"📄 Found latest CSV: {Path.GetFileName(latestFile)}");
                        return latestFile;
                    }
                }

                // Fallback to input folder
                if (Directory.Exists(inputFolder))
                {
                    var files = Directory.GetFiles(inputFolder, "ProductionMaster_Extracted*.csv");
                    if (files.Length > 0)
                    {
                        var latestFile = files
                            .Select(f => new FileInfo(f))
                            .OrderByDescending(f => f.CreationTime)
                            .First()
                            .FullName;
                        Console.WriteLine($"📄 Found CSV in input folder: {Path.GetFileName(latestFile)}");
                        return latestFile;
                    }
                }

                // If nothing found, return fallback path
                Console.WriteLine($"⚠️ No production CSV found, using fallback: {fallbackPath}");
                return fallbackPath;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"⚠️ Error finding latest CSV: {ex.Message}");
                Console.WriteLine($"   Using fallback: {fallbackPath}");
                return fallbackPath;
            }
        }
        // ==================== CORE METHODS ====================
        private List<ProductionRecord> LoadProductionData(string csvPath)
        {
            var records = new List<ProductionRecord>();

            if (!File.Exists(csvPath))
                throw new FileNotFoundException($"Production CSV not found: {csvPath}");

            using (var reader = new StreamReader(csvPath))
            {
                reader.ReadLine(); // Skip header

                while (!reader.EndOfStream)
                {
                    var line = reader.ReadLine();
                    if (string.IsNullOrWhiteSpace(line)) continue;

                    //var values = ParseCsvLine(line);
                    var values = ParseCsvLineSafe(line);

                    if (values.Length >= 7)
                    {
                        records.Add(new ProductionRecord
                        {
                            VisitNumber = values[0],
                            AccessionNo = values[1],
                            PanelName = values[2],
                            Carrier = values[3],
                            ActualCPTCode = values[4],
                            TotalCharge = decimal.TryParse(values[5], out decimal charge) ? charge : 0,
                            Panel1 = values[6]
                        });
                    }
                }
            }

            return records;
        }

        private string[] ParseCsvLineSafe(string line)
        {
            var fields = new List<string>();
            bool inQuotes = false;
            var current = new StringBuilder();

            foreach (char c in line)
            {
                if (c == '"')
                {
                    inQuotes = !inQuotes;
                }
                else if (c == ',' && !inQuotes)
                {
                    fields.Add(current.ToString());
                    current.Clear();
                }
                else
                {
                    current.Append(c);
                }
            }

            fields.Add(current.ToString());

            return fields.Select(f => f.Trim('"')).ToArray();
        }

        private List<PayerMasterRecord> LoadPayerMaster(string payerMasterPath)
        {
            var list = new List<PayerMasterRecord>();

            if (!File.Exists(payerMasterPath))
                throw new FileNotFoundException($"PayerMaster file not found: {payerMasterPath}");

            using var workbook = new XLWorkbook(payerMasterPath);
            var ws = workbook.Worksheet(1);
            var range = ws.RangeUsed();

            if (range == null)
                return list;

            var header = range.Row(1)
                .Cells()
                .Select((c, i) => new { Name = c.GetString().Trim(), Index = i + 1 })
                .Where(x => !string.IsNullOrWhiteSpace(x.Name))
                .ToDictionary(x => x.Name, x => x.Index, StringComparer.OrdinalIgnoreCase);

            for (int r = 2; r <= range.RowCount(); r++)
            {
                var row = ws.Row(r);

                // 🔴 IMPORTANT: Skip fully empty rows
                string payerNameRaw = row.Cell(header["Payer_Name_Raw"]).GetString()?.Trim();

                if (string.IsNullOrWhiteSpace(payerNameRaw))
                    continue; // ⛔ skip empty row

                list.Add(new PayerMasterRecord
                {
                    Global_Payer_ID = row.Cell(header["Global_Payer_ID"]).GetString().Trim(),
                    Payer_Code = row.Cell(header["Payer_Code"]).GetString().Trim(),
                    Payer_Common_Code = row.Cell(header["Payer_Common_Code"]).GetString().Trim(),
                    Payer_Group_Code = row.Cell(header["Payer_Group_Code"]).GetString().Trim(),
                    Payer_Name_Raw = payerNameRaw,
                    Payer_Name_Normalized = row.Cell(header["Payer_Name_Normalized"]).GetString().Trim(),
                    Plan_Type = row.Cell(header["Plan_Type"]).GetString().Trim(),
                    Payer_State = row.Cell(header["Payer_State"]).GetString().Trim(),
                    Is_Active = row.Cell(header["Is_Active"]).GetString().Trim(),
                    Global_Payer_ID2 = row.Cell(header["Global_Payer_ID2"]).GetString().Trim()
                });
            }

            Console.WriteLine($"✅ Loaded {list.Count} valid PayerMaster records");
            return list;
        }


        private List<CodingMasterRecord> LoadCodingMaster(string filePath)
        {
            var records = new List<CodingMasterRecord>();

            if (!File.Exists(filePath))
                throw new FileNotFoundException($"Coding Master file not found: {filePath}");

            Console.WriteLine($"📖 Reading Coding Master from: {Path.GetFileName(filePath)}");

            using (var workbook = new XLWorkbook(filePath))
            {
                // Try to get worksheet by name or use first worksheet
                var worksheet = workbook.Worksheet(1);
                if (worksheet == null)
                    throw new Exception("No worksheets found in Coding Master file");

                var dataRange = worksheet.RangeUsed();
                if (dataRange == null)
                {
                    Console.WriteLine("⚠️ No data found in Coding Master worksheet");
                    return records;
                }

                // Get header row to find column indices
                var headerRow = worksheet.Row(1);
                var columnMapping = FindCodingMasterColumns(headerRow);

                // Validate that we found all required columns
                if (!ValidateCodingMasterColumns(columnMapping))
                {
                    throw new Exception("Could not find required columns in Coding Master file");
                }

                int rowCount = dataRange.RowCount();
                Console.WriteLine($"📊 Coding master rows: {rowCount - 1}");

                // Process data rows
                int loadedCount = 0;
                int fallbackRecordsCount = 0;
                for (int rowNum = 2; rowNum <= rowCount; rowNum++)
                {
                    var row = worksheet.Row(rowNum);

                    var record = new CodingMasterRecord
                    {
                        ProductionPanelName = GetCellStringValue(row.Cell(columnMapping[_settings.CodingMaster.ColumnMappings.ProductionPanelName])),
                        Payer = GetCellStringValue(row.Cell(columnMapping[_settings.CodingMaster.ColumnMappings.Payer])),
                        Procedure = GetCellStringValue(row.Cell(columnMapping[_settings.CodingMaster.ColumnMappings.Procedure]))
                    };

                    // Check if this is a fallback payer record
                    if (IsFallbackPayer(record.Payer))
                    {
                        record.IsFallbackPayer = true;
                        fallbackRecordsCount++;
                    }

                    // Only add if it has required data
                    if (!string.IsNullOrWhiteSpace(record.ProductionPanelName))
                    {
                        records.Add(record);
                        loadedCount++;
                    }

                    // Show progress
                    if (rowNum % 1000 == 0)
                        Console.Write(".");
                }

                Console.WriteLine(); // New line after progress dots
                Console.WriteLine($"✅ Loaded {loadedCount} valid records from Coding Master");
                Console.WriteLine($"   Fallback payer records: {fallbackRecordsCount}");
            }

            return records;
        }

        private Dictionary<string, int> FindCodingMasterColumns(IXLRow headerRow)
        {
            var columnMapping = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);

            // Get configured column names
            var productionPanelName = _settings.CodingMaster.ColumnMappings.ProductionPanelName;
            var payer = _settings.CodingMaster.ColumnMappings.Payer;
            var procedure = _settings.CodingMaster.ColumnMappings.Procedure;

            Console.WriteLine($"🔍 Scanning columns for: '{productionPanelName}', '{payer}', '{procedure}'");

            foreach (var cell in headerRow.Cells())
            {
                var headerValue = cell.Value.ToString().Trim();
                var columnNumber = cell.Address.ColumnNumber;

                if (!string.IsNullOrEmpty(headerValue))
                {
                    Console.WriteLine($"   Column {columnNumber}: '{headerValue}'");
                }
            }

            // Try exact matches first
            foreach (var cell in headerRow.Cells())
            {
                var headerValue = cell.Value.ToString().Trim();
                var columnNumber = cell.Address.ColumnNumber;

                // Exact match for Production Panel Name
                if (string.Equals(headerValue, productionPanelName, StringComparison.OrdinalIgnoreCase))
                {
                    columnMapping[productionPanelName] = columnNumber;
                    Console.WriteLine($"   ✓ '{productionPanelName}' found at column {columnNumber}");
                }
                // Exact match for Payer
                else if (string.Equals(headerValue, payer, StringComparison.OrdinalIgnoreCase))
                {
                    columnMapping[payer] = columnNumber;
                    Console.WriteLine($"   ✓ '{payer}' found at column {columnNumber}");
                }
                // Exact match for Procedure
                else if (string.Equals(headerValue, procedure, StringComparison.OrdinalIgnoreCase))
                {
                    columnMapping[procedure] = columnNumber;
                    Console.WriteLine($"   ✓ '{procedure}' found at column {columnNumber}");
                }
            }

            // If exact matches not found, try flexible matching
            if (!columnMapping.ContainsKey(productionPanelName))
            {
                var foundColumn = FindColumnFlexible(headerRow, productionPanelName,
                    new[] { "Production Panel Name", "ProductionPanelName", "Panel Name", "PanelName", "Panel" });
                if (foundColumn > 0)
                {
                    columnMapping[productionPanelName] = foundColumn;
                }
            }

            if (!columnMapping.ContainsKey(payer))
            {
                var foundColumn = FindColumnFlexible(headerRow, payer,
                    new[] { "Payer", "Carrier", "Insurance", "Insurance Company" });
                if (foundColumn > 0)
                {
                    columnMapping[payer] = foundColumn;
                }
            }

            if (!columnMapping.ContainsKey(procedure))
            {
                var foundColumn = FindColumnFlexible(headerRow, procedure,
                    new[] { "Procedure", "CPT Codes", "Expected CPT", "CPT", "CPT Code", "Codes" });
                if (foundColumn > 0)
                {
                    columnMapping[procedure] = foundColumn;
                }
            }

            return columnMapping;
        }

        private int FindColumnFlexible(IXLRow headerRow, string targetColumn, string[] possibleNames)
        {
            foreach (var cell in headerRow.Cells())
            {
                var headerValue = cell.Value.ToString().Trim();
                foreach (var name in possibleNames)
                {
                    if (headerValue.Contains(name, StringComparison.OrdinalIgnoreCase))
                    {
                        Console.WriteLine($"   ⚠️  '{targetColumn}' not found, using '{headerValue}' at column {cell.Address.ColumnNumber}");
                        return cell.Address.ColumnNumber;
                    }
                }
            }
            return 0;
        }

        private string GetCellStringValue(IXLCell cell)
        {
            if (cell == null || IsCellEmpty(cell))
                return "";

            try
            {
                return cell.Value.ToString().Trim();
            }
            catch
            {
                return "";
            }
        }

        private bool IsCellEmpty(IXLCell cell)
        {
            if (cell == null)
                return true;

            try
            {
                return cell.IsEmpty();
            }
            catch
            {
                try
                {
                    var cellValue = cell.Value;
                    if (cellValue.Type == XLDataType.Blank || cellValue.IsBlank)
                        return true;

                    string stringValue = cellValue.ToString();
                    return string.IsNullOrWhiteSpace(stringValue);
                }
                catch
                {
                    return true;
                }
            }
        }

        // Your CPT parsing and sorting methods go here (the ones from your partial class)
        // Add this helper method to parse CPT with modifier and units
        //private CPTInfo ParseCPTItem(string cptString)
        //{
        //    // Format examples:
        //    // 87641-XU*1 (has modifier XU, units=1)
        //    // 87481*5 (no modifier, units=5)
        //    // 87641 (no modifier, default units=1)
        //    // 87640-59 (has modifier 59, default units=1)
        //    // 87500 (no modifier, default units=1)

        //    string code = cptString.Trim();
        //    string modifier = "";
        //    int units = 1; // Default to 1 unit if not specified

        //    // Check for units (*)
        //    int unitIndex = code.IndexOf('*');
        //    if (unitIndex > 0)
        //    {
        //        string unitStr = code.Substring(unitIndex + 1);
        //        if (int.TryParse(unitStr, out int parsedUnits))
        //        {
        //            units = parsedUnits;
        //        }
        //        code = code.Substring(0, unitIndex);
        //    }

        //    // Check for modifier (-)
        //    int modifierIndex = code.IndexOf('-');
        //    if (modifierIndex > 0)
        //    {
        //        modifier = code.Substring(modifierIndex + 1).Trim();
        //        code = code.Substring(0, modifierIndex).Trim();

        //        // Handle multiple modifiers
        //        if (modifier.Contains(';'))
        //        {
        //            var modifiers = modifier.Split(';', StringSplitOptions.RemoveEmptyEntries);
        //            modifier = modifiers.FirstOrDefault()?.Trim() ?? "";
        //        }
        //    }

        //    return new CPTInfo
        //    {
        //        BaseCode = code,
        //        Modifier = modifier,
        //        Units = units,
        //        FullCode = cptString.Trim()
        //    };
        //}

        private CPTInfo ParseCPTItem(string cptString)
        {
            // Format examples:
            // 87641-XU*1 (has modifier XU, units=1)
            // 87641-59;GW*1 (has multiple modifiers 59 and GW, units=1)
            // 87481*5 (no modifier, units=5)
            // 87641 (no modifier, default units=1)
            // 87640-59 (has modifier 59, default units=1)
            // 87500 (no modifier, default units=1)

            string code = cptString.Trim();
            string modifier = "";
            int units = 1; // Default to 1 unit if not specified

            // Check for units (*)
            int unitIndex = code.IndexOf('*');
            if (unitIndex > 0)
            {
                string unitStr = code.Substring(unitIndex + 1);
                if (int.TryParse(unitStr, out int parsedUnits))
                {
                    units = parsedUnits;
                }
                code = code.Substring(0, unitIndex);
            }

            // Check for modifier (-)
            int modifierIndex = code.IndexOf('-');
            if (modifierIndex > 0)
            {
                modifier = code.Substring(modifierIndex + 1).Trim();
                code = code.Substring(0, modifierIndex).Trim();

                // Keep the full modifier string including semicolons
                // We'll handle splitting later in AppendModifierOnlyRemarks
            }

            return new CPTInfo
            {
                BaseCode = code,
                Modifier = modifier,
                Units = units,
                FullCode = cptString.Trim()
            };
        }


        private class CPTGroupInfo
        {
            public int TotalUnits { get; set; }
            public List<CPTInfo> Details { get; set; }
            public List<string> Modifiers { get; set; }
            public bool HasModifier { get; set; }
        }


        private class CPTInfo
        {
            public string BaseCode { get; set; }
            public string Modifier { get; set; }
            public int Units { get; set; }
            public string FullCode { get; set; }

            // New property to get all modifiers as list
            public List<string> GetAllModifiers()
            {
                if (string.IsNullOrEmpty(Modifier))
                    return new List<string>();

                return Modifier.Split(';', StringSplitOptions.RemoveEmptyEntries)
                    .Select(m => m.Trim())
                    .Where(m => !string.IsNullOrEmpty(m))
                    .ToList();
            }

            public override string ToString()
            {
                string result = BaseCode;
                if (!string.IsNullOrEmpty(Modifier))
                    result += $"-{Modifier}";
                if (Units > 1)
                    result += $"*{Units}";
                return result;
            }

            // Helper method for sorting
            public string GetSortKey()
            {
                return $"{BaseCode.PadLeft(10, '0')}-{Modifier ?? "ZZZ"}-{Units.ToString().PadLeft(3, '0')}";
            }
        }
        //private class CPTInfo
        //{
        //    public string BaseCode { get; set; }
        //    public string Modifier { get; set; }
        //    public int Units { get; set; }
        //    public string FullCode { get; set; }

        //    public override string ToString()
        //    {
        //        string result = BaseCode;
        //        if (!string.IsNullOrEmpty(Modifier))
        //            result += $"-{Modifier}";
        //        if (Units > 1)
        //            result += $"*{Units}";
        //        return result;
        //    }

        //    // Helper method for sorting
        //    public string GetSortKey()
        //    {
        //        return $"{BaseCode.PadLeft(10, '0')}-{Modifier ?? "ZZZ"}-{Units.ToString().PadLeft(3, '0')}";
        //    }
        //}

        // New method to parse CPT codes with full details
        private List<CPTInfo> ParseCPTCodesWithDetails(string cptString)
        {
            var result = new List<CPTInfo>();

            if (string.IsNullOrWhiteSpace(cptString))
                return result;

            // Handle multiple CPT codes separated by commas
            var items = cptString.Split(',', StringSplitOptions.RemoveEmptyEntries);

            foreach (var item in items)
            {
                try
                {
                    var detail = ParseCPTItem(item.Trim());
                    if (detail != null && !string.IsNullOrEmpty(detail.BaseCode))
                    {
                        result.Add(detail);
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"⚠️ Error parsing CPT item '{item}': {ex.Message}");
                }
            }

            return result;
        }

        // Update the old ParseCPTCodes method (keep for backward compatibility if needed)
        private Dictionary<string, int> ParseCPTCodes(string cptString)
        {
            var result = new Dictionary<string, int>();

            if (string.IsNullOrWhiteSpace(cptString))
                return result;

            // Use the new detailed parsing method
            var details = ParseCPTCodesWithDetails(cptString);

            // Aggregate by base code only (ignoring modifiers)
            foreach (var detail in details)
            {
                if (result.ContainsKey(detail.BaseCode))
                {
                    result[detail.BaseCode] += detail.Units;
                }
                else
                {
                    result[detail.BaseCode] = detail.Units;
                }
            }

            return result;
        }

        private string CleanCarrierName(string carrier)
        {
            if (string.IsNullOrWhiteSpace(carrier))
                return "";

            // Trim spaces first
            carrier = carrier.Trim();

            // Find the first hyphen
            int hyphenIndex = carrier.IndexOf('-');

            if (hyphenIndex > 0)
            {
                // Take everything before the hyphen and trim
                return carrier.Substring(0, hyphenIndex).Trim();
            }

            // No hyphen found, return original trimmed
            return carrier;
        }

        private void UpdateModifierRemarks(
        Dictionary<string, CPTGroupInfo> expectedByBaseCode,
        Dictionary<string, CPTGroupInfo> actualByBaseCode,
        List<string> remarks)
        {
            // Check each CPT code for modifier differences
            foreach (var expected in expectedByBaseCode)
            {
                if (actualByBaseCode.ContainsKey(expected.Key))
                {
                    var actual = actualByBaseCode[expected.Key];

                    // Check modifiers in detail
                    if (expected.Value.HasModifier && !actual.HasModifier)
                    {
                        // Expected has modifier but actual doesn't
                        foreach (var expectedModifier in expected.Value.Modifiers)
                        {
                            if (string.IsNullOrEmpty(expectedModifier))
                                remarks.Add($"Modifier missed for {expected.Key}: Expected no modifier");
                            else
                                remarks.Add($"Modifier missed for {expected.Key}: Expected '{expectedModifier}'");
                        }
                    }
                    else if (!expected.Value.HasModifier && actual.HasModifier)
                    {
                        // Actual has modifier but expected doesn't
                        foreach (var actualModifier in actual.Modifiers)
                        {
                            if (string.IsNullOrEmpty(actualModifier))
                                remarks.Add($"Unexpected modifier for {expected.Key}: Found none");
                            else
                                remarks.Add($"Unexpected modifier for {expected.Key}: Found '{actualModifier}'");
                        }
                    }
                    else if (expected.Value.HasModifier && actual.HasModifier)
                    {
                        // Both have modifiers, check for differences
                        var missingModifiers = expected.Value.Modifiers.Except(actual.Modifiers);
                        var extraModifiers = actual.Modifiers.Except(expected.Value.Modifiers);

                        foreach (var missingModifier in missingModifiers)
                        {
                            if (string.IsNullOrEmpty(missingModifier))
                                remarks.Add($"Modifier missed for {expected.Key}: Expected no modifier");
                            else
                                remarks.Add($"Modifier missed for {expected.Key}: Expected '{missingModifier}'");
                        }

                        foreach (var extraModifier in extraModifiers)
                        {
                            if (string.IsNullOrEmpty(extraModifier))
                                remarks.Add($"Unexpected modifier for {expected.Key}: Found none");
                            else
                                remarks.Add($"Unexpected modifier for {expected.Key}: Found '{extraModifier}'");
                        }
                    }
                }
            }

            // Also check for modifiers in additional CPTs (CPTs that exist in actual but not in expected)
            foreach (var actual in actualByBaseCode)
            {
                if (!expectedByBaseCode.ContainsKey(actual.Key) && actual.Value.HasModifier)
                {
                    foreach (var actualModifier in actual.Value.Modifiers)
                    {
                        if (!string.IsNullOrEmpty(actualModifier))
                            remarks.Add($"Additional CPT {actual.Key} has modifier '{actualModifier}'");
                    }
                }
            }
        }
        //    private void CalculateMismatches(
        //List<CPTInfo> actualDetails,
        //List<CPTInfo> expectedDetails,
        //ValidationResult result)
        //    {
        //        var remarks = new List<string>();

        //        // 1. Group expected CPTs by base code (ignore modifiers for missing/additional)
        //        var expectedByBaseCode = expectedDetails
        //            .GroupBy(e => e.BaseCode)
        //            .ToDictionary(
        //                g => g.Key,
        //                g => new
        //                {
        //                    TotalUnits = g.Sum(x => x.Units),
        //                    Details = g.ToList(),
        //                    Modifiers = g.Where(x => !string.IsNullOrEmpty(x.Modifier))
        //                                 .Select(x => x.Modifier)
        //                                 .Distinct()
        //                                 .ToList(),
        //                    HasModifier = g.Any(x => !string.IsNullOrEmpty(x.Modifier))
        //                });

        //        // 2. Group actual CPTs by base code (ignore modifiers for missing/additional)
        //        var actualByBaseCode = actualDetails
        //            .GroupBy(a => a.BaseCode)
        //            .ToDictionary(
        //                g => g.Key,
        //                g => new
        //                {
        //                    TotalUnits = g.Sum(x => x.Units),
        //                    Details = g.ToList(),
        //                    Modifiers = g.Where(x => !string.IsNullOrEmpty(x.Modifier))
        //                                 .Select(x => x.Modifier)
        //                                 .Distinct()
        //                                 .ToList(),
        //                    HasModifier = g.Any(x => !string.IsNullOrEmpty(x.Modifier))
        //                });

        //        // 3. Check for missing base codes (in expected but not in actual) - IGNORE MODIFIERS
        //        foreach (var expected in expectedByBaseCode)
        //        {
        //            if (!actualByBaseCode.ContainsKey(expected.Key))
        //            {
        //                // CPT base code is completely missing from actual
        //                // Add missing CPT with units only (no modifier)
        //                string missingCode = $"{expected.Key}*{expected.Value.TotalUnits}";
        //                result.MissingCPTCodes[missingCode] = 1;
        //                remarks.Add($"Missing CPT: {expected.Key}");
        //            }
        //            else
        //            {
        //                // CPT base code exists, check units only
        //                var actual = actualByBaseCode[expected.Key];

        //                // Check units (IGNORE MODIFIERS for missing/additional)
        //                if (actual.TotalUnits < expected.Value.TotalUnits)
        //                {
        //                    int missingUnits = expected.Value.TotalUnits - actual.TotalUnits;
        //                    string missingUnitCode = $"{expected.Key}*{missingUnits}";
        //                    result.MissingCPTCodes[missingUnitCode] = 1;
        //                    remarks.Add($"Missing {missingUnits} units for {expected.Key}");
        //                }
        //                else if (actual.TotalUnits > expected.Value.TotalUnits)
        //                {
        //                    int extraUnits = actual.TotalUnits - expected.Value.TotalUnits;
        //                    string extraUnitCode = $"{expected.Key}*{extraUnits}";
        //                    result.AdditionalCPTCodes[extraUnitCode] = 1;
        //                    remarks.Add($"Extra {extraUnits} units for {expected.Key}");
        //                }

        //                // MODIFIER CHECK: Only for remarks, not for missing/additional codes
        //                if (expected.Value.HasModifier && !actual.HasModifier)
        //                {
        //                    // Expected has modifier but actual doesn't
        //                    foreach (var expectedModifier in expected.Value.Modifiers)
        //                    {
        //                        if (string.IsNullOrEmpty(expectedModifier))
        //                            remarks.Add($"Missing expected modifier (blank/none) for {expected.Key}");
        //                        else
        //                            remarks.Add($"Missing modifier '{expectedModifier}' for {expected.Key}");
        //                    }
        //                }
        //                else if (!expected.Value.HasModifier && actual.HasModifier)
        //                {
        //                    // Actual has modifier but expected doesn't
        //                    foreach (var actualModifier in actual.Modifiers)
        //                    {
        //                        if (string.IsNullOrEmpty(actualModifier))
        //                            remarks.Add($"Unexpected modifier (blank/none) for {expected.Key}");
        //                        else
        //                            remarks.Add($"Unexpected modifier '{actualModifier}' for {expected.Key}");
        //                    }
        //                }
        //                else if (expected.Value.HasModifier && actual.HasModifier)
        //                {
        //                    // Both have modifiers, check for differences (for remarks only)
        //                    var missingModifiers = expected.Value.Modifiers.Except(actual.Modifiers);
        //                    var extraModifiers = actual.Modifiers.Except(expected.Value.Modifiers);

        //                    foreach (var missingModifier in missingModifiers)
        //                    {
        //                        if (string.IsNullOrEmpty(missingModifier))
        //                            remarks.Add($"Missing expected modifier (blank/none) for {expected.Key}");
        //                        else
        //                            remarks.Add($"Missing modifier '{missingModifier}' for {expected.Key}");
        //                    }

        //                    foreach (var extraModifier in extraModifiers)
        //                    {
        //                        if (string.IsNullOrEmpty(extraModifier))
        //                            remarks.Add($"Unexpected modifier (blank/none) for {expected.Key}");
        //                        else
        //                            remarks.Add($"Unexpected modifier '{extraModifier}' for {expected.Key}");
        //                    }
        //                }
        //            }
        //        }

        //        // 4. Check for additional base codes (in actual but not in expected) - IGNORE MODIFIERS
        //        foreach (var actual in actualByBaseCode)
        //        {
        //            if (!expectedByBaseCode.ContainsKey(actual.Key))
        //            {
        //                // This is a completely new CPT code in actual
        //                // Add additional CPT with units only (no modifier)
        //                string additionalCode = $"{actual.Key}*{actual.Value.TotalUnits}";
        //                result.AdditionalCPTCodes[additionalCode] = 1;
        //                remarks.Add($"Additional CPT: {actual.Key}");
        //            }
        //        }


        //        // ============ ADD THIS CALL ============
        //        // 5. Call the separate method to add modifier remarks
        //        UpdateModifierRemarks(expectedByBaseCode, actualByBaseCode, remarks);
        //        // ============ END ADD ============

        //        // Store remarks in result
        //        result.Remarks = remarks.Any() ? string.Join("; ", remarks) : "";
        //        //// Format and store remarks
        //        //if (remarks.Any())
        //        //{
        //        //    var formattedRemarks = UpdateRemarksFormat(remarks);
        //        //    result.Remarks = string.Join("; ", formattedRemarks);
        //        //}
        //        //else
        //        //{
        //        //    result.Remarks = "";
        //        //}
        //    }


        private void CalculateMismatches(
    List<CPTInfo> actualDetails,
    List<CPTInfo> expectedDetails,
    ValidationResult result)
        {
            var remarks = new List<string>();

            // Group expected CPTs by base code
            var expectedByBaseCode = expectedDetails
                .GroupBy(e => e.BaseCode)
                .ToDictionary(
                    g => g.Key,
                    g => new CPTGroupInfo
                    {
                        TotalUnits = g.Sum(x => x.Units),
                        Details = g.ToList(),
                        Modifiers = g.Where(x => !string.IsNullOrEmpty(x.Modifier))
                                     .Select(x => x.Modifier)
                                     .Distinct()
                                     .ToList(),
                        HasModifier = g.Any(x => !string.IsNullOrEmpty(x.Modifier))
                    });

            // Group actual CPTs by base code
            var actualByBaseCode = actualDetails
                .GroupBy(a => a.BaseCode)
                .ToDictionary(
                    g => g.Key,
                    g => new CPTGroupInfo
                    {
                        TotalUnits = g.Sum(x => x.Units),
                        Details = g.ToList(),
                        Modifiers = g.Where(x => !string.IsNullOrEmpty(x.Modifier))
                                     .Select(x => x.Modifier)
                                     .Distinct()
                                     .ToList(),
                        HasModifier = g.Any(x => !string.IsNullOrEmpty(x.Modifier))
                    });

            // Missing / unit comparison
            foreach (var expected in expectedByBaseCode)
            {
                if (!actualByBaseCode.ContainsKey(expected.Key))
                {
                    // Completely missing CPT
                    result.MissingCPTCodes[expected.Key] = expected.Value.TotalUnits;
                    remarks.Add($"Missing CPT: {expected.Key}");
                }
                else
                {
                    var actual = actualByBaseCode[expected.Key];

                    if (actual.TotalUnits < expected.Value.TotalUnits)
                    {
                        int missingUnits = expected.Value.TotalUnits - actual.TotalUnits;
                        result.MissingCPTCodes[expected.Key] = missingUnits;
                        remarks.Add($"Missing {missingUnits} units for {expected.Key}");
                    }
                    else if (actual.TotalUnits > expected.Value.TotalUnits)
                    {
                        int extraUnits = actual.TotalUnits - expected.Value.TotalUnits;
                        result.AdditionalCPTCodes[expected.Key] = extraUnits;
                        remarks.Add($"Extra {extraUnits} units for {expected.Key}");
                    }
                }
            }

            // Completely additional CPTs
            foreach (var actual in actualByBaseCode)
            {
                if (!expectedByBaseCode.ContainsKey(actual.Key))
                {
                    result.AdditionalCPTCodes[actual.Key] = actual.Value.TotalUnits;
                    remarks.Add($"Additional CPT: {actual.Key}");
                }
            }

            result.Remarks = remarks.Any() ? string.Join("; ", remarks) : "";
        }

        //    private void CalculateMismatches(List<CPTInfo> actualDetails,List<CPTInfo> expectedDetails,
        //ValidationResult result)
        //    {
        //        var remarks = new List<string>();

        //        // 1. Group expected CPTs by base code (ignore modifiers for missing/additional)
        //        var expectedByBaseCode = expectedDetails
        //            .GroupBy(e => e.BaseCode)
        //            .ToDictionary(
        //                g => g.Key,
        //                g => new CPTGroupInfo
        //                {
        //                    TotalUnits = g.Sum(x => x.Units),
        //                    Details = g.ToList(),
        //                    Modifiers = g.Where(x => !string.IsNullOrEmpty(x.Modifier))
        //                                 .Select(x => x.Modifier)
        //                                 .Distinct()
        //                                 .ToList(),
        //                    HasModifier = g.Any(x => !string.IsNullOrEmpty(x.Modifier))
        //                });

        //        // 2. Group actual CPTs by base code (ignore modifiers for missing/additional)
        //        var actualByBaseCode = actualDetails
        //            .GroupBy(a => a.BaseCode)
        //            .ToDictionary(
        //                g => g.Key,
        //                g => new CPTGroupInfo
        //                {
        //                    TotalUnits = g.Sum(x => x.Units),
        //                    Details = g.ToList(),
        //                    Modifiers = g.Where(x => !string.IsNullOrEmpty(x.Modifier))
        //                                 .Select(x => x.Modifier)
        //                                 .Distinct()
        //                                 .ToList(),
        //                    HasModifier = g.Any(x => !string.IsNullOrEmpty(x.Modifier))
        //                });

        //        // 3. Check for missing base codes (in expected but not in actual) - IGNORE MODIFIERS
        //        foreach (var expected in expectedByBaseCode)
        //        {
        //            if (!actualByBaseCode.ContainsKey(expected.Key))
        //            {
        //                // CPT base code is completely missing from actual
        //                // Add missing CPT with units only (no modifier)
        //                string missingCode = $"{expected.Key}*{expected.Value.TotalUnits}";
        //                result.MissingCPTCodes[missingCode] = 1;
        //                remarks.Add($"Missing CPT: {expected.Key}");
        //            }
        //            else
        //            {
        //                // CPT base code exists, check units only
        //                var actual = actualByBaseCode[expected.Key];

        //                // Check units (IGNORE MODIFIERS for missing/additional)
        //                if (actual.TotalUnits < expected.Value.TotalUnits)
        //                {
        //                    int missingUnits = expected.Value.TotalUnits - actual.TotalUnits;
        //                    string missingUnitCode = $"{expected.Key}*{missingUnits}";
        //                    result.MissingCPTCodes[missingUnitCode] = 1;
        //                    remarks.Add($"Missing {missingUnits} units for {expected.Key}");
        //                }
        //                else if (actual.TotalUnits > expected.Value.TotalUnits)
        //                {
        //                    int extraUnits = actual.TotalUnits - expected.Value.TotalUnits;
        //                    string extraUnitCode = $"{expected.Key}*{extraUnits}";
        //                    result.AdditionalCPTCodes[extraUnitCode] = 1;

        //                    remarks.Add($"Extra {extraUnits} units for {expected.Key}");
        //                }
        //            }
        //        }

        //        // 4. Check for additional base codes (in actual but not in expected) - IGNORE MODIFIERS
        //        foreach (var actual in actualByBaseCode)
        //        {
        //            if (!expectedByBaseCode.ContainsKey(actual.Key))
        //            {
        //                // This is a completely new CPT code in actual
        //                // Add additional CPT with units only (no modifier)
        //                string additionalCode = $"{actual.Key}*{actual.Value.TotalUnits}";
        //                result.AdditionalCPTCodes[additionalCode] = 1;
        //                remarks.Add($"Additional CPT: {actual.Key}");
        //            }
        //        }

        //        // 5. Call the separate method to add modifier remarks
        //       // UpdateModifierRemarks(expectedByBaseCode, actualByBaseCode, remarks);

        //        // Store remarks in result
        //        result.Remarks = remarks.Any() ? string.Join("; ", remarks) : "";
        //    }


        //       }
        //// ============ CORRECTED: Only set remarks once ============
        //           if (remarks.Any())
        //           {
        //               var formattedRemarks = UpdateRemarksFormat(remarks);
        //       result.Remarks = string.Join("; ", formattedRemarks);
        //   }
        //           else
        //           {
        //               result.Remarks = "";
        //           }
        // Update the CalculateMismatches method
        //private void CalculateMismatches(
        //    List<CPTInfo> actualDetails,
        //    List<CPTInfo> expectedDetails,
        //    ValidationResult result)
        //{
        //    var remarks = new List<string>();

        //    // 1. Group expected CPTs by base code to handle multiple entries
        //    var expectedByBaseCode = expectedDetails
        //        .GroupBy(e => e.BaseCode)
        //        .ToDictionary(
        //            g => g.Key,
        //            g => new
        //            {
        //                TotalUnits = g.Sum(x => x.Units),
        //                Details = g.ToList(),
        //                HasModifier = g.Any(x => !string.IsNullOrEmpty(x.Modifier))
        //            });

        //    // 2. Group actual CPTs by base code
        //    var actualByBaseCode = actualDetails
        //        .GroupBy(a => a.BaseCode)
        //        .ToDictionary(
        //            g => g.Key,
        //            g => new
        //            {
        //                TotalUnits = g.Sum(x => x.Units),
        //                Details = g.ToList(),
        //                HasModifier = g.Any(x => !string.IsNullOrEmpty(x.Modifier))
        //            });

        //    // 3. Check for missing base codes (in expected but not in actual)
        //    foreach (var expected in expectedByBaseCode)
        //    {
        //        if (!actualByBaseCode.ContainsKey(expected.Key))
        //        {
        //            // CPT base code is completely missing from actual
        //            // Format missing with all expected details
        //            foreach (var detail in expected.Value.Details)
        //            {
        //                result.MissingCPTCodes[detail.ToString()] = 1;
        //            }
        //            remarks.Add($"Missing CPT: {expected.Key}");
        //        }
        //        else
        //        {
        //            // CPT base code exists, check units and modifiers
        //            var actual = actualByBaseCode[expected.Key];

        //            // Check units
        //            if (actual.TotalUnits < expected.Value.TotalUnits)
        //            {
        //                int missingUnits = expected.Value.TotalUnits - actual.TotalUnits;
        //                result.MissingCPTCodes[$"{expected.Key}*{missingUnits}"] = 1;
        //                remarks.Add($"Missing {missingUnits} units for {expected.Key}");
        //            }
        //            else if (actual.TotalUnits > expected.Value.TotalUnits)
        //            {
        //                int extraUnits = actual.TotalUnits - expected.Value.TotalUnits;
        //                result.AdditionalCPTCodes[$"{expected.Key}*{extraUnits}"] = 1;
        //                remarks.Add($"Extra {extraUnits} units for {expected.Key}");
        //            }

        //            // Check modifiers
        //            if (expected.Value.HasModifier && !actual.HasModifier)
        //            {
        //                // Find which expected codes had modifiers
        //                var expectedWithModifiers = expected.Value.Details
        //                    .Where(d => !string.IsNullOrEmpty(d.Modifier))
        //                    .ToList();

        //                foreach (var expDetail in expectedWithModifiers)
        //                {
        //                    remarks.Add($"Missing modifier '{expDetail.Modifier}' for {expected.Key}");
        //                }
        //            }
        //            else if (!expected.Value.HasModifier && actual.HasModifier)
        //            {
        //                // Find which actual codes have modifiers
        //                var actualWithModifiers = actual.Details
        //                    .Where(d => !string.IsNullOrEmpty(d.Modifier))
        //                    .ToList();

        //                foreach (var actDetail in actualWithModifiers)
        //                {
        //                    remarks.Add($"Unexpected modifier '{actDetail.Modifier}' for {expected.Key}");
        //                }
        //            }
        //            else if (expected.Value.HasModifier && actual.HasModifier)
        //            {
        //                // Check for specific modifier mismatches
        //                // This is simplified - you might want more detailed comparison
        //                var expectedModifiers = expected.Value.Details
        //                    .Select(d => d.Modifier)
        //                    .Where(m => !string.IsNullOrEmpty(m))
        //                    .Distinct()
        //                    .ToList();

        //                var actualModifiers = actual.Details
        //                    .Select(d => d.Modifier)
        //                    .Where(m => !string.IsNullOrEmpty(m))
        //                    .Distinct()
        //                    .ToList();

        //                var missingModifiers = expectedModifiers.Except(actualModifiers);
        //                var extraModifiers = actualModifiers.Except(expectedModifiers);

        //                foreach (var modifier in missingModifiers)
        //                {
        //                    remarks.Add($"Missing modifier '{modifier}' for {expected.Key}");
        //                }

        //                foreach (var modifier in extraModifiers)
        //                {
        //                    remarks.Add($"Unexpected modifier '{modifier}' for {expected.Key}");
        //                }
        //            }
        //        }
        //    }

        //    // 4. Check for additional base codes (in actual but not in expected)
        //    foreach (var actual in actualByBaseCode)
        //    {
        //        if (!expectedByBaseCode.ContainsKey(actual.Key))
        //        {
        //            // This is a completely new CPT code in actual
        //            foreach (var detail in actual.Value.Details)
        //            {
        //                result.AdditionalCPTCodes[detail.ToString()] = 1;
        //            }
        //            remarks.Add($"Additional CPT: {actual.Key}");
        //        }
        //    }

        //    // Store remarks in result
        //    result.Remarks = string.Join("; ", remarks);
        //}

        // Update SortCPTCodes method to use the sort key
        public string SortCPTCodes(string cptString)
        {
            if (string.IsNullOrWhiteSpace(cptString))
                return "";

            // Parse all CPT items with details
            var details = ParseCPTCodesWithDetails(cptString);

            // Sort by base code, then modifier, then units
            var sortedDetails = details
                .OrderBy(d => d.BaseCode)
                .ThenBy(d => d.Modifier)
                .ThenBy(d => d.Units)
                .ToList();

            // Reconstruct the sorted string with proper formatting
            var sortedItems = new List<string>();
            foreach (var detail in sortedDetails)
            {
                string item = detail.BaseCode;
                if (!string.IsNullOrEmpty(detail.Modifier))
                    item += $"-{detail.Modifier}";

                // Always show units, even if it's 1
                item += $"*{detail.Units}";

                sortedItems.Add(item);
            }

            return string.Join(", ", sortedItems);
        }
        private bool ValidateCodingMasterColumns(Dictionary<string, int> columnMapping)
        {
            var requiredColumns = new[] {
                _settings.CodingMaster.ColumnMappings.ProductionPanelName,
                _settings.CodingMaster.ColumnMappings.Payer,
                _settings.CodingMaster.ColumnMappings.Procedure
            };

            var missingColumns = new List<string>();

            foreach (var column in requiredColumns)
            {
                if (!columnMapping.ContainsKey(column))
                    missingColumns.Add(column);
            }

            if (missingColumns.Any())
            {
                Console.WriteLine($"❌ Missing required columns in Coding Master:");
                foreach (var missing in missingColumns)
                {
                    Console.WriteLine($"   - {missing}");
                }

                // Show available columns for debugging
                Console.WriteLine("Available columns:");
                foreach (var mapping in columnMapping)
                {
                    Console.WriteLine($"   - {mapping.Key}: Column {mapping.Value}");
                }

                return false;
            }

            // Log found columns
            Console.WriteLine($"✅ Found Coding Master columns:");
            foreach (var column in requiredColumns)
            {
                Console.WriteLine($"   - {column}: Column {columnMapping[column]}");
            }

            return true;
        }

        //private List<ValidationResult> ValidateRecords(List<ProductionRecord> production,
        //    List<CodingMasterRecord> master)
        //{
        //    var results = new List<ValidationResult>();
        //    int exactMatches = 0;
        //    int fallbackMatches = 0;

        //    Console.WriteLine("\n🔍 Matching Logic:");
        //    Console.WriteLine($"  1. Exact match: Panel + Cleaned Carrier");
        //    Console.WriteLine($"  2. Fallback: Panel + Any configured fallback payer pattern");
        //    Console.WriteLine($"     Fallback patterns: {string.Join(", ", _fallbackPayerPatterns)}");

        //    foreach (var prod in production)
        //    {
        //        var result = new ValidationResult(prod);
        //        string payerCommonCode = GetPayerCommonCode(prod.Carrier, _payerMasterList);

        //        // 🔴 THIS IS THE ONLY REQUIRED ADDITION
        //        result.PayerCommonCode = payerCommonCode;


        //        if (!string.IsNullOrWhiteSpace(payerCommonCode))
        //        {
        //            var commonCodeMatch = GetExpectedCPTByCommonCode(
        //                prod,
        //                codingMaster,
        //                payerCommonCode);

        //            if (commonCodeMatch != null && !string.IsNullOrWhiteSpace(commonCodeMatch.Procedure))
        //            {
        //                result.HasMatch = true;
        //                result.MatchType = "PayerMaster → CommonCode Match";
        //                ApplyCptComparison(result, prod, commonCodeMatch.Procedure);
        //            }
        //        }

        //        // Clean the carrier name: remove text after hyphen
        //        string cleanedCarrier = CleanCarrierName(prod.Carrier);

        //        // FIRST ATTEMPT: Find exact match (Panel + Payer)
        //        var exactMatch = master.FirstOrDefault(m =>
        //            string.Equals(m.ProductionPanelName?.Trim(), prod.PanelName?.Trim(), StringComparison.OrdinalIgnoreCase) &&
        //            string.Equals(m.Payer?.Trim(), cleanedCarrier, StringComparison.OrdinalIgnoreCase));

        //        if (exactMatch != null && !string.IsNullOrWhiteSpace(exactMatch.Procedure))
        //        {
        //            result.HasMatch = true;
        //            result.MatchType = "Exact Payer Match";
        //            exactMatches++;

        //            // Sort and store the Expected CPT Codes
        //            string sortedExpected = SortCPTCodes(exactMatch.Procedure);
        //            result.ExpectedCPTCodes = new List<string> { sortedExpected };

        //            // Sort the Actual CPT Codes
        //            string sortedActual = SortCPTCodes(prod.ActualCPTCode);
        //            result.SortedActualCPTCodes = sortedActual;

        //            // Parse CPT codes for comparison
        //            var actualDetails = ParseCPTCodesWithDetails(prod.ActualCPTCode);
        //            var expectedDetails = ParseCPTCodesWithDetails(exactMatch.Procedure);

        //            // Calculate mismatches
        //            CalculateMismatches(actualDetails, expectedDetails, result);
        //            AppendModifierOnlyRemarks(actualDetails, expectedDetails, result);


        //        }
        //        else
        //        {
        //            // SECOND ATTEMPT: Fallback to "All other Insurance" or configured fallback patterns
        //            var fallbackMatch = master.FirstOrDefault(m =>
        //                string.Equals(m.ProductionPanelName?.Trim(), prod.PanelName?.Trim(), StringComparison.OrdinalIgnoreCase) &&
        //                IsFallbackPayer(m.Payer));

        //            if (fallbackMatch != null && !string.IsNullOrWhiteSpace(fallbackMatch.Procedure))
        //            {
        //                result.HasMatch = true;
        //                result.MatchType = $"Fallback: {fallbackMatch.Payer}";
        //                fallbackMatches++;

        //                // Sort and store the Expected CPT Codes
        //                string sortedExpected = SortCPTCodes(fallbackMatch.Procedure);
        //                result.ExpectedCPTCodes = new List<string> { sortedExpected };

        //                // Sort the Actual CPT Codes
        //                string sortedActual = SortCPTCodes(prod.ActualCPTCode);
        //                result.SortedActualCPTCodes = sortedActual;

        //                // Parse CPT codes for comparison
        //                var actualDetails = ParseCPTCodesWithDetails(prod.ActualCPTCode);
        //                var expectedDetails = ParseCPTCodesWithDetails(fallbackMatch.Procedure);

        //                // Calculate mismatches
        //                CalculateMismatches(actualDetails, expectedDetails, result);
        //                AppendModifierOnlyRemarks(actualDetails, expectedDetails, result);

        //            }
        //            else
        //            {
        //                result.HasMatch = false;
        //                result.MatchType = "No Match";
        //                result.SortedActualCPTCodes = SortCPTCodes(prod.ActualCPTCode);
        //            }
        //        }

        //        results.Add(result);
        //    }

        //    Console.WriteLine($"\n📊 MATCHING SUMMARY:");
        //    Console.WriteLine($"   Total Production Records: {production.Count}");
        //    Console.WriteLine($"   Exact Payer Matches: {exactMatches}");
        //    Console.WriteLine($"   Fallback Matches: {fallbackMatches}");
        //    Console.WriteLine($"   Total Matches: {exactMatches + fallbackMatches}");
        //    Console.WriteLine($"   No Match Found: {production.Count - exactMatches - fallbackMatches}");
        //    Console.WriteLine($"   Overall Match Rate: {(production.Count > 0 ? ((double)(exactMatches + fallbackMatches) / production.Count * 100).ToString("F1") : "0")}%");

        //    return results;
        //}

        private void GenerateValidationReport(List<ValidationResult> results, string outputPath)
        {
            var directory = Path.GetDirectoryName(outputPath);
            if (!Directory.Exists(directory))
            {
                Directory.CreateDirectory(directory);
                Console.WriteLine($"📁 Created directory: {directory}");
            }

            using (var writer = new StreamWriter(outputPath))
            {
                // Updated header - using sorted actual CPT codes and sorted expected CPT codes
                writer.WriteLine("VisitNumber,PanelName,Carrier,ActualCPTCodes,ExpectedCPTCodes,MatchType,HasMatch,MissingCPTCodes,AdditionalCPTCodes,Remarks");

                foreach (var result in results)
                {
                    // Format missing codes
                    var missingCodesFormatted = result.MissingCPTCodes
                        .Select(kvp => $"{kvp.Key}*{kvp.Value}")
                        .ToList();
                    string missingCodesString = string.Join(", ", missingCodesFormatted);

                    // Format additional codes
                    var additionalCodesFormatted = result.AdditionalCPTCodes
                        .Select(kvp => $"{kvp.Key}*{kvp.Value}")
                        .ToList();
                    string additionalCodesString = string.Join(", ", additionalCodesFormatted);

                    // Use sorted actual CPT codes or original if not sorted
                    string actualCPTCodes = !string.IsNullOrEmpty(result.SortedActualCPTCodes)
                        ? result.SortedActualCPTCodes
                        : result.ProductionRecord.ActualCPTCode;

                    // Use sorted expected CPT codes (already sorted and stored in ExpectedCPTCodes)
                    string expectedCPTCodes = result.ExpectedCPTCodes.Any()
                        ? result.ExpectedCPTCodes[0]
                        : "";

                    writer.WriteLine(
                        $"\"{EscapeCsvField(result.ProductionRecord.VisitNumber)}\"," +
                        $"\"{EscapeCsvField(result.ProductionRecord.PanelName)}\"," +
                        $"\"{EscapeCsvField(result.ProductionRecord.Carrier)}\"," +
                        $"\"{EscapeCsvField(actualCPTCodes)}\"," +
                        $"\"{EscapeCsvField(expectedCPTCodes)}\"," +
                        $"\"{EscapeCsvField(result.MatchType)}\"," +
                        $"\"{(result.HasMatch ? "YES" : "NO")}\"," +
                        $"\"{EscapeCsvField(missingCodesString)}\"," +
                        $"\"{EscapeCsvField(additionalCodesString)}\"," +
                        $"\"{EscapeCsvField(result.Remarks)}\""
                    );
                }
            }

            Console.WriteLine($"📄 Enhanced validation report saved: {outputPath}");

            // Show statistics
            ShowValidationStatistics(results);
        }
        //    private void AppendModifierOnlyRemarks(
        //List<CPTInfo> actualDetails,
        //List<CPTInfo> expectedDetails,
        //ValidationResult result)
        //    {
        //        var remarks = new List<string>();

        //        // Group expected & actual by BaseCode
        //        var expectedByCode = expectedDetails
        //            .GroupBy(e => e.BaseCode)
        //            .ToDictionary(g => g.Key, g => g.ToList());

        //        var actualByCode = actualDetails
        //            .GroupBy(a => a.BaseCode)
        //            .ToDictionary(g => g.Key, g => g.ToList());

        //        foreach (var exp in expectedByCode)
        //        {
        //            string baseCode = exp.Key;
        //            var expectedModifiers = exp.Value
        //                .Where(x => !string.IsNullOrEmpty(x.Modifier))
        //                .Select(x => x.Modifier)
        //                .Distinct()
        //                .ToList();

        //            actualByCode.TryGetValue(baseCode, out var actualList);

        //            var actualModifiers = actualList?
        //                .Where(x => !string.IsNullOrEmpty(x.Modifier))
        //                .Select(x => x.Modifier)
        //                .Distinct()
        //                .ToList() ?? new List<string>();

        //            // 🔴 Modifier MISSED
        //            foreach (var expMod in expectedModifiers.Except(actualModifiers))
        //            {
        //                remarks.Add($"Modifier {expMod} is missed for the CPTCode {baseCode}");
        //            }

        //            // 🟢 Modifier ADDED
        //            foreach (var actMod in actualModifiers.Except(expectedModifiers))
        //            {
        //                remarks.Add($"Modifier {actMod} is added for the CPTCode {baseCode}");
        //            }
        //        }

        //        // Append only (do not overwrite existing remarks)
        //        if (remarks.Any())
        //        {
        //            if (!string.IsNullOrWhiteSpace(result.Remarks))
        //                result.Remarks += "; ";

        //            result.Remarks += string.Join("; ", remarks);
        //        }
        //    }


        private void AppendModifierOnlyRemarks(
    List<CPTInfo> actualDetails,
    List<CPTInfo> expectedDetails,
    ValidationResult result)
        {
            var remarks = new List<string>();

            // Group expected & actual by BaseCode
            var expectedByCode = expectedDetails
                .GroupBy(e => e.BaseCode)
                .ToDictionary(g => g.Key, g => g.ToList());

            var actualByCode = actualDetails
                .GroupBy(a => a.BaseCode)
                .ToDictionary(g => g.Key, g => g.ToList());

            foreach (var exp in expectedByCode)
            {
                string baseCode = exp.Key;

                // Parse all modifiers from expected codes (including multiple modifiers separated by ;)
                var expectedModifiers = new List<string>();
                foreach (var expItem in exp.Value)
                {
                    if (!string.IsNullOrEmpty(expItem.Modifier))
                    {
                        // Split modifiers by semicolon
                        var modifiers = expItem.Modifier.Split(';', StringSplitOptions.RemoveEmptyEntries)
                            .Select(m => m.Trim())
                            .Where(m => !string.IsNullOrEmpty(m));

                        expectedModifiers.AddRange(modifiers);
                    }
                }
                expectedModifiers = expectedModifiers.Distinct().ToList();

                // Parse all modifiers from actual codes
                var actualModifiers = new List<string>();
                if (actualByCode.TryGetValue(baseCode, out var actualList))
                {
                    foreach (var actItem in actualList)
                    {
                        if (!string.IsNullOrEmpty(actItem.Modifier))
                        {
                            // Split modifiers by semicolon
                            var modifiers = actItem.Modifier.Split(';', StringSplitOptions.RemoveEmptyEntries)
                                .Select(m => m.Trim())
                                .Where(m => !string.IsNullOrEmpty(m));

                            actualModifiers.AddRange(modifiers);
                        }
                    }
                    actualModifiers = actualModifiers.Distinct().ToList();
                }

                // 🔴 Modifier MISSED (in expected but not in actual)
                foreach (var expMod in expectedModifiers.Except(actualModifiers))
                {
                    remarks.Add($"Modifier {expMod} is missed for the CPTCode {baseCode}");
                }

                // 🟢 Modifier ADDED (in actual but not in expected)
                foreach (var actMod in actualModifiers.Except(expectedModifiers))
                {
                    remarks.Add($"Modifier {actMod} is added for the CPTCode {baseCode}");
                }
            }

            // Also check for modifiers in additional CPTs (CPTs that exist in actual but not in expected)
            foreach (var act in actualByCode)
            {
                if (!expectedByCode.ContainsKey(act.Key))
                {
                    // This is an additional CPT (not in expected)
                    var additionalModifiers = new List<string>();
                    foreach (var actItem in act.Value)
                    {
                        if (!string.IsNullOrEmpty(actItem.Modifier))
                        {
                            var modifiers = actItem.Modifier.Split(';', StringSplitOptions.RemoveEmptyEntries)
                                .Select(m => m.Trim())
                                .Where(m => !string.IsNullOrEmpty(m));

                            additionalModifiers.AddRange(modifiers);
                        }
                    }

                    foreach (var modifier in additionalModifiers.Distinct())
                    {
                        remarks.Add($"Additional CPT {act.Key} has modifier '{modifier}'");
                    }
                }
            }

            // Append only (do not overwrite existing remarks)
            if (remarks.Any())
            {
                if (!string.IsNullOrWhiteSpace(result.Remarks))
                    result.Remarks += "; ";

                result.Remarks += string.Join("; ", remarks);
            }
        }

        private void ShowValidationStatistics(List<ValidationResult> results)
        {
            var matchedRecords = results.Count(r => r.HasMatch);
            var unmatchedRecords = results.Count(r => !r.HasMatch);
            var recordsWithMissing = results.Count(r => r.HasMatch && r.MissingCPTCodes.Any());
            var recordsWithAdditional = results.Count(r => r.HasMatch && r.AdditionalCPTCodes.Any());
            var recordsWithModifierIssues = results.Count(r => !string.IsNullOrEmpty(r.Remarks) &&
                                                              r.Remarks.Contains("modifier", StringComparison.OrdinalIgnoreCase));
            var recordsWithUnitIssues = results.Count(r => !string.IsNullOrEmpty(r.Remarks) &&
                                                          (r.Remarks.Contains("units", StringComparison.OrdinalIgnoreCase) ||
                                                           r.Remarks.Contains("units", StringComparison.OrdinalIgnoreCase)));

            Console.WriteLine($"\n📊 VALIDATION STATISTICS:");
            Console.WriteLine($"   Total records: {results.Count}");
            Console.WriteLine($"   Matched records: {matchedRecords}");
            Console.WriteLine($"   Unmatched records: {unmatchedRecords}");
            Console.WriteLine($"   Match rate: {(results.Count > 0 ? ((double)matchedRecords / results.Count * 100).ToString("F1") : "0")}%");
            Console.WriteLine($"\n🔍 MATCH DETAILS:");
            Console.WriteLine($"   Records with missing CPTs: {recordsWithMissing}");
            Console.WriteLine($"   Records with additional CPTs: {recordsWithAdditional}");
            Console.WriteLine($"   Records with modifier issues: {recordsWithModifierIssues}");
            Console.WriteLine($"   Records with unit issues: {recordsWithUnitIssues}");

            // Show top missing CPTs
            var allMissing = results
                .Where(r => r.MissingCPTCodes.Any())
                .SelectMany(r => r.MissingCPTCodes)
                .GroupBy(kvp => kvp.Key)
                .Select(g => new { CPT = g.Key, Count = g.Sum(x => x.Value) })
                .OrderByDescending(x => x.Count)
                .Take(5)
                .ToList();

            if (allMissing.Any())
            {
                Console.WriteLine($"\n📉 TOP MISSING CPTs:");
                foreach (var missing in allMissing)
                {
                    Console.WriteLine($"   {missing.CPT}: {missing.Count} instances");
                }
            }

            // Show top additional CPTs
            var allAdditional = results
                .Where(r => r.AdditionalCPTCodes.Any())
                .SelectMany(r => r.AdditionalCPTCodes)
                .GroupBy(kvp => kvp.Key)
                .Select(g => new { CPT = g.Key, Count = g.Sum(x => x.Value) })
                .OrderByDescending(x => x.Count)
                .Take(5)
                .ToList();

            if (allAdditional.Any())
            {
                Console.WriteLine($"\n📈 TOP ADDITIONAL CPTs:");
                foreach (var additional in allAdditional)
                {
                    Console.WriteLine($"   {additional.CPT}: {additional.Count} instances");
                }
            }
        }

        private string EscapeCsvField(string field)
        {
            if (string.IsNullOrEmpty(field))
                return "";

            if (field.Contains("\"") || field.Contains(",") || field.Contains("\n") || field.Contains("\r"))
            {
                return field.Replace("\"", "\"\"");
            }

            return field;
        }

        private string[] ParseCsvLine(string line)
        {
            var result = new List<string>();
            bool inQuotes = false;
            string current = "";

            foreach (char c in line)
            {
                if (c == '"')
                {
                    inQuotes = !inQuotes;
                }
                else if (c == ',' && !inQuotes)
                {
                    result.Add(current);
                    current = "";
                }
                else
                {
                    current += c;
                }
            }

            result.Add(current);
            return result.ToArray();
        }

        private CodingMasterRecord GetExpectedCPTByCommonCode(ProductionRecord prod,List<CodingMasterRecord> codingMaster,string payerCommonCode)
        {
            if (string.IsNullOrWhiteSpace(payerCommonCode))
                return null;

            return codingMaster.FirstOrDefault(cm =>
                string.Equals(cm.ProductionPanelName?.Trim(), prod.PanelName?.Trim(), StringComparison.OrdinalIgnoreCase) &&
                string.Equals(cm.Payer?.Trim(), payerCommonCode.Trim(), StringComparison.OrdinalIgnoreCase));
        }


        private string GetPayerCommonCode(string carrier,List<PayerMasterRecord> payerMasterList)
        {
            if (string.IsNullOrWhiteSpace(carrier))
                return null;

            if (payerMasterList == null || payerMasterList.Count == 0)
                return null;   // fallback will handle this

            var match = payerMasterList.FirstOrDefault(p =>
                string.Equals(
                    p.Payer_Name_Raw?.Trim(),
                    carrier.Trim(),
                    StringComparison.OrdinalIgnoreCase));

            return match?.Payer_Common_Code;
        }


    }


    public partial class Validator
    {
        /// <summary>
        /// High-performance validator using dictionary lookups.
        /// Nested to reuse existing private logic safely.
        /// </summary>
        private sealed class PayerMasterOptimizedValidator
        {
            private readonly Validator _parent;

            private readonly Dictionary<string, string> _carrierToCommonCode;
            private readonly Dictionary<string, CodingMasterRecord> _panelPayerToCoding;
            private readonly Dictionary<string, CodingMasterRecord> _fallbackByPanel;

            public PayerMasterOptimizedValidator(
                Validator parent,
                List<PayerMasterRecord> payerMaster,
                List<CodingMasterRecord> codingMaster)
            {
                _parent = parent;

                _carrierToCommonCode = payerMaster
                    .Where(p =>
                        !string.IsNullOrWhiteSpace(p.Payer_Name_Raw) &&
                        !string.IsNullOrWhiteSpace(p.Payer_Common_Code))
                    .GroupBy(p => p.Payer_Name_Raw.Trim(), StringComparer.OrdinalIgnoreCase)
                    .ToDictionary(
                        g => g.Key,
                        g => g.First().Payer_Common_Code.Trim(),
                        StringComparer.OrdinalIgnoreCase);

                _panelPayerToCoding = codingMaster
                    .Where(cm =>
                        !string.IsNullOrWhiteSpace(cm.ProductionPanelName) &&
                        !string.IsNullOrWhiteSpace(cm.Payer))
                    .GroupBy(cm => BuildKey(cm.ProductionPanelName, cm.Payer))
                    .ToDictionary(g => g.Key, g => g.First());

                _fallbackByPanel = codingMaster
                    .Where(cm => cm.IsFallbackPayer &&
                                 !string.IsNullOrWhiteSpace(cm.ProductionPanelName))
                    .GroupBy(cm => cm.ProductionPanelName.Trim(),
                             StringComparer.OrdinalIgnoreCase)
                    .ToDictionary(
                        g => g.Key,
                        g => g.First(),
                        StringComparer.OrdinalIgnoreCase);

                Console.WriteLine("⚡ Optimized validator initialized");
            }

         



            public List<ValidationResult> Validate(List<ProductionRecord> production)
            {
                var results = new List<ValidationResult>();

                foreach (var prod in production)
                {
                    var result = new ValidationResult(prod);
                    string payerCommonCode = null;
                    bool matched = false;
                    string effectivePanel = _parent.GetEffectivePanelName(prod);

                   
                    // ===== PRIMARY: Common Code =====
                    if (!string.IsNullOrWhiteSpace(prod.Carrier) &&
                        _carrierToCommonCode.TryGetValue(prod.Carrier.Trim(), out var commonCode))
                    {
                        // string key = BuildKey(prod.PanelName, commonCode);

                      
                        string key = BuildKey(effectivePanel, commonCode);
                        payerCommonCode = commonCode;
                        

                        if (_panelPayerToCoding.TryGetValue(key, out var cm))
                        {
                            matched = true;
                            result.HasMatch = true;
                            result.MatchType = "PayerMaster → CommonCode Match";

                            ApplyComparison(result, prod, cm.Procedure);
                        }
                    }
                    result.PayerCommonCode = payerCommonCode;

                    // IMPORTANT: this must match PayerCPTAverageGenerator
                    result.PayerName = prod.Carrier?.Trim();


                    // string panelToUse = _parent.GetEffectivePanelName(prod);

                    // ===== FALLBACK =====
                    if (!matched &&
                       //_fallbackByPanel.TryGetValue(prod.PanelName.Trim(), out var fallback))
                       // _fallbackByPanel.TryGetValue(prod.PanelName?.Trim() ?? "", out var fallback))
                       _fallbackByPanel.TryGetValue(effectivePanel ?? "", out var fallback))
                    {
                        matched = true;
                        result.HasMatch = true;
                        result.MatchType = $"Fallback: {fallback.Payer}";

                        ApplyComparison(result, prod, fallback.Procedure);
                    }

                    // ===== NO MATCH =====
                    if (!matched)
                    {
                        result.HasMatch = false;
                        result.MatchType = "No Match";
                        result.SortedActualCPTCodes =
                            _parent.SortCPTCodes(prod.ActualCPTCode);
                    }

                    results.Add(result);
                }

                return results;
            }

            private void ApplyComparison(
                ValidationResult result,
                ProductionRecord prod,
                string expectedProcedure)
            {
                result.ExpectedCPTCodes =
                    new List<string> { _parent.SortCPTCodes(expectedProcedure) };

                result.SortedActualCPTCodes =
                    _parent.SortCPTCodes(prod.ActualCPTCode);

                var actual =
                    _parent.ParseCPTCodesWithDetails(prod.ActualCPTCode);

                var expected =
                    _parent.ParseCPTCodesWithDetails(expectedProcedure);

                _parent.CalculateMismatches(actual, expected, result);
                _parent.AppendModifierOnlyRemarks(actual, expected, result);
            }

            private static string BuildKey(string panel, string payer)
                => $"{panel?.Trim().ToUpperInvariant()}||{payer?.Trim().ToUpperInvariant()}";
        }
    }

    // Supporting classes
    //public class ValidationResult
    //{
    //    public ProductionRecord ProductionRecord { get; }
    //    public List<string> ExpectedCPTCodes { get; set; } = new List<string>();
    //    public Dictionary<string, int> MissingCPTCodes { get; set; } = new Dictionary<string, int>();
    //    public Dictionary<string, int> AdditionalCPTCodes { get; set; } = new Dictionary<string, int>();
    //    public bool HasMatch { get; set; }
    //    public string MatchType { get; set; } = "";

    //    // New property for sorted actual CPT codes
    //    public string SortedActualCPTCodes { get; set; } = "";
    //    public string Remarks { get; set; } = "";

    //    public ValidationResult(ProductionRecord record)
    //    {
    //        ProductionRecord = record;
    //    }
    //}

    //public class ValidationSettings
    //{
    //    public List<string> FallbackPayerPatterns { get; set; } = new List<string>
    //    {
    //        "All other Insurance",
    //        "Missing Payer Info",
    //        "DEFAULT"
    //    };

    //    public CodingMasterSettings CodingMaster { get; set; } = new CodingMasterSettings();
    //    public OutputSettings Output { get; set; } = new OutputSettings();
    //}

    //public class CodingMasterSettings
    //{
    //    public string FilePath { get; set; } = @"E:\LRN-Data\CodingMaster\Inputs\CodingMaster.xlsx";
    //    public ColumnMappings ColumnMappings { get; set; } = new ColumnMappings();
    //}

    //public class ColumnMappings
    //{
    //    public string ProductionPanelName { get; set; } = "Production Panel Name";
    //    public string Payer { get; set; } = "Payer";
    //    public string Procedure { get; set; } = "Procedure";
    //}

    //public class OutputSettings
    //{
    //    public string OutputDirectory { get; set; } = @"E:\LRN-Data\CodingMaster\Outputs";
    //    public string ValidationReportSuffix { get; set; } = "_Validated";
    //}

    //public class ProductionRecord
    //{
    //    public string VisitNumber { get; set; } = "";
    //    public string AccessionNo { get; set; } = "";
    //    public string PanelName { get; set; } = "";
    //    public string Carrier { get; set; } = "";
    //    public string ActualCPTCode { get; set; } = "";
    //    public decimal TotalCharge { get; set; }
    //}

    //public class CodingMasterRecord
    //{
    //    public string ProductionPanelName { get; set; } = "";
    //    public string Payer { get; set; } = "";
    //    public string Procedure { get; set; } = "";
    //    public bool IsFallbackPayer { get; set; } = false;
    //}
}