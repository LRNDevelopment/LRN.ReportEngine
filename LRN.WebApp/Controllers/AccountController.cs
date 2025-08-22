using Dapper;
using ImportAuthMvcApp.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Org.BouncyCastle.Crypto.Generators;
using System.Security.Claims;
using Microsoft.AspNetCore.Mvc.Rendering;

public class AccountController : Controller
{
    private readonly IConfiguration _config;

    public AccountController(IConfiguration config)
    {
        _config = config;
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

        if (user == null || model.Password != user.PasswordHash)
        {
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

    private List<LabOption> GetAvailableLabs() => new()
    {
        new LabOption { Id = 3, Name = "Prism", ConnectionKey = "PrismConnection" },
        new LabOption { Id = 4, Name = "Cove",  ConnectionKey = "CoveConnection" }
    };

    public async Task<IActionResult> Logout()
    {
        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        return RedirectToAction(nameof(Login));
    }
}
