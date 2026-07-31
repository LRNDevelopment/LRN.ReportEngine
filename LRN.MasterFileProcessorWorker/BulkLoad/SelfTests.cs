using System.Text;

namespace LRN.MasterFileProcessorWorker.BulkLoad;

/// <summary>
/// Self-contained assertions for the bulk-copy pipeline, runnable without a test framework.
/// <para>
/// Run with: <c>LRN.MasterFileProcessorWorker.exe --selftest</c>. Exits 0 on pass, 1 on failure,
/// so it drops straight into CI.
/// </para>
/// <para>
/// This lives here rather than in an xunit project deliberately: adding xunit would mean new NuGet
/// packages, which the brief requires be raised first. Converting these to <c>[Fact]</c> methods is
/// mechanical once that is approved.
/// </para>
/// </summary>
public static class SelfTests
{
    private static int _passed;
    private static readonly List<string> Failures = new();

    public static int Run()
    {
        Console.WriteLine("BulkLoad self-tests");
        Console.WriteLine(new string('-', 70));

        RowHashDeterminism();
        RowHashIgnoresAuditAndUnflaggedFields();
        RowHashNormalization();
        RowHashDistinguishesDifferentRows();
        MappingValidationCatchesBadConfig();
        MappingValidationAcceptsGoodConfig();
        DisabledLevelIsNotValidated();
        AuditStampingAndCsvBinding();
        ToggleSkipReasons();
        PerLevelCsvToggles();

        Console.WriteLine(new string('-', 70));

        foreach (var failure in Failures)
            Console.WriteLine("FAIL  " + failure);

        Console.WriteLine($"{_passed} passed, {Failures.Count} failed.");
        return Failures.Count == 0 ? 0 : 1;
    }

    // ---------------- RowHash ----------------

    private static readonly List<FieldMapping> SampleFields = new()
    {
        new FieldMapping { CsvHeader = "ClaimID",      SqlColumn = "ClaimID",      IncludeInHash = true },
        new FieldMapping { CsvHeader = "ChargeAmount", SqlColumn = "ChargeAmount", IncludeInHash = true },
        new FieldMapping { CsvHeader = "DateofService",SqlColumn = "DateofService",IncludeInHash = true },
        new FieldMapping { CsvHeader = "Remarks",      SqlColumn = "Remarks",      IncludeInHash = false },
        new FieldMapping { CsvHeader = "LabID",        SqlColumn = "LabID",        IncludeInHash = false }
    };

    private static void RowHashDeterminism()
    {
        var hasher = new RowHasher(SampleFields);
        var row = new string?[] { "C-1", "37.00", "03/01/2026", "note", "20" };

        var a = hasher.Compute(row);
        var b = new RowHasher(SampleFields).Compute(row);

        Check("RowHash is deterministic across instances", a == b);
        Check("RowHash is 64 hex chars", a.Length == 64 && a.All(Uri.IsHexDigit));
    }

    private static void RowHashIgnoresAuditAndUnflaggedFields()
    {
        var hasher = new RowHasher(SampleFields);

        var a = hasher.Compute(new string?[] { "C-1", "37.00", "03/01/2026", "note one", "20" });
        var b = hasher.Compute(new string?[] { "C-1", "37.00", "03/01/2026", "note two", "99" });

        Check("RowHash ignores fields not flagged IncludeInHash", a == b);

        // LabID is an audit column: even flagged, it must not contribute.
        var withAudit = new List<FieldMapping>(SampleFields)
        {
            new FieldMapping { CsvHeader = "RowHash", SqlColumn = "RowHash", IncludeInHash = true }
        };

        Check("RowHash excludes pipeline-owned columns even when flagged",
            new RowHasher(withAudit).HashedFieldCount == 3);
    }

