using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;
namespace ImportAuthMvcApp.Models;
public class User
{
    public int UserId { get; set; }
    [Required] public string Username { get; set; } = string.Empty;
    [Required] public string PasswordHash { get; set; } = string.Empty;
    [Required] public string PasswordSalt { get; set; } = string.Empty;
    public string Role { get; set; } = "User";
}

public class UserAccount
{
    public int UserId { get; set; }

    public string? Username { get; set; }

    public string? PasswordHash { get; set; }

    public int? LabId { get; set; }

    public string? UserRole { get; set; }

    public bool? IsActive { get; set; }

    public DateTime? LastLoggedIn { get; set; }

    public string? UserIdentity { get; set; }

    // Navigation property if you want EF Core relationship
    public virtual Lab? Lab { get; set; }
}

public class Lab
{
    public int LabId { get; set; }

    public string? LabName { get; set; }

    public string? ConnectionKey { get; set; }

    public bool? IsActive { get; set; }

    // Navigation property (one-to-many: Lab → Users)
    public virtual ICollection<User>? Users { get; set; }
}