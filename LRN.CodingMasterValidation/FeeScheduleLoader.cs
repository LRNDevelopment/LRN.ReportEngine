using ClosedXML.Excel;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;

namespace LRN.CodingMasterValidation
{
    public class FeeScheduleLoader
    {
        private DataTable feeSchedule;
        private string feeSchedulePath;
        //private readonly string _feeSchedulePath;
        //private readonly IConfiguration _configuration;

        // Remove readonly from fields that need to be reassigned
     
       
        private IConfiguration configuration;

        public FeeScheduleLoader(string feeSchedulePath)
        {
            this.feeSchedulePath = feeSchedulePath
                ?? throw new ArgumentNullException(nameof(feeSchedulePath));

            LoadFeeSchedule();
        }


        //private string GetFeeSchedulePathFromConfig()
        //{
        //    try
        //    {
        //        if (this.configuration != null)
        //        {
        //            // Try to get from configuration
        //            return this.configuration["CodingMaster:FeeSchedulePath"];
        //        }

        //        // Load configuration from appsettings.json
        //        var configBuilder = new ConfigurationBuilder()
        //            .SetBasePath(Directory.GetCurrentDirectory())
        //            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
        //            .Build();

        //        return configBuilder["CodingMaster:FeeSchedulePath"];
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"⚠️ Error reading fee schedule path from config: {ex.Message}");
        //        return null;
        //    }
        //}

