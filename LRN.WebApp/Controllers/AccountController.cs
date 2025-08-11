using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Security.Claims;

public class AccountController : Controller
{
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

        // TODO: replace with your real auth
        if (model.Username == "admin" && model.Password == "admin")
        {
            // look up the selected lab by Id to get name + conn key
            var labs = GetAvailableLabs();
            var lab = labs.FirstOrDefault(x => x.Id == model.SelectedLabId);
            if (lab == null)
            {
                ModelState.AddModelError(nameof(model.SelectedLabId), "Invalid lab.");
                ViewBag.Labs = labs.Select(l => new SelectListItem { Value = l.Id.ToString(), Text = l.Name }).ToList();
                return View(model);
            }

            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, model.Username),

                // store all three as separate claims
                new Claim("LabId", lab.Id.ToString()),
                new Claim("LabName", lab.Name),
                new Claim("Lab", lab.ConnectionKey) // <— this is the one your Dapper/EF picks up
            };

            var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var principal = new ClaimsPrincipal(identity);

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);
            return RedirectToAction("Index", "Upload");
        }

        ViewBag.Labs = GetAvailableLabs()
            .Select(l => new SelectListItem { Value = l.Id.ToString(), Text = l.Name })
            .ToList();

        ViewBag.Message = "Invalid credentials";
        return View(model);
    }

    private List<LabOption> GetAvailableLabs() => new()
    {
        new LabOption { Id = 3, Name = "Prism", ConnectionKey = "PrismConnection" },
        new LabOption { Id = 4, Name = "Cove",  ConnectionKey = "CoveConnection"  }
    };

    public async Task<IActionResult> Logout()
    {
        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        return RedirectToAction(nameof(Login));
    }
}
