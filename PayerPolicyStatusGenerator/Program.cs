using Microsoft.Extensions.Configuration;
using PayerPolicyStatusGenerator.Services;
using System;
using System.IO;

namespace PayerPolicyStatusGenerator
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.Title = "Payer Policy Status Generator";

            try
            {
                // Check current directory
                Console.WriteLine($"Current Directory: {Directory.GetCurrentDirectory()}");
                Console.WriteLine($"App Location: {AppDomain.CurrentDomain.BaseDirectory}\n");

                // Load configuration
                var configuration = LoadConfiguration();

                // Process command line arguments
                if (args.Length > 0)
                {
                    configuration["AppSettings:InputFolderPath"] = args[0];
                    Console.WriteLine($"Using command line input folder: {args[0]}");
                }
                if (args.Length > 1)
                {
                    configuration["AppSettings:OutputFolderPath"] = args[1];
                    Console.WriteLine($"Using command line output folder: {args[1]}");
                }

                // Create and run processor
                var processor = new CSVFileProcessor(configuration);
                processor.ProcessAllFiles();

                Console.WriteLine("\nPress any key to exit...");
                Console.ReadKey();
            }
            catch (Exception ex)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine($"\nCRITICAL ERROR: {ex.Message}");
                Console.WriteLine($"\nStack Trace:\n{ex.StackTrace}");
                Console.ResetColor();

                Console.WriteLine("\nPress any key to exit...");
                Console.ReadKey();
                Environment.Exit(1);
            }
        }

        static IConfiguration LoadConfiguration()
        {
            string configFile = "appsettings.json";

            if (!File.Exists(configFile))
            {
                Console.WriteLine("Creating default appsettings.json...");
                CreateDefaultConfig(configFile);
            }

            return new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: false)
                .Build();
        }

        static void CreateDefaultConfig(string path)
        {
            var defaultConfig = @"{
  ""AppSettings"": {
    ""InputFolderPath"": ""D:\\LRN\\Reports\\OutputFiles\\PayerPolicyApplyOutput"",
    ""OutputFolderPath"": ""D:\\LRN\\Reports\\OutputFiles\\ProcessedWithPaymentStatus"",
    ""LogFilePath"": ""D:\\LRN\\Reports\\Logs\\processing_log.txt"",
    ""FilePattern"": ""*.csv"",
    ""ProcessSubfolders"": false
  },
  ""PaymentStatusSettings"": {
    ""CoveredKeywords"": [ ""Covered"", ""Conditional - Dx"" ],
    ""ValidationPassKeyword"": ""Pass""
  }
}";
            File.WriteAllText(path, defaultConfig);
            Console.WriteLine("Default configuration created.");
        }
    }
}