using System.ComponentModel.DataAnnotations;
// REMOVE this:
// using System.Web.Mvc;

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
    public int Id { get; set; }
    public string Name { get; set; }            // <-- ensure this exists
    public string ConnectionKey { get; set; }
}