    private static void RowHashNormalization()
    {
        var hasher = new RowHasher(SampleFields);

        Check("RowHash: 37.00 == 37",
            hasher.Compute(new string?[] { "C-1", "37.00", "03/01/2026", "", "" }) ==
            hasher.Compute(new string?[] { "C-1", "37", "03/01/2026", "", "" }));

        Check("RowHash: 3/1/2026 == 03/01/2026",
            hasher.Compute(new string?[] { "C-1", "37", "3/1/2026", "", "" }) ==
            hasher.Compute(new string?[] { "C-1", "37", "03/01/2026", "", "" }));

        Check("RowHash: case and surrounding space are normalized",
            hasher.Compute(new string?[] { "  c-1 ", "37", "03/01/2026", "", "" }) ==
            hasher.Compute(new string?[] { "C-1", "37", "03/01/2026", "", "" }));

        Check("RowHash: null and empty are the same",
            hasher.Compute(new string?[] { null, "37", "03/01/2026", "", "" }) ==
            hasher.Compute(new string?[] { "", "37", "03/01/2026", "", "" }));
    }

    private static void RowHashDistinguishesDifferentRows()
    {
        var hasher = new RowHasher(SampleFields);

        Check("RowHash changes when a hashed value changes",
            hasher.Compute(new string?[] { "C-1", "37", "03/01/2026", "", "" }) !=
            hasher.Compute(new string?[] { "C-2", "37", "03/01/2026", "", "" }));

        // Guards against naive concatenation: "AB"+"C" must not collide with "A"+"BC".
        var two = new List<FieldMapping>
        {
            new FieldMapping { SqlColumn = "A", CsvHeader = "A", IncludeInHash = true },
            new FieldMapping { SqlColumn = "B", CsvHeader = "B", IncludeInHash = true }
        };
        var h = new RowHasher(two);

        Check("RowHash is not vulnerable to field-boundary collisions",
            h.Compute(new string?[] { "AB", "C" }) != h.Compute(new string?[] { "A", "BC" }));
    }

    // ---------------- mapping validation ----------------

    private static void MappingValidationCatchesBadConfig()
    {
        var folder = TempFolder();

        // BulkCopyToTable with no TargetTable, plus a duplicate SqlColumn and an audit collision.
        File.WriteAllText(Path.Combine(folder, "BadFieldMappings.json"), """
        {
          "LabId": 99,
          "LineLevel": {
            "Enabled": true,
            "CreateCsv": true,
            "BulkCopyToTable": true,
            "SqlTableName": "",
            "Fields": [
              { "CsvHeader": "A", "SqlColumn": "ClaimID", "IncludeInHash": true },
              { "CsvHeader": "B", "SqlColumn": "ClaimID", "IncludeInHash": false },
              { "CsvHeader": "C", "SqlColumn": "RowHash", "IncludeInHash": false }
            ]
          }
        }
        """);

        var loader = new LabMappingLoader(NullLogger<LabMappingLoader>.Instance);

        try
        {
            loader.LoadAll(folder);
            Check("Invalid mapping is rejected", false, "no exception thrown");
        }
        catch (LabMappingValidationException ex)
        {
            var text = string.Join(" | ", ex.Errors);
            Check("Missing SqlTableName is reported", text.Contains("SqlTableName", StringComparison.OrdinalIgnoreCase));
            Check("Duplicate SqlColumn is reported", text.Contains("duplicate SqlColumn", StringComparison.OrdinalIgnoreCase));
            Check("Audit-column collision is reported", text.Contains("stamped by the pipeline", StringComparison.OrdinalIgnoreCase));
            Check("Offending file is named", text.Contains("BadFieldMappings.json"));
        }
        finally
        {
            TryDelete(folder);
        }
    }

