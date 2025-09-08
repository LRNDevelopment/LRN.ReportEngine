using BCrypt.Net;
using Dapper;
using ImportAuthMvcApp.Models;
using LRN.DataLibrary.Repository.Interfaces;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Org.BouncyCastle.Crypto.Generators;
using System.Security.Claims;

public class AccountController : Controller
{
    private readonly IConfiguration _config;
    private readonly AesGcmService _pswDecrypt;
    private readonly IImportFilesRepository _importRepo;
    public AccountController(IConfiguration config, AesGcmService pswDecrypt, IImportFilesRepository importrepo)
    {
        _config = config;
        _pswDecrypt = pswDecrypt;
        _importRepo = importrepo;
    }

    [HttpGet]
    public IActionResult Login()
    {
        ViewBag.Labs = GetAvailableLabs()
        .Select(l => new SelectListItem { Value = l.Id.ToString(), Text = l.Name })
        .ToList();

        return View(new LoginViewModel());
    }


    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Login(LoginViewModel model)
    {
        if (!ModelState.IsValid)
        {
            ViewBag.Labs = GetAvailableLabs()
      .Select(l => new SelectListItem { Value = l.Id.ToString(), Text = l.Name })
      .ToList();
            return View(model);
        }

        // 1. Check credentials in MASTER DB
        using var conn = new SqlConnection(_config.GetConnectionString("DefaultConnection"));
        var user = await conn.QueryFirstOrDefaultAsync<UserAccount>(
            "SELECT * FROM Users WHERE Username=@Username",
            new { model.Username });

        if (user == null || model.Password != _pswDecrypt.Decrypt(user.PasswordHash))
        {
            ViewBag.Labs = GetAvailableLabs().Select(l => new SelectListItem { Value = l.Id.ToString(), Text = l.Name }).ToList();
            ModelState.AddModelError("", "Invalid login.");
            return View(model);
        }

        // 2. Lookup Lab
        var lab = GetAvailableLabs().FirstOrDefault(x => x.Id == model.SelectedLabId);
        if (lab == null)
        {
            ModelState.AddModelError(nameof(model.SelectedLabId), "Invalid lab.");
            ViewBag.Labs = GetAvailableLabs().Select(l => new SelectListItem { Value = l.Id.ToString(), Text = l.Name }).ToList();
            return View(model);
        }

        if (lab.Id != user.LabId)
        {
            ViewBag.Labs = GetAvailableLabs().Select(l => new SelectListItem { Value = l.Id.ToString(), Text = l.Name }).ToList();
            ModelState.AddModelError(nameof(model.SelectedLabId), "Invalid lab.");
            return View(model);
        }
        // 3. Build claims (cookie stores lab info)
        var claims = new List<Claim>
        {
            new Claim(ClaimTypes.Name, user.Username),
            new Claim(ClaimTypes.Role, user.UserRole),
            new Claim("LabId", lab.Id.ToString()),
            new Claim("LabName", lab.Name),
            new Claim("Lab", lab.ConnectionKey) // << used for DB switching
        };

        var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
        var principal = new ClaimsPrincipal(identity);

        await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);
        return RedirectToAction("Index", "Upload");
    }

    private List<LabOption> GetAvailableLabs()
    {
        var lab = new List<LabOption>();
        var result = _importRepo.GetLabMaster();
        foreach (var item in result.Result)
        {
            lab.Add(new LabOption { Id = item.LabId, Name = item.LabName, ConnectionKey = item.ConnectionKey });
        }
        return lab;
    }

    public async Task<IActionResult> Logout()
    {
        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        return RedirectToAction(nameof(Login));
    }
}
