using BCrypt.Net;
using Common.Logging;
using DocumentFormat.OpenXml.InkML;
using DocumentFormat.OpenXml.Math;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.DtoModels;
using LRN.ExcelToSqlETL.Core.Interface;
using LRN.ExcelToSqlETL.Core.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using System;
using System.Data;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;
using System.Windows.Forms;
using static LRN.ExcelToSqlETL.Core.Constants.CommonConst;

namespace ExcelETLWinApp
{
    public partial class MainForm : Form
    {
        string selectedUploadFilePath = string.Empty;
        private readonly AppSettings _appSettings;
        private readonly IExcelMapperLoader _mapper;
        private readonly IFileReader _reader;
        private readonly IDataValidator _validator;
        private readonly IDataImporter _importer;
        private readonly ILoggerService _logger;
        private readonly IConfiguration _config;
        private readonly IImportFilesRepository _importRepo;

        public MainForm(IExcelMapperLoader mapper,
        IFileReader reader,
        IDataValidator validator,
        IDataImporter importer,
        ILoggerService logger,
        IConfiguration config,
        IImportFilesRepository importRepo,
        IOptions<AppSettings> appSettings)
        {
            InitializeComponent();
            _logger = logger;
            _appSettings = appSettings.Value;
            _mapper = mapper;
            _reader = reader;
            _validator = validator;
            _importer = importer;
            _logger = logger;
            _config = config;
            _importRepo = importRepo;

            _logger.Info($"MainForm initialized with Upload URL: {_appSettings.UploadApiUrl}");

            cmbUploadReportType.Items.AddRange(new object[]
            {
                "LIS Raw Report",
                "Custom Collection Repo",
                "Visit Against Accession",
                "Transaction Detail Report",
                "Denial Tracking Report",
                "Prism Billing Sheet",
                "Panel Group"
            });
            cmbUploadReportType.SelectedIndex = 0;

            cmbDownloadReportType.Items.AddRange(new object[]
            {
                "LIS Master",
                "Production Report",
                "Collection Report",
                "Executive Summary",
                "Denial Report"
            });
            cmbDownloadReportType.SelectedIndex = 0;
        }

        private void btnSelectFile_Click(object sender, EventArgs e)
        {
            using var dialog = new OpenFileDialog();
            dialog.Filter = "Excel Files|*.xlsx;*.xls";
            if (dialog.ShowDialog() == DialogResult.OK)
            {
                selectedUploadFilePath = dialog.FileName;
                txtFile.Text = selectedUploadFilePath;
            }
        }

        private async void btnUpload_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(selectedUploadFilePath))
                {
                    MessageBox.Show("Please select a file.");
                    return;
                }
                var masterConfig = JsonConvert.DeserializeObject<MappingConfigRoot>(File.ReadAllText(MappingJSONPath));
                string reportType = cmbUploadReportType.SelectedIndex.ToString();
                string fileName = Path.GetFileName(selectedUploadFilePath);

                var mappingDtl = masterConfig.Mappings.Where(c => c.FileType == reportType).FirstOrDefault();
                if (mappingDtl == null)
                {
                    MessageBox.Show("No Mapping found.");
                    return;
                }

                var importFileDtos = new ImportFileDto();
                importFileDtos.FileType = int.Parse(reportType);
                importFileDtos.ImportFileName = fileName;

                importFileDtos = await _importRepo.AddImportFileAync(importFileDtos);
                var jsonPath = Path.Combine(JSONPath, mappingDtl.JsonMappingPath);

                if (!File.Exists(jsonPath))
                {
                    MessageBox.Show($"Mapping file not found: {jsonPath}.");
                    return;
                }

                var mapping = _mapper.LoadMapping(jsonPath);
                _logger.Info($"Loaded mapping from: {jsonPath}");

                using var stream = File.OpenRead(selectedUploadFilePath);
                var readResults = await _reader.ReadAsync(stream, mapping, (int)importFileDtos.ImportedFileId);


                foreach (var result in readResults)
                {
                    var validation = _validator.Validate(result.Data, mapping, (int)importFileDtos.ImportedFileId).Result;
                    if (!validation.IsValid)
                    {
                        foreach (var error in validation.Errors)
                        {
                            _logger.Error($"Validation error in {fileName}: {error}");
                        }
                        continue;
                    }

                    if (result.Data.Columns.Contains("ImportedFileID") && importFileDtos.ImportedFileId != null)
                    {
                        foreach (DataRow row in result.Data.Rows)
                        {
                            row["ImportedFileID"] = importFileDtos.ImportedFileId;
                        }
                    }

                    await _importer.ImportAsync(result.Data, mapping.TargetTable, (int)importFileDtos.ImportedFileId);

                    importFileDtos.ExcelRowCount = result.TotalRows;
                    importFileDtos.ImportedRowCount = result.ImportedRows;
                    importFileDtos.FileStatus = (int)FileStatusEnum.ImportSuccess;
                    importFileDtos.ImportedOn = DateTime.Now;

                    _logger.Info($"Imported {result.ImportedRows} rows to {mapping.TargetTable} for file {fileName}");
                    MessageBox.Show($"Imported {result.ImportedRows} rows to {mapping.TargetTable} for file {fileName}");
                }
            }
            catch (Exception ex)
            {

                _logger.Error($"Error on importing : {ex}");
                MessageBox.Show($"Error on importing : {ex}");
            }
        }

        private async void btnDownload_Click(object sender, EventArgs e)
        {
            string reportType = cmbDownloadReportType.SelectedItem.ToString();
            using var client = new HttpClient();
            var response = await client.GetAsync($"https://mock-api/download?reportType={reportType}");

            if (response.IsSuccessStatusCode)
            {
                var bytes = await response.Content.ReadAsByteArrayAsync();
                using var dialog = new SaveFileDialog();
                dialog.Filter = "Excel Files|*.xlsx";
                dialog.FileName = $"{reportType}_Report.xlsx";

                if (dialog.ShowDialog() == DialogResult.OK)
                {
                    File.WriteAllBytes(dialog.FileName, bytes);
                    MessageBox.Show("Download complete!");
                }
            }
            else
            {
                MessageBox.Show("Download failed.");
            }
        }

        private async void btnRunETL_Click(object sender, EventArgs e)
        {
            using var client = new HttpClient();
            var response = await client.PostAsync("https://mock-api/run-etl", null);
            MessageBox.Show(response.IsSuccessStatusCode ? "ETL process started." : "ETL process failed.");
        }

        private void btnProcessMultiple_Click(object sender, EventArgs e)
        {

        }

        private void Enrypt_Click(object sender, EventArgs e)
        {
            string hash = BCrypt.Net.BCrypt.HashPassword(txtPassword.Text);
            txtPasswordHash.Text = hash;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string hash = BCrypt.Net.BCrypt.EnhancedHashPassword(txtPasswordHash.Text);
            txtPassword.Text = hash;
        }
    }
}
