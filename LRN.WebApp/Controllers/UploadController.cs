using Common.Logging;
using LRN.DataLibrary.Repository.Interfaces;
using LRN.ExcelToSqlETL.Core.Constants;
using LRN.ExcelToSqlETL.Core.DtoModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.IO;
using System.ServiceProcess;
using System.Threading.Tasks;

[Authorize]
public class UploadController : Controller
{
    private readonly ILoggerService _logger;
    private readonly IConfiguration _config;
    private readonly IImportFilesRepository _importRepo;
    private readonly ILookUpRepository _lookupRepo;

    public UploadController(
       ILoggerService logger,
       IConfiguration config,
       IImportFilesRepository importRepo,
       ILookUpRepository lookupRepo)
    {
        _logger = logger;
        _config = config;
        _importRepo = importRepo;
        _lookupRepo = lookupRepo;
    }

    public async Task<IActionResult> Index()
    {
        var result = await _importRepo.GetImportFilesAsync();
        var files = new List<FileUpload>();

        // Labs dropdown
        ViewBag.Labs = new List<SelectListItem>
        {
            new SelectListItem { Text = "Prism", Value = "3" }
        };

        // FileTypes dropdown
        var importfile = await _lookupRepo.GetImportFileTypesAsync(); // Make sure GetImportFileTypes() is async

        ViewBag.FileTypes = importfile.Select(l => new SelectListItem
        {
            Text = l.FileTypeName,
            Value = l.FileTypeId.ToString()
        }).ToList();

        // Build FileUpload view model list
        foreach (var file in result)
        {
            files.Add(new FileUpload
            {
                FileType = file.FileType,
                ProcessedOn = file.ProcessedOn,
                ImportedOn = file.ImportedOn,
                ImportedRowCount = file.ImportedRowCount,
                ExcelRowCount = file.ExcelRowCount,
                FileStatus = file.FileStatus,
                FileStatusName = file.FileStatusName,
                FileTypeName = file.FileTypeName,
                ImportFileName = file.ImportFileName
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

                ImportFileDto fileDto = new ImportFileDto
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

            _logger.Error($"An error occurred while uploading the file: {ex.Message}");
        }

        return RedirectToAction("Index");
    }


}
