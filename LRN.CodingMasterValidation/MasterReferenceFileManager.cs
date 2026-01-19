using Microsoft.Extensions.Configuration;
using System;
using System.IO;

namespace LRN.CodingMasterValidation
{
    public class MasterReferenceFileManager
    {
        private readonly IConfiguration _config;
        private readonly DatabaseService _db;
        private readonly string _lab;

        public MasterReferenceFileManager(
            IConfiguration configuration,
            DatabaseService databaseService,
            string lab)
        {
            _config = configuration;
            _db = databaseService;
            _lab = lab;
        }

        //// ================= ENTRY POINT =================
        //public void RefreshReferenceFiles()
        //{
        //    HandleFeeSchedule();
        //    HandleInsuranceMaster();
        //}

        //// ================= CPT FEE SCHEDULE =================
        //private void HandleFeeSchedule()
        //{
        //    var latest = _db.GetLatestImportedFile(20001); // CPT_FeeSchedule
        //    if (latest == null) return;

        //    int existingId = _config.GetValue<int>(
        //        $"LabExecution:{_lab}:FeeScheduleImportedFileID");

        //    if (latest.ImportedFileID == existingId)
        //    {
        //        Log($"FeeSchedule already processed. ImportedFileID={existingId}");
        //        return;
        //    }

        //    string targetPath = ResolveLabPath(
        //        _config["CodingMaster:FeeSchedulePath"]);

        //    ArchiveIfExists(targetPath);
        //    Download(latest.ImportFilePath, targetPath);

        //    Log($"FeeSchedule updated. New ImportedFileID={latest.ImportedFileID}");
        //    // Optionally persist ID later
        //}

        //// ================= INSURANCE MASTER =================
        //private void HandleInsuranceMaster()
        //{
        //    var latest = _db.GetLatestImportedFile(20002); // InsuranceMaster
        //    if (latest == null) return;

        //    int existingId = _config.GetValue<int>(
        //        $"LabExecution:{_lab}:PayerMasterImportedFileID");

        //    if (latest.ImportedFileID == existingId)
        //    {
        //        Log($"InsuranceMaster already processed. ImportedFileID={existingId}");
        //        return;
        //    }

        //    string targetPath = ResolveLabPath(
        //        _config["PayerMaster:FilePath"]);

        //    ArchiveIfExists(targetPath);
        //    Download(latest.ImportFilePath, targetPath);

        //    Log($"InsuranceMaster updated. New ImportedFileID={latest.ImportedFileID}");
        //}

        // ================= HELPERS =================
        private void ArchiveIfExists(string filePath)
        {
            if (!File.Exists(filePath)) return;

            string dir = Path.GetDirectoryName(filePath);
            string archiveDir = Path.Combine(dir, "Archive");
            Directory.CreateDirectory(archiveDir);

            string ts = DateTime.Now.ToString("yyyyMMdd_HHmmss");
            string archivedFile =
                Path.Combine(archiveDir,
                    $"{Path.GetFileNameWithoutExtension(filePath)}_{ts}{Path.GetExtension(filePath)}");

            File.Move(filePath, archivedFile, true);
        }

        private void Download(string sourcePath, string targetPath)
        {
            Directory.CreateDirectory(Path.GetDirectoryName(targetPath));
            File.Copy(sourcePath, targetPath, true);
        }

        private string ResolveLabPath(string template)
        {
            return template.Replace("{LAB}", _lab);
        }
        private int? HandleFeeSchedule()
        {
            var latest = _db.GetLatestImportedFile(20001);
            if (latest == null) return null;

            int existingId = _config.GetValue<int>(
                $"LabExecution:{_lab}:FeeScheduleImportedFileID");

            if (latest.ImportedFileID == existingId)
            {
                Log($"FeeSchedule already processed. ImportedFileID={existingId}");
                return null;
            }

            string targetPath = ResolveLabPath(
                _config["CodingMaster:FeeSchedulePath"]);

            ArchiveIfExists(targetPath);
            Download(latest.ImportFilePath, targetPath);

            Log($"FeeSchedule updated. New ImportedFileID={latest.ImportedFileID}");
            return latest.ImportedFileID;
        }
        private int? HandleInsuranceMaster()
        {
            var latest = _db.GetLatestImportedFile(20002);
            if (latest == null) return null;

            int existingId = _config.GetValue<int>(
                $"LabExecution:{_lab}:PayerMasterImportedFileID");

            if (latest.ImportedFileID == existingId)
            {
                Log($"InsuranceMaster already processed. ImportedFileID={existingId}");
                return null;
            }

            string targetPath = ResolveLabPath(
                _config["PayerMaster:FilePath"]);

            ArchiveIfExists(targetPath);
            Download(latest.ImportFilePath, targetPath);

            Log($"InsuranceMaster updated. New ImportedFileID={latest.ImportedFileID}");
            return latest.ImportedFileID;
        }


        public ReferenceFileUpdateResult RefreshReferenceFiles()
        {
            var result = new ReferenceFileUpdateResult();

            result.FeeScheduleImportedFileID = HandleFeeSchedule();
            result.PayerMasterImportedFileID = HandleInsuranceMaster();

            return result;
        }

        private void Log(string msg)
        {
            Console.WriteLine($"[ReferenceFileManager] {_lab} - {msg}");
        }
    }
}