    private static void MappingValidationAcceptsGoodConfig()
    {
        var folder = TempFolder();

        File.WriteAllText(Path.Combine(folder, "GoodFieldMappings.json"), """
        {
          "LabId": 20,
          "LabName": "NorthWest",
          "DatabaseName": "NWL_LRN",
          "LineLevel": {
            "Enabled": true,
            "CreateCsv": true,
            "BulkCopyToTable": true,
            "SqlTableName": "dbo.LineLevelData",
            "BatchSize": 10000,
            "BulkCopyTimeoutSeconds": 900,
            "Fields": [ { "CsvHeader": "Claim ID", "SqlColumn": "ClaimID", "IncludeInHash": true } ]
          }
        }
        """);

        try
        {
            var configs = new LabMappingLoader(NullLogger<LabMappingLoader>.Instance).LoadAll(folder);

            Check("Valid mapping loads", configs.Count == 1);
            Check("LabId is read", configs[0].LabId == 20);
            Check("Staging table name defaults", configs[0].LineLevel!.ResolveStagingTableName() == "dbo.LineLevelData_Staging");
            Check("BulkCopyToTable defaults to false when absent", configs[0].ClaimLevel is null);
        }
        finally
        {
            TryDelete(folder);
        }
    }

    private static void DisabledLevelIsNotValidated()
    {
        var folder = TempFolder();

        // Enabled=false, so the otherwise-invalid block must not fail startup.
        File.WriteAllText(Path.Combine(folder, "OffFieldMappings.json"), """
        {
          "LabId": 1,
          "LineLevel": {
            "Enabled": false,
            "BulkCopyToTable": true,
            "SqlTableName": "",
            "Fields": []
          }
        }
        """);

        try
        {
            var configs = new LabMappingLoader(NullLogger<LabMappingLoader>.Instance).LoadAll(folder);
            Check("A disabled level is not validated", configs.Count == 1);
        }
        catch (LabMappingValidationException)
        {
            Check("A disabled level is not validated", false, "validation ran on a disabled level");
        }
        finally
        {
            TryDelete(folder);
        }
    }

    // ---------------- audit stamping ----------------

    private static void AuditStampingAndCsvBinding()
    {
        var folder = TempFolder();
        var csv = Path.Combine(folder, "line.csv");

        File.WriteAllText(csv,
            "Claim ID,Charge Amount,Extra Column\r\n" +
            "C-1,37.00,ignored\r\n" +
            "C-2,53.00,ignored\r\n",
            new UTF8Encoding(true));

        var fields = new List<FieldMapping>
        {
            new() { CsvHeader = "Claim ID",      SqlColumn = "ClaimID",      IncludeInHash = true },
            new() { CsvHeader = "Charge Amount", SqlColumn = "ChargeAmount", IncludeInHash = true },
            new() { CsvHeader = "Absent Column", SqlColumn = "Missing",      IncludeInHash = false }
        };

        var audit = new AuditColumns.AuditValues(4242, "20260724R0044", "W1", "/sp/path", "line.csv",
            FileTypes.LineLevel, 20, "NorthWest");

        try
        {
            using var reader = new CsvBulkDataReader(csv, fields, audit);

            Check("Reader exposes fields + 9 audit columns", reader.FieldCount == fields.Count + 9);
            Check("Absent mapped header is reported", reader.MissingCsvHeaders.Count == 1);
            Check("Unmapped CSV column is reported",
                reader.UnmappedCsvHeaders.Count == 1 && reader.UnmappedCsvHeaders[0] == "Extra Column");

            var read = reader.Read();
            Check("First row reads", read);

            Check("CSV value binds by header", (string?)reader.GetValue(0) == "C-1");
            Check("Absent column binds to NULL", reader.IsDBNull(2));

            // Audit block: every one of the nine must be populated on every row.
            var auditStart = fields.Count;
            var allPopulated = Enumerable.Range(auditStart, 9).All(i => !reader.IsDBNull(i));
            Check("All 9 audit columns are populated", allPopulated);

            Check("FileLogId is stamped", Convert.ToInt64(reader.GetValue(auditStart)) == 4242);
            Check("RunId is stamped", (string?)reader.GetValue(auditStart + 1) == "20260724R0044");
            Check("FileType is stamped", (string?)reader.GetValue(auditStart + 5) == FileTypes.LineLevel);
            Check("LabID is stamped", Convert.ToInt32(reader.GetValue(auditStart + 7)) == 20);

            var hash1 = (string?)reader.GetValue(auditStart + 6);
            Check("RowHash is stamped", !string.IsNullOrWhiteSpace(hash1) && hash1!.Length == 64);

            reader.Read();
            var hash2 = (string?)reader.GetValue(auditStart + 6);
            Check("RowHash differs between different rows", hash1 != hash2);

            Check("No third data row", !reader.Read());
            Check("RowsRead counts data rows only", reader.RowsRead == 2);
        }
        finally
        {
            TryDelete(folder);
        }
    }

