
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

public class LoginViewModel
{
    [Required(ErrorMessage = "Username is required")]
    public string Username { get; set; }

    [Required(ErrorMessage = "Password is required")]
    public string Password { get; set; }

    [Required(ErrorMessage = "Please select a lab")]
    public int SelectedLabId { get; set; }
}

public class LabOption
{
    public int Id { get; set; }               // e.g., 1
    public string Name { get; set; }          // e.g., "Prism"
    public string ConnectionKey { get; set; } // e.g., "PrismConnection"
}
