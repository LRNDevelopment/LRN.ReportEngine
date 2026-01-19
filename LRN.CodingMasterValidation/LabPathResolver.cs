using Microsoft.Extensions.Configuration;
using System;
using System.IO;

namespace LRN.CodingMasterValidation
{
    public class LabPathResolver
    {
        public string ActiveLab { get; }
        public string LabRoot { get; }
        public string OutputRoot { get; }
        public string ProcessingFiles { get; }
        public string Logs { get; }

        public LabPathResolver(IConfiguration config)
        {
            var basePath = config["LabSettings:BasePath"]
                           ?? @"E:\LRN-Data\CodingMaster\Labs";

            ActiveLab = config["LabSettings:ActiveLab"];

            if (string.IsNullOrWhiteSpace(ActiveLab))
                throw new Exception("❌ ActiveLab not configured in appsettings.json");

            // Validate lab exists
            var labSection = config.GetSection($"LabSettings:Labs:{ActiveLab}");
            if (!labSection.Exists())
                throw new Exception($"❌ Lab '{ActiveLab}' not found in LabSettings:Labs");

            LabRoot = Path.Combine(basePath, ActiveLab);
            OutputRoot = Path.Combine(LabRoot, "Outputs");
            ProcessingFiles = Path.Combine(OutputRoot, "ProcessingFiles");
            Logs = Path.Combine(LabRoot, "Logs");

            EnsureDirectories();
        }

        private void EnsureDirectories()
        {
            Directory.CreateDirectory(LabRoot);
            Directory.CreateDirectory(OutputRoot);
            Directory.CreateDirectory(ProcessingFiles);
            Directory.CreateDirectory(Logs);
        }
    }
}
