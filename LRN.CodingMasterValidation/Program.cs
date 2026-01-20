using LRN.CodingMasterValidation;
using Microsoft.Extensions.Configuration;
using System;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Text.Json;

class Program
{
    static void Main(string[] args)
    {

        FileLogger.Info("Application started");
        Console.Title = "Coding Master Validation Tool";
        Console.ForegroundColor = ConsoleColor.Cyan;
        Console.WriteLine("╔══════════════════════════════════════════════════════════╗");
        Console.WriteLine("║         CODING MASTER VALIDATION TOOL                    ║");
        Console.WriteLine("║         CPT Code Validation System                       ║");
        Console.WriteLine("╚══════════════════════════════════════════════════════════╝");
        Console.ResetColor();
        Console.WriteLine();
        try
        {
            // Load configuration
            //var configuration = new ConfigurationBuilder()
            //    .SetBasePath(Directory.GetCurrentDirectory())
            //    .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            //    .Build();
            var exePath = AppContext.BaseDirectory;
            var configuration = new ConfigurationBuilder()
              .SetBasePath(exePath)
              .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
              .Build();


            if (!File.Exists("appsettings.json"))
            {
                FileLogger.Warn("appsettings.json NOT FOUND");
            }
            else
            {
                FileLogger.Info("appsettings.json loaded successfully");
            }



            var labs = configuration
             .GetSection("LabSettings:Labs")
             .Get<string[]>();
            if (labs == null || labs.Length == 0)
            {
                FileLogger.Error("LabSettings:Labs is missing or empty in appsettings.json");
                Console.WriteLine("❌ No labs configured. Exiting.");
                return;
            }

            FileLogger.Info($"Labs loaded: {string.Join(", ", labs)}");

            foreach (var lab in labs)
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine($"\n🚀 STARTING LAB: {lab}");
                Console.ResetColor();

                var labContext = new LabContext(configuration, lab);
                try
                {
                    FileLogger.Info($"-----------START LAB: {lab}---------");
                    RunPipeline(configuration, labContext);
                    FileLogger.Info($"***********END LAB SUCCESS: {lab}******");
                }
                catch (Exception ex)
                {
                    FileLogger.Error($"LAB FAILED: {lab}", ex);
                }

            }


            //string generatedCsvPath = null;
            //string enhancedReportPath = null;
            //string panelSummaryPath = null; // Store panel summary path

            //try
            //{
            //    // Step 1: Generate CSV from Production Master
            //    Console.WriteLine("=".PadRight(60, '='));
            //    Console.WriteLine("STEP 1: GENERATE CSV FROM PRODUCTION MASTER");
            //    Console.WriteLine("=".PadRight(60, '='));

            //    //var newGenerator = new CodingMasterCSVGenerator();
            //    //generatedCsvPath = GenerateAndGetCSVPath(newGenerator);


            //    // ============ PASS CONFIGURATION TO CONSTRUCTOR ============
            //    var newGenerator = new CodingMasterCSVGenerator(configuration);
            //    generatedCsvPath = GenerateAndGetCSVPath(newGenerator);

            //    Console.WriteLine($"\n✅ CSV Generated: {Path.GetFileName(generatedCsvPath)}");
            //    Console.WriteLine($"📍 Location: {generatedCsvPath}");

            //    Console.WriteLine("\nPress any key to continue to Step 2...");
            //    Console.ReadKey();

            //    // Step 2: Validate with Coding Master
            //    Console.WriteLine("\n" + "=".PadRight(60, '='));
            //    Console.WriteLine("STEP 2: VALIDATE WITH CODING MASTER");
            //    Console.WriteLine("=".PadRight(60, '='));

            //    var step2 = new Validator(generatedCsvPath);
            //    var validationResults = step2.Execute();

            //    if (validationResults.Any())
            //    {
            //        Console.WriteLine("\nPress any key to continue to Step 3...");
            //        Console.ReadKey();

            //        // Step 3: Generate Enhanced Report with Charges
            //        Console.WriteLine("\n" + "=".PadRight(60, '='));
            //        Console.WriteLine("STEP 3: GENERATE ENHANCED REPORT WITH CHARGES");
            //        Console.WriteLine("=".PadRight(60, '='));

            //        var step3 = new EnhancedValidationReporter(configuration);
            //        step3.Execute(validationResults);

            //        // Store the path of the latest enhanced report
            //        enhancedReportPath = GetLatestFileByPattern(@"E:\LRN-Data\CodingMaster\Outputs",
            //            "Enhanced_Validation_Report_*.csv");

            //        // Display fee schedule info
            //        var feeScheduleLoader = new FeeScheduleLoader(configuration);
            //        feeScheduleLoader.DisplayFeeScheduleInfo();

            //        Console.WriteLine("\nPress any key to continue to Step 4...");
            //        Console.ReadKey();

            //        // Step 4: Generate Missing CPT Report
            //        Console.WriteLine("\n" + "=".PadRight(60, '='));
            //        Console.WriteLine("STEP 4: GENERATE MISSING CPT REPORT");
            //        Console.WriteLine("=".PadRight(60, '='));

            //        var step4 = new MissingCPTReporter();
            //        step4.Execute(validationResults);

            //        Console.WriteLine("\nPress any key to continue to Step 5...");
            //        Console.ReadKey();

            //        // Step 5: Generate Additional CPT Report
            //        Console.WriteLine("\n" + "=".PadRight(60, '='));
            //        Console.WriteLine("STEP 5: GENERATE ADDITIONAL CPT REPORT");
            //        Console.WriteLine("=".PadRight(60, '='));

            //        var step5 = new AdditionalCPTReporter();
            //        step5.Execute(validationResults);

            //        Console.WriteLine("\nPress any key to continue to Step 6...");
            //        Console.ReadKey();

            //        // Step 6: Generate Panel Summary Report
            //        Console.WriteLine("\n" + "=".PadRight(60, '='));
            //        Console.WriteLine("STEP 6: GENERATE PANEL SUMMARY REPORT");
            //        Console.WriteLine("=".PadRight(60, '='));

            //        if (!string.IsNullOrEmpty(enhancedReportPath) && File.Exists(enhancedReportPath))
            //        {
            //            var step6 = new PanelSummaryGenerator();
            //            step6.GeneratePanelSummaryFromCsv(enhancedReportPath);

            //            // Get the generated panel summary path
            //            panelSummaryPath = GetLatestFileByPattern(@"E:\LRN-Data\CodingMaster\Outputs",
            //                "Panel_Summary_Report_*.csv");
            //        }
            //        else
            //        {
            //            Console.WriteLine("⚠️  Enhanced report not found. Cannot generate panel summary.");
            //            Console.WriteLine("Please ensure Step 3 completed successfully.");
            //        }

            //        Console.WriteLine("\nPress any key to continue to Step 7...");
            //        Console.ReadKey();

            //        // Step 7: Generate Formatted Excel Report
            //        Console.WriteLine("\n" + "=".PadRight(60, '='));
            //        Console.WriteLine("STEP 7: GENERATE FORMATTED EXCEL REPORT");
            //        Console.WriteLine("=".PadRight(60, '='));

            //        if (!string.IsNullOrEmpty(enhancedReportPath) && File.Exists(enhancedReportPath) &&
            //            !string.IsNullOrEmpty(panelSummaryPath) && File.Exists(panelSummaryPath))
            //        {
            //            var excelGenerator = new ExcelReportGenerator();
            //            excelGenerator.GenerateFormattedExcelReport(enhancedReportPath, panelSummaryPath);
            //        }
            //        else
            //        {
            //            Console.WriteLine("⚠️  Could not find both CSV files for Excel generation.");
            //            Console.WriteLine($"Enhanced Report: {(string.IsNullOrEmpty(enhancedReportPath) ? "Not found" : "Found")}");
            //            Console.WriteLine($"Panel Summary: {(string.IsNullOrEmpty(panelSummaryPath) ? "Not found" : "Found")}");
            //        }
            //    }

            //    DisplayFinalSummary(generatedCsvPath, enhancedReportPath, panelSummaryPath);
            //}
            //catch (Exception ex)
            //{
            //    Console.ForegroundColor = ConsoleColor.Red;
            //    Console.WriteLine($"\n❌ FATAL ERROR: {ex.Message}");
            //    Console.ResetColor();
            //    Console.WriteLine($"Stack Trace: {ex.StackTrace}");
            //}

            //Console.WriteLine("\nPress any key to exit...");
            //Console.ReadKey();
        }
        catch (Exception ex)
        {
            FileLogger.Error("Application error :", ex);
        }
    
    }


    //end here

    //static void RunPipeline(IConfiguration config, LabContext lab)
    //{
    //    Console.WriteLine("=".PadRight(60, '='));
    //    Console.WriteLine($"PROCESSING LAB : {lab.Lab}");
    //    Console.WriteLine("=".PadRight(60, '='));
    //    // Check for pending validation job
    //    Console.WriteLine("\n🔍 Checking for pending validation jobs...");




        //    if (lab.TryGetPendingValidationJob(out int reportId, out string reportPath))
        //    {
        //        lab.SetValidationReportId(reportId);
        //        Console.WriteLine($"✅ Found pending job: ReportID={reportId}");

        //        // For labs using DB production source, fetch latest production report
        //        if (lab.UseDbProductionSource && lab.TryGetLatestProductionReport(out int prodReportId, out string prodReportPath))
        //        {
        //            Console.WriteLine($"📥 Production report from DB: {Path.GetFileName(prodReportPath)}");
        //            // TODO: Copy prodReportPath to lab.SourceFile location
        //        }
        //    }
        //    else
        //    {
        //        Console.WriteLine($"⚠️ No pending validation jobs found for {lab.Lab}");
        //        Console.WriteLine($"📂 Using local source file: {lab.SourceFileName}");
        //    }

        //    // Test database connection
        //    if (lab.TestDatabaseConnection())
        //    {
        //        Console.WriteLine("✅ Database connection successful");
        //    }
        //    else
        //    {
        //        Console.WriteLine("⚠️ Database connection failed - will continue with file system only");
        //    }



        //    string sourceFilePath = lab.SourceFile; // This will be updated if we copy from DB
        //    bool sourceFileMoved = false;
        //    var generatedCsvFiles = new List<string>();
        //    bool excelGenerated = false;
        //    string excelPath = null;

        //    try
        //    {

        //        // STEP 0: Check and copy source file from database if needed
        //        Console.WriteLine("\n🔍 CHECKING FOR PENDING VALIDATION JOBS");

        //        if (lab.TryGetPendingValidationJob(out int reportId, out string reportPath))
        //        {
        //            lab.SetValidationReportId(reportId);
        //            Console.WriteLine($"✅ Found pending job: ReportID={reportId}");

        //            // For labs using DB production source, fetch and copy production report
        //            if (lab.UseDbProductionSource)
        //            {
        //                Console.WriteLine("\n📥 FETCHING PRODUCTION REPORT FROM DATABASE");

        //                if (lab.TryGetLatestProductionReport(out int prodReportId, out string prodReportPath))
        //                {
        //                    Console.WriteLine($"   Found production report: {Path.GetFileName(prodReportPath)}");

        //                    if (File.Exists(prodReportPath))
        //                    {
        //                        // Copy the file to the lab's source folder
        //                        try
        //                        {
        //                            var sourceDir = Path.GetDirectoryName(lab.SourceFile);
        //                            if (!Directory.Exists(sourceDir))
        //                                Directory.CreateDirectory(sourceDir);

        //                            // Generate unique filename with timestamp
        //                            var timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
        //                            var newFileName = $"ProductionMaster_{timestamp}.xlsx";
        //                            var destinationPath = Path.Combine(sourceDir, newFileName);

        //                            // Copy the file
        //                            File.Copy(prodReportPath, destinationPath, true);
        //                            sourceFilePath = destinationPath;

        //                            Console.WriteLine($"✅ Copied production report to: {Path.GetFileName(destinationPath)}");
        //                        }
        //                        catch (Exception ex)
        //                        {
        //                            Console.WriteLine($"❌ Failed to copy production report: {ex.Message}");
        //                            Console.WriteLine($"⚠️ Will use existing source file instead");
        //                            sourceFilePath = lab.SourceFile;
        //                        }
        //                    }
        //                    else
        //                    {
        //                        Console.WriteLine($"❌ Production report file not found: {prodReportPath}");
        //                        Console.WriteLine($"⚠️ Will use existing source file instead");
        //                        sourceFilePath = lab.SourceFile;
        //                    }
        //                }
        //                else
        //                {
        //                    Console.WriteLine($"⚠️ No production report found in database");
        //                    Console.WriteLine($"   Will use existing source file instead");
        //                    sourceFilePath = lab.SourceFile;
        //                }
        //            }
        //            else
        //            {
        //                Console.WriteLine($"📂 Lab uses file system source");
        //                Console.WriteLine($"   Using local source file: {lab.SourceFileName}");
        //                sourceFilePath = lab.SourceFile;
        //            }
        //        }
        //        else
        //        {
        //            Console.WriteLine($"⚠️ No pending validation jobs found for {lab.Lab}");
        //            Console.WriteLine($"📂 Using local source file: {lab.SourceFileName}");
        //            sourceFilePath = lab.SourceFile;
        //        }

        //        // Test database connection
        //        Console.WriteLine("\n🔗 TESTING DATABASE CONNECTION");
        //        if (lab.TestDatabaseConnection())
        //        {
        //            Console.WriteLine("✅ Database connection successful");
        //        }
        //        else
        //        {
        //            Console.WriteLine("⚠️ Database connection failed - will continue with file system only");
        //        }



        //        // STEP 1 – Generate CSV from Production Master
        //        Console.WriteLine("\nSTEP 1: GENERATE CSV FROM PRODUCTION MASTER");

        //        var csvGenerator = new CodingMasterCSVGenerator(config, lab);
        //        var generatedCsvPath = csvGenerator.GenerateProductionCSV();

        //        Console.WriteLine($"✅ CSV Generated: {Path.GetFileName(generatedCsvPath)}");



        //        // STEP 2 – Validate with Coding Master
        //        Console.WriteLine("\nSTEP 2: VALIDATE WITH CODING MASTER");

        //        var validator = new Validator(generatedCsvPath, lab);
        //        var validationResults = validator.Execute();

        //        if (!validationResults.Any())
        //        {
        //            Console.WriteLine("⚠️ No validation results found. Skipping remaining steps.");
        //            return;
        //        }

        //        // STEP 3 – Enhanced Validation Report
        //        Console.WriteLine("\nSTEP 3: GENERATE ENHANCED REPORT");

        //        new EnhancedValidationReporter(config, lab).Execute(validationResults);

        //        var enhancedReportPath = GetLatestFile(lab.OutputFolder, "Enhanced_Validation_Report_*.csv");
        //        if (enhancedReportPath == null)
        //            throw new Exception("Enhanced report not generated.");

        //        // STEP 4 – Missing CPT Report
        //        Console.WriteLine("\nSTEP 4: GENERATE MISSING CPT REPORT");
        //        new MissingCPTReporter(lab.OutputFolder).Execute(validationResults);

        //        // STEP 5 – Additional CPT Report
        //        Console.WriteLine("\nSTEP 5: GENERATE ADDITIONAL CPT REPORT");
        //        new AdditionalCPTReporter(lab.OutputFolder).Execute(validationResults);

        //        // STEP 6 – Panel Summary
        //        Console.WriteLine("\nSTEP 6: GENERATE PANEL SUMMARY REPORT");

        //        //var panelSummaryPath = GetLatestFile(lab.OutputFolder, "Panel_Summary_Report_*.csv");

        //        //new PanelSummaryGenerator(lab.OutputFolder)
        //        //    .GeneratePanelSummaryFromCsv(enhancedReportPath);


        //        ////var panelSummaryPath = GetLatestFile(lab.OutputFolder, "Panel_Summary_Report_*.csv");

        //        ////new PanelSummary()
        //        ////        .Generate(enhancedReportPath, panelSummaryPath);





        //        //if (panelSummaryPath == null)
        //        //    throw new Exception("Panel summary report not generated.");

        //        //// Collect CSVs BEFORE Excel
        //        //generatedCsvFiles = Directory
        //        //    .GetFiles(lab.OutputFolder, "*.csv")
        //        //    .ToList();


        //       // 1️⃣ Generate first
        //        new PanelSummaryGenerator(lab.OutputFolder).GeneratePanelSummaryFromCsv(enhancedReportPath);

        //        // 2️⃣ THEN locate the generated file
        //        var panelSummaryPath = GetLatestFile(lab.OutputFolder, "Panel_Summary_Report_*.csv");

        //        if (panelSummaryPath == null)
        //            throw new Exception("Panel summary report not generated.");

        //        Console.WriteLine($"✅ Panel Summary Generated: {Path.GetFileName(panelSummaryPath)}");

        //        // STEP 7 – Excel
        //        Console.WriteLine("\nSTEP 7: GENERATE FORMATTED EXCEL REPORT");

        //        //var excelGenerator = new ExcelReportGenerator(lab.OutputFolder,lab.SourceFileName);
        //        //excelGenerator.GenerateFormattedExcelReport(
        //        //    enhancedReportPath,
        //        //    panelSummaryPath
        //        //);

        //        //excelGenerated = Directory
        //        //    .GetFiles(lab.OutputFolder, "Combined_Validation_Report_*.xlsx")
        //        //    .Any();

        //        var excelGenerator = new ExcelReportGenerator(lab.OutputFolder, lab.SourceFileName);

        //        string excelgenPath = excelGenerator.GenerateFormattedExcelReport(
        //            enhancedReportPath,
        //            panelSummaryPath
        //        );

        //        excelGenerated = !string.IsNullOrEmpty(excelgenPath) && File.Exists(excelgenPath);


        //        if (lab.UpdateDatabaseStatus(excelGenerated))
        //        {
        //            Console.WriteLine("✅ Database status updated");
        //        }

        //        // Collect CSVs BEFORE Excel
        //        generatedCsvFiles = Directory
        //            .GetFiles(lab.OutputFolder, "*.csv")
        //            .ToList();

        //        Console.ForegroundColor = ConsoleColor.Green;
        //        Console.WriteLine("\n✅ PIPELINE COMPLETED SUCCESSFULLY");
        //        Console.ResetColor();
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.ForegroundColor = ConsoleColor.Red;
        //        Console.WriteLine($"❌ PIPELINE FAILED: {ex.Message}");
        //        Console.ResetColor();
        //    }
        //    finally
        //    {
        //        MoveSourceFileAfterRun(lab, sourceFilePath, excelGenerated);
        //        MoveCsvFilesAfterRun(lab, generatedCsvFiles, excelGenerated);
        //    }
        //}
        static void RunPipeline(IConfiguration config, LabContext lab)
        {

            FileLogger.Info($"Pipeline started for lab: {lab.Lab}");

            Console.WriteLine("=".PadRight(60, '='));
            Console.WriteLine($"PROCESSING LAB : {lab.Lab}");
            Console.WriteLine("=".PadRight(60, '='));

            string sourceFilePath = lab.SourceFile; // This will be updated if we copy from DB
            bool sourceFileMoved = false;
            var generatedCsvFiles = new List<string>();
            bool excelGenerated = false;
            string excelPath = null;

            int reportId = 0;
            bool hasPendingJob = false;


            try
            {


                /// -- refresh
                /// // 🔹 STEP -1: Refresh Master Reference Files (FeeSchedule / InsuranceMaster)
                try
                {
                    FileLogger.Info($"Refreshing reference master files for lab: {lab.Lab}");

                    var dbService = new DatabaseService(config, lab.Lab);
                    var refManager = new MasterReferenceFileManager(config, dbService, lab.Lab);

                // refManager.RefreshReferenceFiles();
                        var updateResult = refManager.RefreshReferenceFiles();

                        if (updateResult.FeeScheduleImportedFileID.HasValue ||
                            updateResult.PayerMasterImportedFileID.HasValue ||
                             updateResult.CodingMasterImportedFileID.HasValue)
                        {
                            UpdateImportedFileIdsInAppSettings(
                                lab.Lab,
                                updateResult.FeeScheduleImportedFileID,
                                updateResult.PayerMasterImportedFileID,
                                updateResult.CodingMasterImportedFileID);

                            FileLogger.Info($"Updated appsettings ImportedFileIDs for lab {lab.Lab}");
                        }

                    FileLogger.Info($"Reference master file refresh completed for lab: {lab.Lab}");
                }
                catch (Exception ex)
                {
                    FileLogger.Error($"Reference file refresh failed for lab: {lab.Lab}", ex);
                    throw; // stop pipeline – reference files are mandatory
                }

            /// --refresh end


                // STEP 0: Check and copy source file from database if needed
                //  Console.WriteLine("\n🔍 CHECKING FOR PENDING VALIDATION JOBS");

                 Console.WriteLine("\n🔍 CHECKING FOR PENDING VALIDATION JOBS");
                FileLogger.Info("🔍CHECKING FOR PENDING VALIDATION JOBS");

                 hasPendingJob = lab.TryGetPendingValidationJob(out reportId, out string reportPath);
            
                if (hasPendingJob)
                {
                    lab.SetValidationReportId(reportId);
                    lab.UpdateInProgressStatus(reportId);



                    Console.WriteLine($"✅ Found pending job: ReportID={reportId}");

                    if (!string.IsNullOrEmpty(reportPath))
                    {
                        Console.WriteLine($"   Report path: {reportPath}");
                    }
                    else
                    {
                        Console.WriteLine($"⚠️ ReportServerPath is NULL/empty in database");
                    }

                    // For labs using DB production source, fetch and copy production report
                    if (lab.UseDbProductionSource)
                    {
                        Console.WriteLine("\n📥 FETCHING PRODUCTION REPORT FROM DATABASE");

                        if (lab.TryGetLatestProductionReport(out int prodReportId, out string prodReportPath))
                        {
                            Console.WriteLine($"   Found production report: {prodReportPath}");

                            if (!string.IsNullOrEmpty(prodReportPath) && File.Exists(prodReportPath))
                            {
                                // Copy the file to the lab's source folder
                                try
                                {
                                    var sourceDir = Path.GetDirectoryName(lab.SourceFile);
                                    if (!Directory.Exists(sourceDir))
                                        Directory.CreateDirectory(sourceDir);

                                    var timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                                    var newFileName = $"ProductionMaster_{timestamp}.xlsx";
                                    var destinationPath = Path.Combine(sourceDir, newFileName);

                                    File.Copy(prodReportPath, destinationPath, true);
                                    sourceFilePath = destinationPath;

                                    Console.WriteLine($"✅ Copied production report to: {Path.GetFileName(destinationPath)}");
                                }
                                catch (Exception ex)
                                {
                                    Console.WriteLine($"❌ Failed to copy production report: {ex.Message}");
                                    Console.WriteLine($"⚠️ Will use existing source file instead");
                                }
                            }
                            else
                            {
                                Console.WriteLine($"❌ Production report file not found or path is empty");
                                Console.WriteLine($"⚠️ Will use existing source file instead");
                            }
                        }
                        else
                        {
                            Console.WriteLine($"⚠️ No production report found in database");
                            Console.WriteLine($"   Will use existing source file instead");
                        }
                    }
                    else
                    {
                        Console.WriteLine($"📂 Lab uses file system source");
                        Console.WriteLine($"   Using local source file: {lab.SourceFileName}");
                    }
                }
                else
                {
                    Console.WriteLine($"⚠️ No pending validation jobs found for {lab.Lab}");
                    Console.WriteLine($"📂 Using local source file: {lab.SourceFileName}");
                }


                //// Test database connection
                //Console.WriteLine("\n🔗 TESTING DATABASE CONNECTION");
                //if (lab.TestDatabaseConnection())
                //{
                //    Console.WriteLine("✅ Database connection successful");
                //}
                //else
                //{
                //    Console.WriteLine("⚠️ Database connection failed - will continue with file system only");
                //}

                // STEP 1 – Generate CSV from Production Master
                Console.WriteLine("\nSTEP 1: GENERATE CSV FROM PRODUCTION MASTER");
                FileLogger.Info("STEP 1: GENERATE CSV FROM PRODUCTION MASTER");
                // Verify source file exists
                if (!File.Exists(sourceFilePath))
                {
                    Console.WriteLine($"❌ Source file not found: {sourceFilePath}");
                    Console.WriteLine("⚠️ Skipping pipeline for this lab");

                    FileLogger.Info("❌ Source file not found: {sourceFilePath}");
                //return;
                throw new FileNotFoundException($"Source file not found: {sourceFilePath}");
            }

                Console.WriteLine($"   Source file: {Path.GetFileName(sourceFilePath)}");

                var csvGenerator = new CodingMasterCSVGenerator(config, lab);
                var generatedCsvPath = csvGenerator.GenerateProductionCSV();

                Console.WriteLine($"✅ CSV Generated: {Path.GetFileName(generatedCsvPath)}");


                // 2️⃣ NEW – Line level (✅ CORRECT PLACE)
                var masterLineCsvPath = csvGenerator.GenerateMasterLineLevelCSV();
                Console.WriteLine($"✅ Line-level CSV Generated: {Path.GetFileName(masterLineCsvPath)}");

              var payerCPTAverageCSVPath = csvGenerator.GeneratePayerCPTAverageCSV();
              Console.WriteLine($"✅ Line-level CSV Generated: {Path.GetFileName(payerCPTAverageCSVPath)}");


            // STEP 2 – Validate with Coding Master
            Console.WriteLine("\nSTEP 2: VALIDATE WITH CODING MASTER");
                FileLogger.Info("\nSTEP 2: VALIDATE WITH CODING MASTER");
                var validator = new Validator(generatedCsvPath, lab);
                var validationResults = validator.Execute();

                //if (!validationResults.Any())
                //{
                //    Console.WriteLine("⚠️ No validation results found. Skipping remaining steps.");
                //    lab.UpdateDatabaseStatus(false);
                //    return;
                //}

                if (!validationResults.Any())
                {
                    throw new Exception("Validation completed but returned ZERO results.");
                }


            // STEP 3 – Enhanced Validation Report
            Console.WriteLine("\nSTEP 3: GENERATE ENHANCED REPORT");
                FileLogger.Info("\nSTEP 3: GENERATE ENHANCED REPORT");
                new EnhancedValidationReporter(config, lab).Execute(validationResults);

                var enhancedReportPath = GetLatestFile(lab.OutputFolder, "Enhanced_Validation_Report_*.csv");
                if (enhancedReportPath == null)
                    throw new Exception("Enhanced report not generated.");

                // STEP 4 – Missing CPT Report
                Console.WriteLine("\nSTEP 4: GENERATE MISSING CPT REPORT");
                FileLogger.Info("\nSTEP 4: GENERATE MISSING CPT REPORT");
                new MissingCPTReporter(lab.OutputFolder).Execute(validationResults);

                // STEP 5 – Additional CPT Report
                Console.WriteLine("\nSTEP 5: GENERATE ADDITIONAL CPT REPORT");
                new AdditionalCPTReporter(lab.OutputFolder).Execute(validationResults);

                // STEP 6 – Panel Summary
                Console.WriteLine("\nSTEP 6: GENERATE PANEL SUMMARY REPORT");
                FileLogger.Info("\nSTEP 6: GENERATE PANEL SUMMARY REPORT");
                // 1️⃣ Generate first
                new PanelSummaryGenerator(lab.OutputFolder).GeneratePanelSummaryFromCsv(enhancedReportPath);

                // 2️⃣ THEN locate the generated file
                var panelSummaryPath = GetLatestFile(lab.OutputFolder, "Panel_Summary_Report_*.csv");

                if (panelSummaryPath == null)
                    throw new Exception("Panel summary report not generated.");

                Console.WriteLine($"✅ Panel Summary Generated: {Path.GetFileName(panelSummaryPath)}");

                // STEP 7 – Excel
                Console.WriteLine("\nSTEP 7: GENERATE FORMATTED EXCEL REPORT");
                FileLogger.Info("\nSTEP 7: GENERATE FORMATTED EXCEL REPORT");
                var excelGenerator = new ExcelReportGenerator(lab.OutputFolder, lab.SourceFileName,lab);
                string excelgenPath = excelGenerator.GenerateFormattedExcelReport(
                    enhancedReportPath,
                    panelSummaryPath
                );

                excelGenerated = !string.IsNullOrEmpty(excelgenPath) && File.Exists(excelgenPath);

                if (excelGenerated)
                {
                    lab.GeneratedExcelPath = excelgenPath;
                    Console.WriteLine($"✅ Excel Report Generated: {Path.GetFileName(excelgenPath)}");
                    FileLogger.Info($"✅ Excel Report Generated: {Path.GetFileName(excelgenPath)}");
                    // Update database status with the generated Excel path
                    if (hasPendingJob && excelGenerated)
                    {
                        if (lab.UpdateDatabaseStatus(true, excelgenPath))
                        {
                            Console.WriteLine($"✅ Updated database for ReportID={reportId}");
                            Console.WriteLine($"   Report path: {excelgenPath}");


                        }
                    }
                }
                else
                {
                    FileLogger.Info("Excel report not generated.");
                    throw new Exception("Excel report not generated.");

                }
                //// Update database status
                //if (lab.UpdateDatabaseStatus(excelGenerated))
                //{
                //    Console.WriteLine("✅ Database status updated");

                //}

                // Collect CSVs for cleanup
                generatedCsvFiles = Directory
                    .GetFiles(lab.OutputFolder, "*.csv")
                    .ToList();

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine("\n✅ PIPELINE COMPLETED SUCCESSFULLY");
                FileLogger.Info("\n✅ PIPELINE COMPLETED SUCCESSFULLY");
                Console.ResetColor();
            }
            catch (Exception ex)
            {
            //Console.ForegroundColor = ConsoleColor.Red;
            //Console.WriteLine($"❌ PIPELINE FAILED: {ex.Message}");
            //FileLogger.Error($"❌ PIPELINE FAILED: {ex.Message}");
            //Console.ResetColor();

                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine($"❌ PIPELINE FAILED: {ex.Message}");
                Console.ResetColor();

                FileLogger.Error("❌ PIPELINE FAILED", ex);

                if (hasPendingJob && reportId > 0)
                {
                    MarkJobFailed(lab, reportId, ex);
                }

                // Try to collect CSV files for cleanup
                    try
                    {
                        generatedCsvFiles = Directory
                            .GetFiles(lab.OutputFolder, "*.csv")
                            .ToList();
                    }
                    catch
                    {
                        // Ignore if we can't collect files on error
                    }
                throw;
            }
            finally
            {
                 // Cleanup files - use the actual source file path (might be copied from DB)
                 MoveSourceFileAfterRun(lab, sourceFilePath, excelGenerated);
                 MoveCsvFilesAfterRun(lab, generatedCsvFiles, excelGenerated);
            }
        }
    static void UpdateImportedFileIdsInAppSettings(
      string lab,
      int? feeScheduleId,
      int? payerMasterId,
      int? codingMasterId)
    {
        var appSettingsPath = Path.Combine(
            AppContext.BaseDirectory, "appsettings.json");

        var json = File.ReadAllText(appSettingsPath);

        var root = JsonSerializer.Deserialize<
            Dictionary<string, object>>(json,
            new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            });

        var labExecution = JsonSerializer.Deserialize<
            Dictionary<string, Dictionary<string, object>>>(
            root["LabExecution"].ToString());

        if (!labExecution.ContainsKey(lab))
            return;

        if (feeScheduleId.HasValue)
            labExecution[lab]["FeeScheduleImportedFileID"] = feeScheduleId.Value;

        if (payerMasterId.HasValue)
            labExecution[lab]["PayerMasterImportedFileID"] = payerMasterId.Value;

        if (codingMasterId.HasValue)
            labExecution[lab]["CodingMasterImportedFileID"] = codingMasterId.Value;


        root["LabExecution"] = labExecution;

        var updatedJson = JsonSerializer.Serialize(
            root,
            new JsonSerializerOptions { WriteIndented = true });

        File.WriteAllText(appSettingsPath, updatedJson);
    }

    static void MarkJobFailed(LabContext lab, int reportId, Exception ex)
    {
        try
        {
            FileLogger.Error("❌ MARKING JOB AS FAILED", ex);

            if (reportId <= 0)
                return;

            string error =
                ex.Message + Environment.NewLine +
                ex.InnerException?.Message + Environment.NewLine +
                ex.StackTrace;

            if (error.Length > 4000)
                error = error.Substring(0, 4000);

            lab.UpdateDatabaseFailed(reportId, error);
        }
        catch (Exception dbEx)
        {
            FileLogger.Error("❌ FAILED TO UPDATE DB FAILURE STATUS", dbEx);
        }
    }



    static string GetLatestFile(string directory, string pattern)
        {
            if (!Directory.Exists(directory))
                return null;

            return Directory.GetFiles(directory, pattern)
                .Select(f => new FileInfo(f))
                .OrderByDescending(f => f.CreationTime)
                .FirstOrDefault()
                ?.FullName;
        }

        static void MoveSourceFileAfterRun(
        LabContext lab,
        string sourceFilePath,
        bool success)
        {
            try
            {
                if (string.IsNullOrEmpty(sourceFilePath) || !File.Exists(sourceFilePath))
                {
                    Console.WriteLine("⚠️ Source file not found or already moved.");
                    return;
                }

                var dateFolder = DateTime.Now.ToString("yyyy-MM-dd");

                var targetDir = success
                    ? Path.Combine(lab.ProcessingFilesFolder, dateFolder)
                    : Path.Combine(lab.ProcessingFilesFolder, "ERROR", dateFolder);

                Directory.CreateDirectory(targetDir);

                var destPath = Path.Combine(targetDir, Path.GetFileName(sourceFilePath));

                if (File.Exists(destPath))
                    File.Delete(destPath);

                File.Move(sourceFilePath, destPath);

                Console.WriteLine(success
                    ? $"📁 Source file moved to: {destPath}"
                    : $"❌ Source file moved to ERROR folder: {destPath}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"⚠️ Failed to move source file: {ex.Message}");
            }
        }

        static void MoveCsvFilesAfterRun(
         LabContext lab,
         List<string> csvFiles,
         bool success)
        {
            if (csvFiles == null || !csvFiles.Any())
                return;

            var dateFolder = DateTime.Now.ToString("yyyy-MM-dd");

            var targetDir = success
                ? Path.Combine(lab.ProcessingFilesFolder, dateFolder)
                : Path.Combine(lab.ProcessingFilesFolder, "ERROR", dateFolder);

            Directory.CreateDirectory(targetDir);

            foreach (var file in csvFiles)
            {
                try
                {
                    var dest = Path.Combine(targetDir, Path.GetFileName(file));

                    if (File.Exists(dest))
                        File.Delete(dest);

                    File.Move(file, dest);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"⚠️ Failed to move {Path.GetFileName(file)}: {ex.Message}");
                }
            }

            Console.WriteLine(success
                ? $"📁 CSV files moved to: {targetDir}"
                : $"❌ CSV files moved to ERROR folder: {targetDir}");
        }


        static string GetLatestFileByPattern(string directory, string pattern)
        {
            try
            {
                if (!Directory.Exists(directory))
                    return null;

                var files = Directory.GetFiles(directory, pattern);
                if (files.Length == 0)
                    return null;

                return files
                    .Select(f => new FileInfo(f))
                    .OrderByDescending(f => f.CreationTime)
                    .First()
                    .FullName;
            }
            catch
            {
                return null;
            }
        }

        static void DisplayFinalSummary(string generatedCsvPath, string enhancedReportPath, string panelSummaryPath)
        {
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine("\n" + "=".PadRight(60, '='));
            Console.WriteLine("VALIDATION PROCESS COMPLETE!");
            Console.WriteLine("=".PadRight(60, '='));
            Console.ResetColor();

            Console.WriteLine("\n📁 Generated Files:");
            Console.WriteLine("-".PadRight(60, '-'));

            int fileCounter = 1;

            // Show the actual generated file
            if (File.Exists(generatedCsvPath))
            {
                var fileInfo = new FileInfo(generatedCsvPath);
                Console.WriteLine($"{fileCounter++}. {Path.GetFileName(generatedCsvPath)}");
                Console.WriteLine($"   Location: {Path.GetDirectoryName(generatedCsvPath)}");
                Console.WriteLine($"   Size: {GetFileSize(fileInfo.Length)}");
                Console.WriteLine($"   Created: {fileInfo.CreationTime:yyyy-MM-dd HH:mm:ss}");
            }
            else
            {
                Console.WriteLine($"{fileCounter++}. ProductionMaster_Extracted.csv");
                Console.WriteLine($"   Location: E:\\LRN-Data\\CodingMaster\\Outputs\\");
            }

            // Check for validation report
            string validationReportPath = @"E:\LRN-Data\Validation_WithExpectedCodes.csv";
            if (File.Exists(validationReportPath))
            {
                var validationInfo = new FileInfo(validationReportPath);
                Console.WriteLine($"\n{fileCounter++}. Validation_WithExpectedCodes.csv");
                Console.WriteLine($"   Location: {validationInfo.DirectoryName}");
                Console.WriteLine($"   Size: {GetFileSize(validationInfo.Length)}");
            }

            // Check for enhanced report
            if (!string.IsNullOrEmpty(enhancedReportPath) && File.Exists(enhancedReportPath))
            {
                var enhancedInfo = new FileInfo(enhancedReportPath);
                Console.WriteLine($"\n{fileCounter++}. {Path.GetFileName(enhancedReportPath)}");
                Console.WriteLine($"   Location: {enhancedInfo.DirectoryName}");
                Console.WriteLine($"   Size: {GetFileSize(enhancedInfo.Length)}");
            }

            // Check for panel summary
            if (!string.IsNullOrEmpty(panelSummaryPath) && File.Exists(panelSummaryPath))
            {
                var panelInfo = new FileInfo(panelSummaryPath);
                Console.WriteLine($"\n{fileCounter++}. {Path.GetFileName(panelSummaryPath)}");
                Console.WriteLine($"   Location: {panelInfo.DirectoryName}");
                Console.WriteLine($"   Size: {GetFileSize(panelInfo.Length)}");
            }

            // Check for missing CPT report
            string missingReportPath = @"E:\LRN-Data\Missing_CPT_Codes_Report.csv";
            if (File.Exists(missingReportPath))
            {
                var missingInfo = new FileInfo(missingReportPath);
                Console.WriteLine($"\n{fileCounter++}. Missing_CPT_Codes_Report.csv");
                Console.WriteLine($"   Location: {missingInfo.DirectoryName}");
                Console.WriteLine($"   Size: {GetFileSize(missingInfo.Length)}");
            }

            // Check for additional CPT report
            string additionalReportPath = @"E:\LRN-Data\Additional_CPT_Codes_Report.csv";
            if (File.Exists(additionalReportPath))
            {
                var additionalInfo = new FileInfo(additionalReportPath);
                Console.WriteLine($"\n{fileCounter++}. Additional_CPT_Codes_Report.csv");
                Console.WriteLine($"   Location: {additionalInfo.DirectoryName}");
                Console.WriteLine($"   Size: {GetFileSize(additionalInfo.Length)}");
            }

            // Check for Excel report (look for latest)
            string excelReportPath = GetLatestFileByPattern(@"E:\LRN-Data\CodingMaster\Outputs",
                "Combined_Validation_Report_*.xlsx");
            if (!string.IsNullOrEmpty(excelReportPath) && File.Exists(excelReportPath))
            {
                var excelInfo = new FileInfo(excelReportPath);
                Console.WriteLine($"\n{fileCounter++}. {Path.GetFileName(excelReportPath)}");
                Console.WriteLine($"   Location: {excelInfo.DirectoryName}");
                Console.WriteLine($"   Size: {GetFileSize(excelInfo.Length)}");
                Console.WriteLine($"   Worksheets: 3 (Enhanced Validation, Panel Summary, Financial Dashboard)");
            }

            Console.WriteLine($"\n{fileCounter++}. Log Files");
            Console.WriteLine($"   Location: E:\\LRN-Data\\CodingMaster\\Logs\\");
            Console.WriteLine($"   Purpose: Process logs and summary reports");

            Console.WriteLine("\n📊 Next Steps:");
            Console.WriteLine("-".PadRight(60, '-'));
            Console.WriteLine("1. Review the Combined Excel Report for comprehensive analysis");
            Console.WriteLine("2. Check the Financial Dashboard for KPIs and recommendations");
            Console.WriteLine("3. Review the Panel Summary report for overall trends");
            Console.WriteLine("4. Review the Missing CPT Codes report");
            Console.WriteLine("5. Review the Additional CPT Codes report");
            Console.WriteLine("6. Update production data or coding master as needed");
            Console.WriteLine("7. Re-run validation after corrections");
        }

        static string GenerateAndGetCSVPath(CodingMasterCSVGenerator generator)
        {
            // First, generate the CSV
            string generatedPath = generator.GenerateProductionCSV();

            // Return the path from the generator if available
            if (!string.IsNullOrEmpty(generatedPath) && File.Exists(generatedPath))
            {
                return generatedPath;
            }

            // Fallback: Then find the latest generated file
            string outputFolder = @"E:\LRN-Data\CodingMaster\Outputs";
            string fallbackPath = @"E:\LRN-Data\CodingMaster\Inputs\ProductionMaster_Extracted.csv";

            try
            {
                if (!Directory.Exists(outputFolder))
                    return fallbackPath;

                var files = Directory.GetFiles(outputFolder, "ProductionMaster_Extracted_*.csv");
                if (files.Length == 0)
                    return fallbackPath;

                // Get the most recent file
                var latestFile = files
                    .Select(f => new FileInfo(f))
                    .OrderByDescending(f => f.CreationTime)
                    .First()
                    .FullName;

                return latestFile;
            }
            catch
            {
                return fallbackPath;
            }
        }

        static string GetFileSize(long bytes)
        {
            string[] sizes = { "B", "KB", "MB", "GB" };
            int order = 0;
            double len = bytes;

            while (len >= 1024 && order < sizes.Length - 1)
            {
                order++;
                len = len / 1024;
            }

            return $"{len:0.##} {sizes[order]}";
        }
    
}