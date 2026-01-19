using System;
using System.IO;
using Microsoft.Extensions.Configuration;

namespace LRN.CodingMasterValidation
{
    public static class FileLogger
    {
        private static readonly string LogRoot;
        private static readonly object _lock = new();

        static FileLogger()
        {
            try
            {
                // Load configuration

                var exePath = AppContext.BaseDirectory;
                var configuration = new ConfigurationBuilder()
                    .SetBasePath(exePath)
                    .AddJsonFile("appsettings.json", optional: true)
                    .Build();


                //var configuredPath = configuration["LogFolder"];

                var configuredPath = configuration["CodingMaster:LogFolder"];


                if (string.IsNullOrWhiteSpace(configuredPath))
                {
                    // Fallback default
                    LogRoot = @"C:\\CodingMasterFiles\\Logs";
                }
                else
                {
                    // 🔥 Remove {LAB} placeholder safely
                    LogRoot = configuredPath
                        .Replace(@"\{LAB}\", @"\")
                        .Replace(@"{LAB}\", string.Empty)
                        .Replace(@"\{LAB}", string.Empty)
                        .Replace("{LAB}", string.Empty)
                        .TrimEnd('\\');
                }

                Directory.CreateDirectory(LogRoot);
            }
            catch
            {
                // Absolute fallback (logger must never crash app)
                LogRoot = @"E:\LRN-Data\CodingMaster\Logs";
                Directory.CreateDirectory(LogRoot);
            }
        }

        private static string LogFile =>
            Path.Combine(LogRoot, $"CodingMaster_{DateTime.Now:yyyy-MM-dd}.log");

        public static void Info(string message)
            => Write("INFO", message);

        public static void Warn(string message)
            => Write("WARN", message);

        public static void Error(string message, Exception ex = null)
        {
            Write("ERROR", message);
            if (ex != null)
                Write("ERROR", ex.ToString());
        }

        private static void Write(string level, string message)
        {
            var line =
                $"{DateTime.Now:yyyy-MM-dd HH:mm:ss.fff} [{level}] {message}";

            lock (_lock)
            {
                File.AppendAllText(LogFile, line + Environment.NewLine);
            }
        }
    }
}
