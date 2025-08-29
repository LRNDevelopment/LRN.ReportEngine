using System.Security.Cryptography;
using System.Text;

public sealed class AesGcmService
{
    private readonly byte[] _key;
    private readonly string _keyId;

    public AesGcmService(IConfiguration config)
    {
        var b64 = config["Crypto:Key"] ?? throw new InvalidOperationException("Crypto:Key missing");
        _key = Convert.FromBase64String(b64);
        if (_key.Length != 32) throw new InvalidOperationException("Crypto key must be 32 bytes (Base64-encoded).");
        _keyId = config["Crypto:KeyId"] ?? "unknown";
    }

    // Encrypt returns "keyId:BASE64(nonce|tag|ciphertext)"
    public string Encrypt(string plaintext)
    {
        if (plaintext == null) return null;

        byte[] nonce = RandomNumberGenerator.GetBytes(12);   // 96-bit nonce
        byte[] pt = Encoding.UTF8.GetBytes(plaintext);
        byte[] ct = new byte[pt.Length];
        byte[] tag = new byte[16];                           // 128-bit tag

        using var aes = new AesGcm(_key);
        aes.Encrypt(nonce, pt, ct, tag); // (AAD optional; omit or add if you want)

        // Pack: nonce(12) | tag(16) | ct(n)
        byte[] blob = new byte[12 + 16 + ct.Length];
        Buffer.BlockCopy(nonce, 0, blob, 0, 12);
        Buffer.BlockCopy(tag,   0, blob, 12, 16);
        Buffer.BlockCopy(ct,    0, blob, 28, ct.Length);

        return $"{_keyId}:{Convert.ToBase64String(blob)}";
    }

    public string Decrypt(string packed)
    {
        if (string.IsNullOrWhiteSpace(packed)) return null;

        // format: keyId:BASE64(blob)
        int idx = packed.IndexOf(':');
        if (idx <= 0) throw new FormatException("Invalid encrypted payload format.");

        string keyId = packed[..idx];
        string b64 = packed[(idx + 1)..];

        // (Optional) check keyId if you support rotation.
        // if (keyId != _keyId) { load the old key by keyId here }

        byte[] blob = Convert.FromBase64String(b64);
        if (blob.Length < 28) throw new FormatException("Invalid encrypted payload length.");

        byte[] nonce = new byte[12];
        byte[] tag   = new byte[16];
        byte[] ct    = new byte[blob.Length - 28];

        Buffer.BlockCopy(blob, 0,  nonce, 0, 12);
        Buffer.BlockCopy(blob, 12, tag,   0, 16);
        Buffer.BlockCopy(blob, 28, ct,    0, ct.Length);

        byte[] pt = new byte[ct.Length];
        using var aes = new AesGcm(_key);
        aes.Decrypt(nonce, ct, tag, pt);

        return Encoding.UTF8.GetString(pt);
    }
}
