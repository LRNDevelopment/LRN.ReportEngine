using ClosedXML.Excel;
using Common.Logging;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelGenerator;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.DtoModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

[Authorize]
public class UploadController : Controller
{
    private readonly ILoggerService _logger;
    private readonly IConfiguration _config;
    private readonly IImportFilesRepository _importRepo;
    private readonly ILookUpRepository _lookupRepo;
    private readonly IExcelWriter _excelWriter;
    private readonly IReportRepository _reportRepository;

    public UploadController(
        ILoggerService logger,
        IConfiguration config,
        IImportFilesRepository importRepo,
        ILookUpRepository lookupRepo,
        IExcelWriter excelWriter,
        IReportRepository reportRepository)
    {
        _logger = logger;
        _config = config;
        _importRepo = importRepo;
        _lookupRepo = lookupRepo;
        _excelWriter = excelWriter;
        _reportRepository = reportRepository;
    }

    public async Task<IActionResult> Index()
    {
        var result = await _importRepo.GetImportFilesAsync();
        var files = new List<FileUpload>();

        ViewBag.Labs = new List<SelectListItem>
        {
            new SelectListItem { Text = "Prism", Value = "3" }
        };

        var importFileTypes = await _lookupRepo.GetImportFileTypesAsync();
        ViewBag.FileTypes = importFileTypes.Select(l => new SelectListItem
        {
            Text = l.FileTypeName,
            Value = l.FileTypeId.ToString()
        }).ToList();

        foreach (var file in result)
        {
            files.Add(new FileUpload
            {
                ImportedFileId = file.ImportedFileId,
                FileType = file.FileType,
                ProcessedOn = file.ProcessedOn,
                ImportedOn = file.ImportedOn,
                ImportedRowCount = file.ImportedRowCount,
                ExcelRowCount = file.ExcelRowCount,
                FileStatus = file.FileStatus,
                FileStatusName = file.FileStatusName,
                FileTypeName = file.FileTypeName,
                ImportFileName = file.ImportFileName,
                ImportFilePath = file.ImportFilePath
            });
        }

        return View(files);
    }

    public async Task<IActionResult> UploadFile(IFormFile file, string lab, string fileType)
    {
        try
        {
            if (file != null && file.Length > 0)
            {
                var uploadsFolder = Path.Combine(CommonConst.ImportFilePath);
                if (!Directory.Exists(uploadsFolder))
                    Directory.CreateDirectory(uploadsFolder);

                var uniqueFileName = $"{Guid.NewGuid()}_{Path.GetFileName(file.FileName)}";
                var filePath = Path.Combine(uploadsFolder, uniqueFileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await file.CopyToAsync(stream);
                }

                var fileDto = new ImportFileDto
                {
                    ImportFileName = Path.GetFileName(file.FileName),
                    FileType = int.Parse(fileType),
                    FileStatus = (int)CommonConst.FileStatusEnum.ImportQueued,
                    ImportFilePath = filePath,
                    ImportedOn = DateTime.Now,
                    LabId = int.Parse(lab)
                };

                await _importRepo.AddImportFileAync(fileDto);
                TempData["UploadSuccess"] = "true";

                _logger.Info($"File uploaded: {file.FileName}, Lab: {lab}, Type: {fileType}");
            }
        }
        catch (Exception ex)
        {
            TempData["UploadSuccess"] = "false";
            _logger.Error($"An error occurred while uploading the file: {ex.Message}", ex);
        }

        return RedirectToAction("Index");
    }

    public async Task<FileResult> DownloadImportLogs(int fileId)
    {
        var logs = await _importRepo.GetFileLogsById(fileId);

        var formattedLogs = logs.Select(log =>
            $"{log.LogType}  :  {log.LogMessage} : {log.RowNo} : {log.ColumnName} :: {log.CreatedOn:yyyy-MM-dd HH:mm:ss}");

        var logText = string.Join(Environment.NewLine, formattedLogs);
        var bytes = System.Text.Encoding.UTF8.GetBytes(logText);

        return File(bytes, "text/plain", $"ImportLogs_{fileId}.txt");
    }

