using ClosedXML.Excel;
using Common.Logging;
using DocumentFormat.OpenXml.Spreadsheet;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelGenerator;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.DtoModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.StaticFiles;
using Org.BouncyCastle.Math;
using System.Data;
using System.Net;
using System.Text.RegularExpressions;

[Authorize]
[RequestSizeLimit(72428800)]
public class UploadController : Controller
{
    private readonly ILoggerService _logger;
    private readonly IConfiguration _config;
    private readonly IImportFilesRepository _importRepo;
    private readonly ILookUpRepository _lookupRepo;
    //private readonly IExcelWriter _excelWriter;
    //private readonly IReportRepository _reportRepository;
    private readonly IWebHostEnvironment _environment;

    public UploadController(
        ILoggerService logger,
        IConfiguration config,
        IImportFilesRepository importRepo,
        ILookUpRepository lookupRepo,
        //IExcelWriter excelWriter,
        //IReportRepository reportRepository,
        IWebHostEnvironment environment)
    {
        _logger = logger;
        _config = config;
        _importRepo = importRepo;
        _lookupRepo = lookupRepo;
        //_excelWriter = excelWriter;
        //_reportRepository = reportRepository;
        _environment = environment;
    }

    public async Task<IActionResult> Index(int page = 1, int pageSize = 10)
    {
        var result = await _importRepo.GetImportFilesAsync();
        var files = new List<FileUpload>();
        ViewBag.LabName = User.FindFirst("LabName")?.Value ?? "";

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
        int totalReports = files.Count;
        ViewBag.CurrentPage = page;
        ViewBag.TotalPages = (int)Math.Ceiling((double)totalReports / pageSize);
        var pagedReports = files
            .OrderByDescending(r => r.ImportedOn)
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToList();
        return View(pagedReports);
    }