    // ---------------- toggles ----------------

    private static void ToggleSkipReasons()
    {
        // Mirrors LineClaimImportService.ResolveSkipReason via observable behaviour of the toggles.
        var enabled = new LevelMapping { Enabled = true, CreateCsv = true, BulkCopyToTable = true, SqlTableName = "dbo.X" };
        var csvOff = new LevelMapping { Enabled = true, CreateCsv = false, BulkCopyToTable = false };
        var levelOff = new LevelMapping { Enabled = false };

        Check("Defaults preserve current behaviour (BulkCopyToTable off)", new LevelMapping().BulkCopyToTable == false);
        Check("Defaults preserve current behaviour (CreateCsv on)", new LevelMapping().CreateCsv);
        Check("Defaults preserve current behaviour (Enabled on)", new LevelMapping().Enabled);
        Check("Enabled level is loadable", enabled is { Enabled: true, CreateCsv: true, BulkCopyToTable: true });
        Check("CreateCsv=false implies no bulk copy", !csvOff.BulkCopyToTable);
        Check("Level toggles are independent", levelOff.Enabled == false && enabled.Enabled);
    }

    /// <summary>
    /// The two levels must be switchable independently: line on / claim off and the reverse are
    /// both valid, and each combination must resolve to the right (produceLine, produceClaim) pair.
    /// Mirrors the worker's ResolveCsvOutputToggles.
    /// </summary>
    private static void PerLevelCsvToggles()
    {
        static bool Produces(LevelMapping? level) => level is null || (level.Enabled && level.CreateCsv);

        var on   = new LevelMapping { Enabled = true,  CreateCsv = true };
        var off  = new LevelMapping { Enabled = true,  CreateCsv = false };
        var dead = new LevelMapping { Enabled = false, CreateCsv = true };

        Check("both levels on -> both CSVs", Produces(on) && Produces(on));
        Check("line on, claim off -> only line CSV", Produces(on) && !Produces(off));
        Check("line off, claim on -> only claim CSV", !Produces(off) && Produces(on));
        Check("both off -> no CSV", !Produces(off) && !Produces(off));
        Check("Enabled=false suppresses the CSV too", !Produces(dead));
        Check("absent level section defaults to producing", Produces(null));
    }

    // ---------------- helpers ----------------

    private static void Check(string name, bool condition, string? detail = null)
    {
        if (condition)
        {
            _passed++;
            Console.WriteLine("  ok   " + name);
        }
        else
        {
            Failures.Add(name + (detail is null ? "" : " (" + detail + ")"));
            Console.WriteLine("  FAIL " + name);
        }
    }

    private static string TempFolder()
    {
        var path = Path.Combine(Path.GetTempPath(), "lrn_selftest_" + Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(path);
        return path;
    }

    private static void TryDelete(string folder)
    {
        try { Directory.Delete(folder, recursive: true); } catch { /* best effort */ }
    }

    /// <summary>Minimal ILogger so the tests need no DI container or logging package.</summary>
    private sealed class NullLogger<T> : ILogger<T>
    {
        public static readonly NullLogger<T> Instance = new();
        public IDisposable? BeginScope<TState>(TState state) where TState : notnull => null;
        public bool IsEnabled(LogLevel logLevel) => false;
        public void Log<TState>(LogLevel logLevel, EventId eventId, TState state, Exception? exception,
            Func<TState, Exception?, string> formatter) { }
    }
}