    [HttpPost]
    public IActionResult DownloadImportedFile(string filePath, string fileName, string createdOn)
    {
        if (System.IO.File.Exists(filePath))
        {
            var fileBytes = System.IO.File.ReadAllBytes(filePath);
            var timestamp = Convert.ToDateTime(createdOn).ToString("MM_dd_yyyy_HHmm");
            var fullFileName = $"{fileName}_{timestamp}.xlsx"; // Ensure .xlsx extension

            return File(fileBytes, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fullFileName);
        }

        return NotFound("File not found.");
    }

    [HttpGet]
    public async Task<ActionResult> DownloadReport()
    {
        ViewBag.ReportTypes = GetReportTypeList();

        // Await directly without .Result
        List<ReportDownloadSts> result = await _importRepo.GetReportDownloadStslst();

        return View(result);
    }

    [HttpPost]
    public async Task<ActionResult> DownloadReport(string reportType)
    {
        ViewBag.ReportTypes = GetReportTypeList();

        if (string.IsNullOrEmpty(reportType))
        {
            ModelState.AddModelError("", "Report type is required.");
            List<ReportDownloadSts> existing = await _importRepo.GetReportDownloadStslst();
            return View(existing);
        }

        var reportTypes = ViewBag.ReportTypes as List<SelectListItem>;
        var selectedReport = reportTypes?.FirstOrDefault(c => c.Value == reportType);

        var reportDownloadSts = new ReportDownloadSts
        {
            ReportStatus = (int)CommonConst.FileStatusEnum.ImportInProgresss,
            CreatedOn = DateTime.Now,
            ReportName = selectedReport?.Text ?? "Unknown",
            ReportType = int.Parse(reportType)
        };

        await _importRepo.InsertReportDownloadSts(reportDownloadSts);

        List<ReportDownloadSts> result = await _importRepo.GetReportDownloadStslst();
        return View(result);
    }

    private List<SelectListItem> GetReportTypeList()
    {
        return new List<SelectListItem>
    {
        new SelectListItem { Text = "LIS Master", Value = "1" },
        new SelectListItem { Text = "Production Master", Value = "2" },
        new SelectListItem { Text = "Collection Report", Value = "3" },
        new SelectListItem { Text = "Excutive Summary", Value = "4" },
        new SelectListItem { Text = "Denial Report", Value = "5" }
    };
    }


    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<ActionResult> Download(int reportType, DateTime? fromDate, DateTime? toDate)
    {
        XLWorkbook wb = null;
        string filename = string.Empty;
        try
        {

            if (reportType == (int)CommonConst.DownloadReportType.LIS_Master)
            {
                var lisMaster = _reportRepository.GetLISMasterReport(fromDate, toDate);
                filename = $"LIS_Master_{DateTime.Now:ddMMyyyy}.xlsx";
                wb = await _excelWriter.GetReport(CommonConst.LISMaster_Template, null, lisMaster);
            }
            else if (reportType == (int)CommonConst.DownloadReportType.Production_Master)
            {
                var prodMaster = _reportRepository.GetProductionDataAsync(fromDate, toDate);
                var lineLevel = _reportRepository.GetProdLineLevelAsync(fromDate, toDate);
                filename = $"Prod_Master_{DateTime.Now:ddMMyyyy}.xlsx";

                wb = await _excelWriter.GetReport(
                    CommonConst.ProdMaster_Template,
                    null,
                    prodMaster,
                    1,
                    false,
                    null,
                    true,
                    lineLevel
                );
            }
            else if (reportType == (int)CommonConst.DownloadReportType.Collection_Report)
            {
                var collectionData = _reportRepository.GetCollectionDateByDateAsync(fromDate, toDate);
                filename = $"Collection_{DateTime.Now:ddMMyyyy}.xlsx";
                wb = await _excelWriter.GetReport(CommonConst.CollectionTemplate, null, collectionData);
            }

            if (wb == null)
                return BadRequest("Invalid report type or empty workbook.");

            using (var stream = new MemoryStream())
            {
                wb.SaveAs(stream); // will fail if wb is disposed
                stream.Position = 0;

                return File(stream.ToArray(),
                            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                            filename);
            }
        }
        catch (Exception ex)
        {
            _logger.Error("Download failed", ex);
            return StatusCode(500, "Internal server error");
        }
    }
}
