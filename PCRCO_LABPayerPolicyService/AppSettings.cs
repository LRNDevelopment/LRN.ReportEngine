using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCRCO_LABPayerPolicyService
{
    public class AppSettings
    {
        public ConnectionStrings ConnectionStrings { get; set; }
        public OutputSettings OutputSettings { get; set; }
    }

    public class ConnectionStrings
    {
        public string DefaultConnection { get; set; }
    }

    public class OutputSettings
    {
        public string OutputFolder { get; set; }
        public string CsvFileName { get; set; }
        public string LogFolder { get; set; }
        public string PayerPolicyFolder { get; set; }
        public string LABName { get; set; }
    }
}