    [RequestSizeLimit(524288000)] // 500 MB
    [RequestFormLimits(MultipartBodyLengthLimit = 524288000)]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> UploadFile(IFormFile file, string fileType)
    {
        try
        {
            ViewBag.LabName = User.FindFirst("LabName")?.Value ?? "";
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
                int? labId = null;
                var labIdClaim = User.FindFirst("LabId")?.Value;

                if (int.TryParse(labIdClaim, out var parsedLabId))
                {
                    labId = parsedLabId;
                }
                var fileDto = new ImportFileDto
                {
                    ImportFileName = Path.GetFileName(file.FileName),
                    FileType = int.Parse(fileType),
                    FileStatus = (int)CommonConst.FileStatusEnum.ImportQueued,
                    ImportFilePath = filePath,
                    ImportedOn = DateTime.Now,
                    LabId = (int)(labId)
                };

                await _importRepo.AddImportFileAync(fileDto);
                TempData["UploadSuccess"] = "true";

                _logger.Info($"File uploaded: {file.FileName}, Lab: {labIdClaim}, Type: {fileType}");
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
        var file = _importRepo.GetImportFileById(fileId).Result;

        var fileName = "ImportFileLog_" + Path.GetFileNameWithoutExtension(file.ImportFileName);
        var formattedLogs = logs.Select(log =>
            $"{log.LogType}  :  {log.LogMessage} : {log.RowNo} : {log.ColumnName} :: {log.CreatedOn:yyyy-MM-dd HH:mm:ss}");

        var logText = string.Join(Environment.NewLine, formattedLogs);
        var bytes = System.Text.Encoding.UTF8.GetBytes(logText);

        return File(bytes, "text/plain", $"{fileName}.txt");
    }

    [HttpGet]
    public async Task<IActionResult> DownloadImportedFile(int fileId)
    {
        var file = await _importRepo.GetImportFileById(fileId);
        if (file == null || string.IsNullOrWhiteSpace(file.ImportFilePath) || !System.IO.File.Exists(file.ImportFilePath))
            return NotFound("File not found.");

        // Stream instead of reading entire file into memory
        var stream = System.IO.File.OpenRead(file.ImportFilePath);

        // 1) Make a safe filename
        var rawName = (file.ImportFileName ?? Path.GetFileNameWithoutExtension(file.ImportFilePath)).Trim();
        var ext = Path.GetExtension(file.ImportFilePath); // trust the real file’s extension
        if (string.IsNullOrWhiteSpace(ext)) ext = ".xlsx";

        // remove any trailing extension already present (case-insensitive)
        if (rawName.EndsWith(ext, StringComparison.OrdinalIgnoreCase))
            rawName = rawName.Substring(0, rawName.Length - ext.Length);

        // remove illegal filename chars and extra spaces
        var safeBase = Regex.Replace(rawName, @"[^\w\-. ]+", "").Trim();
        if (string.IsNullOrWhiteSpace(safeBase)) safeBase = "download";

        var downloadName = safeBase + ext;

        // 2) Correct content type
        var provider = new FileExtensionContentTypeProvider();
        if (!provider.TryGetContentType(downloadName, out var contentType))
            contentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

        // 3) Robust Content-Disposition (RFC 5987) to avoid odd filename behavior
        Response.Headers["Content-Disposition"] =
            "attachment; filename=\"" + downloadName.Replace("\"", "") + "\"; filename*=UTF-8''" +
            Uri.EscapeDataString(downloadName);

        Response.Headers["X-Content-Type-Options"] = "nosniff";

        return File(stream, contentType);
    }
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DownloadReportFile(int fileId)
    {
        string labName = User.FindFirst("LabName").Value.ToString();
        var file = await _importRepo.GetDownloadReportById(fileId);
        if (file == null || string.IsNullOrWhiteSpace(file.ReportServerPath) || !System.IO.File.Exists(file.ReportServerPath))
            return NotFound("File not found.");

        // Open stream instead of loading full file
        var stream = System.IO.File.OpenRead(file.ReportServerPath);

        // 1) Build safe filename
        var baseName = $"{labName}_{file.ReportName}_{file.CreatedOn:MMddyyyy_HHmm}";
        var ext = Path.GetExtension(file.ReportServerPath);
        if (string.IsNullOrWhiteSpace(ext)) ext = ".xlsx";
        baseName = baseName.Replace(' ', '_');
        // Strip duplicate extension if already present
        if (baseName.EndsWith(ext, StringComparison.OrdinalIgnoreCase))
            baseName = baseName.Substring(0, baseName.Length - ext.Length);

        // Remove illegal characters
        var safeBase = Regex.Replace(baseName, @"[^\w\-. ]+", "").Trim();
        if (string.IsNullOrWhiteSpace(safeBase)) safeBase = "report";

        var downloadName = safeBase + ext;

        // 2) Resolve correct MIME type
        var provider = new FileExtensionContentTypeProvider();
        if (!provider.TryGetContentType(downloadName, out var contentType))
            contentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

        // 3) Force secure Content-Disposition
        Response.Headers["Content-Disposition"] =
            "attachment; filename=\"" + labName + "_" + downloadName.Replace("\"", "") + "\"; filename*=UTF-8''" +
            Uri.EscapeDataString(downloadName);

        Response.Headers["X-Content-Type-Options"] = "nosniff";

        return File(stream, contentType);
    }

    [HttpGet]
    public async Task<ActionResult> DownloadReport(int page = 1, int pageSize = 10)
    {
        ViewBag.ReportTypes = GetReportTypeList();
        ViewBag.LabName = User.FindFirst("LabName")?.Value ?? "";
        var allReports = await _importRepo.GetReportDownloadStslst();
        int totalReports = allReports.Count;
        var pagedReports = allReports
            .OrderByDescending(r => r.CreatedOn)
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToList();

        ViewBag.CurrentPage = page;
        ViewBag.TotalPages = (int)Math.Ceiling((double)totalReports / pageSize);

        ////// preserve TempData so it survives redirect and is available in JS
        ////TempData.Keep("SwalMessage");
        ////TempData.Keep("SwalIcon");
        return View(pagedReports);
    }

    public async Task<FileResult> DownloadReportLog(int fileId)
    {
        var file = _importRepo.GetDownloadReportById(fileId).Result;

        var fileName = "Report_Log_" + Path.GetFileNameWithoutExtension(file.ReportName);
        var formattedLogs = file.LogString;

        var logText = string.Join(Environment.NewLine, formattedLogs);
        var bytes = System.Text.Encoding.UTF8.GetBytes(logText);

        return File(bytes, "text/plain", $"{fileName}.txt");
    }

    [HttpPost]
    public async Task<ActionResult> DownloadReport(string reportType)
    {
        ViewBag.ReportTypes = GetReportTypeList();
        List<ReportDownloadSts> existing = await _importRepo.GetReportDownloadStslst();

        if (string.IsNullOrEmpty(reportType))
        {
            TempData["SwalMessage"] = "Please select a report type before proceeding.";
            TempData["SwalIcon"] = "error";
            return RedirectToAction("DownloadReport", new { page = 1 });
        }

        var reportTypes = ViewBag.ReportTypes as List<SelectListItem>;
        var selectedReport = reportTypes?.FirstOrDefault(c => c.Value == reportType);

        // Check if a report of this type is already in progress
        bool reportAlreadyInProgress = existing.Any(c =>
            c.ReportType == int.Parse(reportType) &&
            (c.ReportStatus == (int)CommonConst.FileStatusEnum.ImportQueued || c.ReportStatus == (int)CommonConst.FileStatusEnum.ImportInProgresss));

        if (!reportAlreadyInProgress)
        {
            var reportDownloadSts = new ReportDownloadSts
            {
                ReportStatus = (int)CommonConst.FileStatusEnum.ImportQueued,
                CreatedOn = DateTime.Now,
                ReportName = selectedReport?.Text ?? "Unknown Report",
                ReportType = int.Parse(reportType)
            };

            await _importRepo.InsertReportDownloadSts(reportDownloadSts);

            TempData["SwalMessage"] = $"{reportDownloadSts.ReportName} report request has been queued successfully.";
            TempData["SwalIcon"] = "success";
            return RedirectToAction("DownloadReport", new { page = 1 });
        }
        else
        {
            TempData["SwalMessage"] = $"A {selectedReport?.Text} is already inprogress. Please wait until it is completed before requesting again.";
            TempData["SwalIcon"] = "warning";
            return RedirectToAction("DownloadReport", new { page = 1 });
        }
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

            //if (reportType == (int)CommonConst.DownloadReportType.LIS_Master)
            //{
            //    var lisMaster = _reportRepository.GetLISMasterReport(fromDate, toDate);
            //    filename = $"LIS_Master_{DateTime.Now:ddMMyyyy}.xlsx";
            //    wb = await _excelWriter.GetReport(CommonConst.LISMaster_Template, null, lisMaster);
            //}
            //else if (reportType == (int)CommonConst.DownloadReportType.Production_Master)
            //{
            //    var prodMaster = _reportRepository.GetProductionDataAsync(fromDate, toDate);
            //    var lineLevel = _reportRepository.GetProdLineLevelAsync(fromDate, toDate);
            //    filename = $"Prod_Master_{DateTime.Now:ddMMyyyy}.xlsx";

            //    wb = await _excelWriter.GetReport(
            //        CommonConst.ProdMaster_Template,
            //        null,
            //        prodMaster,
            //        1,
            //        false,
            //        null,
            //        true,
            //        lineLevel
            //    );
            //}
            //else if (reportType == (int)CommonConst.DownloadReportType.Collection_Report)
            //{
            //    var collectionData = _reportRepository.GetCollectionDateByDateAsync(fromDate, toDate);
            //    filename = $"Collection_{DateTime.Now:ddMMyyyy}.xlsx";
            //    wb = await _excelWriter.GetReport(CommonConst.CollectionTemplate, null, collectionData);
            //}

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

    [HttpGet]
    public IActionResult DownloadTemplate(string fileType)
    {
        if (string.IsNullOrWhiteSpace(fileType))
        {
            return BadRequest("File type is required.");
        }

        // Parse fileType string to int
        if (!int.TryParse(fileType, out int fileTypeId))
        {
            return BadRequest("Invalid file type.");
        }

        string fileName = null;
        string labname = User.FindFirst("LabName")?.Value ?? "DefaultLab"; // Get lab name from claims
        switch (fileTypeId)
        {
            case (int)CommonConst.ImportFileType.LIS_Report:
                if (labname == "Prism")
                    fileName = "LIS.xlsx";
                else if (labname == "Cove")
                    fileName = "Cove_LIMS.xlsx";
                break;

            case (int)CommonConst.ImportFileType.Custom_Collection:
            case (int)CommonConst.ImportFileType.DTR_CCW:
                fileName = "Custom_Collection.xlsx";
                break;

            case (int)CommonConst.ImportFileType.Visit_Against_Accession:
                fileName = "Prism Submitted Visit to Accession Report.xlsx";
                break;

            case (int)CommonConst.ImportFileType.Transaction_Detail_Report:
                fileName = "TransactionDetail.xlsx";
                break;

            case (int)CommonConst.ImportFileType.Denial_Tracking_Report:
            case (int)CommonConst.ImportFileType.DTR_Denail_Tracking:
                fileName = "DenialTrackingDetail.xlsx";
                break;

            case (int)CommonConst.ImportFileType.Prism_Billing_Sheet:
                fileName = "Prism Billing.xlsx";
                break;
            case (int)CommonConst.ImportFileType.Accession_Payment_Report:
                fileName = "AccessionPaymentReports_Template.xlsx";
                break;
            case (int)CommonConst.ImportFileType.Panel_Group:
                fileName = "PanelMaster.xlsx";
                break;
            case (int)CommonConst.ImportFileType.Diagnos_SampleLIS:
                fileName = "LIS_Sample_Report.xlsx";
                break;
            case (int)CommonConst.ImportFileType.Order_LIS:
                fileName = "LIS_Order_Report.xlsx";
                break;
            case (int)CommonConst.ImportFileType.Client_Billing_Sheet:
                fileName = "Prism - Client Bill Sheet.xlsx";
                break;
            case (int)CommonConst.ImportFileType.InHealthDTR_LIS_Master:
                fileName = "LIS_Order_Report.xlsx";
                break;
        }

        if (string.IsNullOrEmpty(fileName))
        {
            return NotFound("Unsupported file type.");
        }

        var templatesFolder = Path.Combine(_environment.WebRootPath, "ImportTemplate");
        var fullPath = Path.Combine(templatesFolder, fileName);

        if (!System.IO.File.Exists(fullPath))
        {
            return NotFound("Template not found for the selected file type.");
        }

        var contentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        return PhysicalFile(fullPath, contentType, fileName);
    }

}
