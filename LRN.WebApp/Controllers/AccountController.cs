
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Security.Claims;

[AllowAnonymous]
public class AccountController : Controller
{
    public IActionResult Login() => View();

    [HttpPost]
    public IActionResult Login(LoginViewModel model)
    {
        if (model.Username == "admin" && model.Password == "admin")
        {
            var claims = new List<Claim> {
                new Claim(ClaimTypes.Name, model.Username)
            };
            var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(identity));
            return RedirectToAction("Index", "Upload");
        }
        ViewBag.Message = "Invalid credentials";
        return View();
    }

    public IActionResult Logout()
    {
        HttpContext.SignOutAsync();
        return RedirectToAction("Login");
    }
}
