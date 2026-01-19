namespace Common.Logging
{
    public interface ILoggerService
    {
        void Info(string message);
        void Warn(string message);
        void Error(string message, Exception? ex = null);
        void Fatal(string message, Exception? ex = null);



        //void LogInformation(string message);
        //void LogWarning(string message);
        //void LogError(string message, Exception? ex = null);
        //void Fatal(string message, Exception? ex = null);
    }
}