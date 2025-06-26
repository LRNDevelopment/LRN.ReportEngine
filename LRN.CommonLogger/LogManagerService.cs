using log4net;
using log4net.Config;
using System.Reflection;

namespace Common.Logging
{
    public class LogManagerService : ILoggerService
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(LogManagerService));

        static LogManagerService()
        {
            var logRepo = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepo, new FileInfo("log4net.config"));
        }

        public void Info(string message) => _log.Info(message);
        public void Warn(string message) => _log.Warn(message);
        public void Error(string message, Exception? ex = null) => _log.Error(message, ex);
        public void Fatal(string message, Exception? ex = null) => _log.Fatal(message, ex);
    }
}
