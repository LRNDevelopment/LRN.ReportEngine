
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

public class LoginViewModel
{
    [Required]
    public string Username { get; set; }

    [Required]
    [DataType(DataType.Password)]
    public string Password { get; set; }

    [Required]
    public string SelectedLab { get; set; }

    public List<SelectListItem> Labs { get; set; } = new();
}
