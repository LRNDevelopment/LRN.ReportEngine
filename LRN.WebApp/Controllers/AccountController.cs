using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Threading.Tasks;
using System.Collections.Generic;

[AllowAnonymous]
public class AccountController : Controller
{
    [HttpGet]
    public IActionResult Login()
    {
        var model = new LoginViewModel();
        GetAvailableLabs();
        return View(model);
    }

    [HttpPost]
    public async Task<IActionResult> Login(LoginViewModel model)
    {
        if (!ModelState.IsValid)
        {
            GetAvailableLabs();
            return View(model);
        }

        // TODO: replace with your real auth
        if (model.Username == "admin" && model.Password == "admin" && !string.IsNullOrWhiteSpace(model.SelectedLab))
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, model.Username),
                new Claim("Lab", model.SelectedLab) // <-- store selected lab
            };

            var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var principal = new ClaimsPrincipal(identity);

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);
            return RedirectToAction("Index", "Upload");
        }

        ViewBag.Message = "Invalid credentials";
        GetAvailableLabs();
        return View(model);
    }

    [Authorize]
    public async Task<IActionResult> Logout()
    {
        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        return RedirectToAction(nameof(Login));
    }
    public void GetAvailableLabs()
    {
        // This method should return a list of labs available for selection.
        // For demonstration purposes, we will return a static list.
        // In a real application, this could be fetched from a database or configuration.
        // Example labs
        ViewBag.Labs = new List<SelectListItem>
        {
            new SelectListItem { Text = "Prism", Value = "1" },
            new SelectListItem { Text = "Cove", Value = "2" },
        };
    }
}
