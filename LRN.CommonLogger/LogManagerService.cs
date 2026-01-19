using log4net;
using log4net.Config;
using System.Reflection;

namespace Common.Logging
{
	public sealed class LogManagerService : ILoggerService
	{
		private static readonly object _sync = new();
		private static bool _configured = false;

        //private static ILog Log
        //{
        //	get
        //	{
        //		EnsureConfigured();
        //		// IMPORTANT: create logger AFTER config, and bind to the SAME repository
        //		var repo = log4net.LogManager.GetRepository(Assembly.GetEntryAssembly() ?? typeof(LogManagerService).Assembly);
        //		return log4net.LogManager.GetLogger(repo.Name, typeof(LogManagerService));
        //	}
        //}

        private static ILog Log
        {
            get
            {
                EnsureConfigured();
                return log4net.LogManager.GetLogger(
                    typeof(LogManagerService).Assembly,
                    typeof(LogManagerService)
                );
            }
        }


        private static void EnsureConfigured()
		{
			if (_configured) return;

			lock (_sync)
			{
				if (_configured) return;

				var entryAsm = Assembly.GetEntryAssembly() ?? typeof(LogManagerService).Assembly;

                var repo = log4net.LogManager.GetRepository(typeof(LogManagerService).Assembly);

                //var repo = log4net.LogManager.GetRepository(entryAsm);

				var configPath = Path.Combine(AppContext.BaseDirectory, "log4net.config");
                //if (!File.Exists(configPath))
                //{
                //	// Optional: fallback to a minimal config so you still get something
                //	// BasicConfigurator.Configure(repo);
                //	_configured = true;
                //	return;
                //}

                if (!File.Exists(configPath))
                {
                    throw new FileNotFoundException(
                        $"log4net.config not found at {configPath}"
                    );
                }
                //File.WriteAllText(@"D:\LRN\Reports\logs\log4net_loaded.txt", "log4net.config loaded successfully at " + DateTime.Now);

                //var logDir = @"D:\LRN\Reports\logs";
                //Directory.CreateDirectory(logDir);

                //File.WriteAllText(
                //    Path.Combine(logDir, "log4net_loaded.txt"),
                //    "log4net.config loaded successfully at " + DateTime.Now
                //);


                XmlConfigurator.ConfigureAndWatch(repo, new FileInfo(configPath));
				_configured = true;
			}
		}

		public void Info(string message) => Log.Info(message);
		public void Warn(string message) => Log.Warn(message);
		public void Error(string message, Exception? ex = null) => Log.Error(message, ex);
		public void Fatal(string message, Exception? ex = null) => Log.Fatal(message, ex);
	}
}
