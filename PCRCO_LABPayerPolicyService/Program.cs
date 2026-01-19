using System;
using System.IO;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting; // Add this for SetBasePath

namespace PCRCO_LABPayerPolicyService
{
    class Program
    {
        static void Main()
        {
            try
            {
                // Build configuration from appsettings.json
                var configuration = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                    .Build();

                // Validate connection string
                var connectionString = configuration.GetConnectionString("DefaultConnection");
                if (string.IsNullOrEmpty(connectionString))
                {
                    throw new Exception("Connection string 'DefaultConnection' not found in appsettings.json");
                }

                //Console.WriteLine("Starting Denial Payer Policy CSV Generation...");
                Console.WriteLine("Starting Production Payer Policy CSV Generation...");

                // Create and run the generator

                //Commented for testing
                var generator = new DenialPayerPolicyCSVGenerator(configuration);
                generator.Generate_CSV_DenialPayerPolicy();
                //Commented for end testing
                Console.WriteLine("Process completed successfully!");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Application error: {ex.Message}");
                Console.WriteLine($"Stack trace: {ex.StackTrace}");
            }
        }
    }
}