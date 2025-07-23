namespace LRN.WebApp.Services;
public static class PasswordHelper
{
    public static void CreatePasswordHash(string password, out string passwordHash, out string passwordSalt)
    {
        using var hmac = new System.Security.Cryptography.HMACSHA512();
        passwordSalt = Convert.ToBase64String(hmac.Key);
        passwordHash = Convert.ToBase64String(hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password)));
    }

    public static bool VerifyPasswordHash(string password, string storedHash, string storedSalt)
    {
        using var hmac = new System.Security.Cryptography.HMACSHA512(Convert.FromBase64String(storedSalt));
        var computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
        return Convert.ToBase64String(computedHash) == storedHash;
    }
}