        private void LoadFeeSchedule()
        {
            try
            {
                Console.WriteLine($"📖 Loading Fee Schedule from: {Path.GetFileName(this.feeSchedulePath)}");

                if (!File.Exists(this.feeSchedulePath))
                {
                    Console.WriteLine($"❌ Fee Schedule file not found: {this.feeSchedulePath}");
                    Console.WriteLine("🔍 Searching for fee schedule files in input folder...");

                    // Try to find the file
                    string inputFolder = Path.GetDirectoryName(this.feeSchedulePath) ?? @"E:\LRN-Data\CodingMaster\Inputs";
                    var feeScheduleFiles = Directory.GetFiles(inputFolder, "*Fee Schedule*.xlsx");

                    if (feeScheduleFiles.Length > 0)
                    {
                        this.feeSchedulePath = feeScheduleFiles[0]; // This is where the error was - can't assign to readonly field
                        Console.WriteLine($"✅ Found fee schedule: {Path.GetFileName(this.feeSchedulePath)}");
                    }
                    else
                    {
                        throw new FileNotFoundException($"Fee Schedule file not found: {this.feeSchedulePath}");
                    }
                }

                using (var workbook = new XLWorkbook(this.feeSchedulePath))
                {
                    var worksheet = workbook.Worksheet(1);
                    if (worksheet == null)
                        throw new Exception("No worksheets found in Fee Schedule file");

                    var dataRange = worksheet.RangeUsed();
                    if (dataRange == null)
                        throw new Exception("No data found in Fee Schedule worksheet");

                    this.feeSchedule = new DataTable("FeeSchedule");

                    // Get headers
                    var headerRow = worksheet.Row(1);
                    foreach (var cell in headerRow.Cells())
                    {
                        string header = cell.Value.ToString().Trim();
                        if (!string.IsNullOrEmpty(header))
                        {
                            this.feeSchedule.Columns.Add(header);
                        }
                    }

                    // Log column names for debugging
                    Console.WriteLine($"📊 Fee Schedule columns found: {this.feeSchedule.Columns.Count}");
                    Console.Write("   Columns: ");
                    foreach (DataColumn col in this.feeSchedule.Columns)
                    {
                        Console.Write($"{col.ColumnName}, ");
                    }
                    Console.WriteLine();

                    // Load data
                    int rowCount = dataRange.RowCount();
                    int loadedRows = 0;

                    for (int rowNum = 2; rowNum <= rowCount; rowNum++)
                    {
                        var row = worksheet.Row(rowNum);
                        DataRow dataRow = this.feeSchedule.NewRow();

                        for (int col = 0; col < this.feeSchedule.Columns.Count; col++)
                        {
                            var cell = row.Cell(col + 1);
                            dataRow[col] = GetCellStringValue(cell);
                        }

                        // Only add if CPT Code is not empty
                        if (!string.IsNullOrEmpty(dataRow[FindCPTColumnIndex()]?.ToString()))
                        {
                            this.feeSchedule.Rows.Add(dataRow);
                            loadedRows++;
                        }

                        // Show progress
                        if (rowNum % 1000 == 0)
                        {
                            Console.Write(".");
                        }
                    }

                    Console.WriteLine(); // New line after progress dots
                    Console.WriteLine($"✅ Loaded {loadedRows} fee schedule records");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error loading Fee Schedule: {ex.Message}");
                Console.WriteLine($"Stack Trace: {ex.StackTrace}");
                this.feeSchedule = new DataTable(); // Empty table as fallback
            }
        }

        private int FindCPTColumnIndex()
        {
            if (this.feeSchedule == null || this.feeSchedule.Columns.Count == 0)
                return 0;

            // Look for common column names for CPT codes
            var possibleNames = new[] { "CPT Code", "CPTCode", "CPT", "Procedure Code", "Code", "CPT CODE" };

            for (int i = 0; i < this.feeSchedule.Columns.Count; i++)
            {
                string columnName = this.feeSchedule.Columns[i].ColumnName;
                foreach (var possibleName in possibleNames)
                {
                    if (columnName.Equals(possibleName, StringComparison.OrdinalIgnoreCase))
                        return i;
                }
            }

            return 0; // Fallback to first column
        }

        private string GetCellStringValue(IXLCell cell)
        {
            if (cell == null || cell.IsEmpty())
                return "";

            return cell.Value.ToString().Trim();
        }

        public decimal GetMedicareAllowable(string cptCode)
        {
            if (this.feeSchedule == null || this.feeSchedule.Rows.Count == 0)
            {
                Console.WriteLine($"⚠️ Fee Schedule not loaded. Using default value for CPT {cptCode}");
                return 0;
            }

            try
            {
                // Clean CPT code (remove modifier if present)
                string cleanCptCode = cptCode.Split('-')[0];

                // Find CPT column index
                int cptColumnIndex = FindCPTColumnIndex();

                // Find Medicare column index
                int medicareColumnIndex = FindMedicareColumnIndex();

                if (medicareColumnIndex == -1)
                {
                    Console.WriteLine($"⚠️ Medicare Allowable column not found in fee schedule");
                    return 0;
                }

                // Search for the CPT code
                foreach (DataRow row in this.feeSchedule.Rows)
                {
                    string rowCptCode = row[cptColumnIndex]?.ToString();
                    if (!string.IsNullOrEmpty(rowCptCode) &&
                        rowCptCode.Equals(cleanCptCode, StringComparison.OrdinalIgnoreCase))
                    {
                        string medicareValue = row[medicareColumnIndex]?.ToString();

                        if (!string.IsNullOrEmpty(medicareValue))
                        {
                            // Try to parse as decimal
                            if (decimal.TryParse(medicareValue, out decimal medicareAllowable))
                            {
                                return medicareAllowable;
                            }

                            // Try removing currency symbols
                            medicareValue = medicareValue.Replace("$", "").Replace(",", "").Trim();
                            if (decimal.TryParse(medicareValue, out medicareAllowable))
                            {
                                return medicareAllowable;
                            }
                        }

                        Console.WriteLine($"⚠️ Could not parse Medicare value for CPT {cleanCptCode}: '{medicareValue}'");
                        return 0;
                    }
                }

                //Console.WriteLine($"⚠️ CPT Code {cleanCptCode} not found in fee schedule");
                return 0;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error getting Medicare Allowable for CPT {cptCode}: {ex.Message}");
                return 0;
            }
        }

        private int FindMedicareColumnIndex()
        {
            if (this.feeSchedule == null || this.feeSchedule.Columns.Count == 0)
                return -1;

            // Look for common column names for Medicare allowable
            var possibleNames = new[] {
                "Medicare Allowable",
                "MedicareAllowable",
                "Medicare",
                "Allowable",
                "Rate",
                "Fee",
                "Medicare Fee",
                "Medicare Rate",
                "Medicare Payment"
            };

            for (int i = 0; i < this.feeSchedule.Columns.Count; i++)
            {
                string columnName = this.feeSchedule.Columns[i].ColumnName;
                foreach (var possibleName in possibleNames)
                {
                    if (columnName.Equals(possibleName, StringComparison.OrdinalIgnoreCase))
                        return i;
                }
            }

            return -1; // Not found
        }

        //public void DisplayFeeScheduleInfo()
        //{
        //    if (this.feeSchedule == null)
        //    {
        //        Console.WriteLine("❌ Fee Schedule is not loaded");
        //        return;
        //    }

        //    Console.WriteLine($"📊 Fee Schedule Information:");
        //    Console.WriteLine($"   Total rows: {this.feeSchedule.Rows.Count}");
        //    Console.WriteLine($"   Columns: {this.feeSchedule.Columns.Count}");

        //    Console.WriteLine("   Column Names:");
        //    foreach (DataColumn col in this.feeSchedule.Columns)
        //    {
        //        Console.WriteLine($"     - {col.ColumnName}");
        //    }

        //    // Show sample of CPT codes
        //    Console.WriteLine($"   Sample CPT Codes (first 10):");
        //    int cptColumnIndex = FindCPTColumnIndex();
        //    int count = 0;
        //    foreach (DataRow row in this.feeSchedule.Rows)
        //    {
        //        if (count >= 10) break;
        //        string cptCode = row[cptColumnIndex]?.ToString();
        //        if (!string.IsNullOrEmpty(cptCode))
        //        {
        //            Console.WriteLine($"     - {cptCode}");
        //            count++;
        //        }
        //    }
        //}


        // Add this method to your FeeScheduleLoader class
        public decimal GetBilledCharge(string cptCode)
        {
            if (this.feeSchedule == null || this.feeSchedule.Rows.Count == 0)
            {
                Console.WriteLine($"⚠️ Fee Schedule not loaded. Using default value for CPT {cptCode}");
                return 0;
            }

            try
            {
                // Clean CPT code (remove modifier if present)
                string cleanCptCode = cptCode.Split('-')[0];

                // Find CPT column index
                int cptColumnIndex = FindCPTColumnIndex();

                // Find Billed Charge column index
                int billedChargeColumnIndex = FindBilledChargeColumnIndex();

                if (billedChargeColumnIndex == -1)
                {
                    Console.WriteLine($"⚠️ Billed Charge column not found in fee schedule. Falling back to Medicare.");
                    return GetMedicareAllowable(cptCode); // Fallback
                }

                // Search for the CPT code
                foreach (DataRow row in this.feeSchedule.Rows)
                {
                    string rowCptCode = row[cptColumnIndex]?.ToString();
                    if (!string.IsNullOrEmpty(rowCptCode) &&
                        rowCptCode.Equals(cleanCptCode, StringComparison.OrdinalIgnoreCase))
                    {
                        string billedChargeValue = row[billedChargeColumnIndex]?.ToString();

                        if (!string.IsNullOrEmpty(billedChargeValue))
                        {
                            // Try to parse as decimal
                            if (decimal.TryParse(billedChargeValue, out decimal billedCharge))
                            {
                                return billedCharge;
                            }

                            // Try removing currency symbols
                            billedChargeValue = billedChargeValue.Replace("$", "").Replace(",", "").Trim();
                            if (decimal.TryParse(billedChargeValue, out billedCharge))
                            {
                                return billedCharge;
                            }
                        }

                        Console.WriteLine($"⚠️ Could not parse Billed Charge value for CPT {cleanCptCode}: '{billedChargeValue}'");
                        return 0;
                    }
                }

               // Console.WriteLine($"⚠️ CPT Code {cleanCptCode} not found in fee schedule");
                return 0;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error getting Billed Charge for CPT {cptCode}: {ex.Message}");
                return 0;
            }
        }

        // Add this method to find Billed Charge column
        private int FindBilledChargeColumnIndex()
        {
            if (this.feeSchedule == null || this.feeSchedule.Columns.Count == 0)
                return -1;

            // Look for common column names for Billed Charge
            var possibleNames = new[] {
        "Billed Charge",
        "BilledCharge",
        "Charge",
        "Billed Amount",
        "BilledAmount",
        "Billed Price",
        "BilledPrice",
        "Fee",
        "Amount",
        "Billed Fee",
        "Billed Fee Schedule"
    };

            for (int i = 0; i < this.feeSchedule.Columns.Count; i++)
            {
                string columnName = this.feeSchedule.Columns[i].ColumnName;
                foreach (var possibleName in possibleNames)
                {
                    if (columnName.Equals(possibleName, StringComparison.OrdinalIgnoreCase))
                        return i;
                }
            }

            return -1; // Not found
        }

        // Also update DisplayFeeScheduleInfo to show Billed Charge column
        public void DisplayFeeScheduleInfo()
        {
            if (this.feeSchedule == null)
            {
                Console.WriteLine("❌ Fee Schedule is not loaded");
                return;
            }

            Console.WriteLine($"📊 Fee Schedule Information:");
            Console.WriteLine($"   Total rows: {this.feeSchedule.Rows.Count}");
            Console.WriteLine($"   Columns: {this.feeSchedule.Columns.Count}");

            // Check for Billed Charge column
            int billedChargeIndex = FindBilledChargeColumnIndex();
            if (billedChargeIndex != -1)
            {
                Console.WriteLine($"✅ Billed Charge column found: '{this.feeSchedule.Columns[billedChargeIndex].ColumnName}'");
            }
            else
            {
                Console.WriteLine("⚠️  Billed Charge column NOT found in fee schedule");
            }

            Console.WriteLine("   Column Names:");
            foreach (DataColumn col in this.feeSchedule.Columns)
            {
                Console.WriteLine($"     - {col.ColumnName}");
            }

            // Show sample of CPT codes with charges
            Console.WriteLine($"   Sample CPT Codes with Billed Charges (first 10):");
            int cptColumnIndex = FindCPTColumnIndex();
            int count = 0;
            foreach (DataRow row in this.feeSchedule.Rows)
            {
                if (count >= 10) break;
                string cptCode = row[cptColumnIndex]?.ToString();
                if (!string.IsNullOrEmpty(cptCode))
                {
                    decimal billedCharge = GetBilledCharge(cptCode);
                    Console.WriteLine($"     - {cptCode}: ${billedCharge:F2}");
                    count++;
                }
            }
        }
    }
}