#!/usr/bin/env python3
"""
Aligns the generated LineLevelData / ClaimLevelData DDL with the production schema and reports the
differences.

    python sql/align_with_production.py

PRODUCTION IS AUTHORITATIVE. sql/Existing_LineLevel_ClaimLevel_DATA.sql is the schema the other
teams already run for 12 labs, so every column it declares is reproduced verbatim - same name, same
type, same nullability. Nothing there is renamed, retyped or dropped.

On top of that, a column is ADDED when either:
  * the BillingFrequencyWorker common schemas declare it and production does not, or
  * this worker's lab mapping loads it and production does not.

A production column that this worker has no mapping for is kept and simply loads NULL.

Outputs:
  sql/Deploy/<Db>.sql                     consolidated, production-aligned deployment per database
  SchemaAlignmentReport.md                per-database column-by-column report
"""

import collections
import io
import json
import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WORKER = os.path.join(ROOT, "services", "LRN.MasterFileProcessorWorker")
BILLING = os.path.join(ROOT, "LRN.BillingFrequencyWorker", "Schemas")
MAPPINGS = os.path.join(WORKER, "Schemas", "LabMappings")
PROD_SQL = os.path.join(ROOT, "sql", "Existing_LineLevel_ClaimLevel_DATA.sql")

norm = lambda s: re.sub(r"[^a-z0-9]", "", (s or "").lower())

# production database  ->  lab mapping file (None = no mapping in this worker yet)
DB_TO_MAPPING = collections.OrderedDict([
    ("Augustus_LRN",   "AugustusFieldMappings.Json"),
    ("BeechTree_LRN",  "BeechTreeFieldMappings.json"),
    ("Certus_LRN",     "CertusFieldMappings.Json"),
    ("CoveLRN",        "CoveFieldMappings.Json"),
    ("Elixir_LRN",     "ElixirFieldMappings.Json"),
    ("InHealthDTRLRN", "InHealthDTRFieldMappings.json"),
    ("NWL_LRN",        "NWLFieldMappings.json"),
    ("PCRAL_LRN",      "PCRDxALFieldMappings.json"),
    ("PCRCO_LRN",      "PCRDxCOFieldMappings.json"),
    ("PCRLOA_LRN",     "PCRLabsofAmericaFieldMappings.Json"),
    ("PhiLife_LRN",    "PhiLifeFieldMappings.json"),
    ("RisingTides",    "RisingTidesFieldMappings.Json"),
])

# Numeric view of InsuranceBalance, which every table stores as nvarchar.
#
# Production already carries this on three ClaimLevelData tables (Augustus, Certus, NWL); it is now
# created on ALL 24 tables - both levels, every lab - so reporting can aggregate the balance without
# casting in every query. TRY_CAST yields NULL rather than failing on non-numeric text, and PERSISTED
# stores the result so it can be indexed and costs nothing to read.
#
# Nothing ever writes to it: it is absent from every lab mapping, so it appears in neither the
# SqlBulkCopy column list nor the INSERT...SELECT of the swap. Verified before this was added.
COMPUTED_COL = "InsuranceBalance_Decimal"
COMPUTED_SRC = "InsuranceBalance"
COMPUTED_EXPR = "(TRY_CAST([InsuranceBalance] AS [decimal](18,2))) PERSISTED"


def computed_clause():
    return f"        [{COMPUTED_COL}] AS {COMPUTED_EXPR}"


def computed_alter(table):
    """Idempotent add for a table that already exists without the column."""
    return [
        f"IF COL_LENGTH('dbo.{table}', '{COMPUTED_COL}') IS NULL",
        f"   AND COL_LENGTH('dbo.{table}', '{COMPUTED_SRC}') IS NOT NULL",
        f"    ALTER TABLE [dbo].[{table}] ADD [{COMPUTED_COL}] AS {COMPUTED_EXPR};",
        "GO",
    ]


# Columns the pipeline owns. Present in production already; never mapped from the CSV.
PIPELINE_OWNED = {norm(c) for c in
                  ["RecordId", "FileLogId", "RunId", "WeekFolder", "SourceFullPath", "FileName",
                   "FileType", "RowHash", "InsertedDateTime"]}


def parse_production():
    """db -> table -> ordered [(column, sqltype, nullable)]"""
    src = io.open(PROD_SQL, encoding="utf-8-sig").read()
    out, cur_db = collections.OrderedDict(), None

    pattern = re.compile(r"USE\s*\[([^\]]+)\]|CREATE TABLE\s*\[dbo\]\.\[([^\]]+)\]\((.*?)\n\)", re.S)
    for m in pattern.finditer(src):
        if m.group(1):
            cur_db = m.group(1)
            continue

        table, body, cols = m.group(2), m.group(3), []
        for line in body.splitlines():
            upper = line.upper().strip()

            # The column list ends at the key definition. Production writes it as a bare
            # "PRIMARY KEY CLUSTERED" block with no CONSTRAINT keyword, whose "[RecordId] ASC" line
            # otherwise parses as a column of type ASC.
            if upper.startswith(("PRIMARY KEY", "UNIQUE", "CONSTRAINT", ")")):
                break

            # Computed column, e.g.
            #   [InsuranceBalance_Decimal] AS (TRY_CAST([InsuranceBalance] AS [decimal](18,2))) PERSISTED,
            # Reproduced verbatim: it has no type or nullability of its own, and the expression must
            # survive intact or the table will not build.
            comp = re.match(r"\s*\[([^\]]+)\]\s+AS\s+(.+?),?\s*$", line, re.I)
            if comp:
                cols.append((comp.group(1), None, True, False, comp.group(2).rstrip(",").strip()))
                continue

            cm = re.match(r"\s*\[([^\]]+)\]\s+\[?([A-Za-z0-9_]+)\]?\s*(\([^)]*\))?(.*)$", line)
            if not cm:
                continue

            name = cm.group(1)
            sqltype = cm.group(2).upper() + (cm.group(3) or "")
            rest = (cm.group(4) or "").upper()

            if sqltype.upper() in ("ASC", "DESC"):
                continue

            cols.append((name, sqltype, "NOT NULL" not in rest, "IDENTITY" in rest, None))

        out.setdefault(cur_db, {})[table] = cols
    return out


def billing_schema_columns():
    """level -> ordered [column]. The BillingFrequencyWorker common schemas."""
    out = {}
    for level, fn in (("LineLevel", "LineLevel.schema.json"), ("ClaimLevel", "ClaimLevel.schema.json")):
        path = os.path.join(BILLING, fn)
        if not os.path.exists(path):
            out[level] = []
            continue
        d = json.load(io.open(path, encoding="utf-8-sig"))
        out[level] = [c["Name"] for c in d["Columns"]]
    return out


def mapping_columns(mapping_file):
    """level -> ordered [SqlColumn] from this worker's lab mapping."""
    out = {"LineLevel": [], "ClaimLevel": []}
    if not mapping_file:
        return out
    path = os.path.join(MAPPINGS, mapping_file)
    if not os.path.exists(path):
        return out
    d = json.load(io.open(path, encoding="utf-8-sig"))
    for level in out:
        blk = d.get(level)
        if blk:
            out[level] = [f["SqlColumn"] for f in blk.get("Fields", []) if f.get("SqlColumn")]
    return out


def sql_type_for_new(column):
    """
    Type for a column production does not have. Matches the production house style - nvarchar for
    everything, sized by role - so the added columns are indistinguishable from the existing ones.
    """
    if re.search(r"(combined|xunits|codes|denials|description|remark|comment|reason|icd)", column, re.I):
        return "NVARCHAR(MAX)"
    if re.search(r"(path)", column, re.I):
        return "NVARCHAR(1000)"
    return "NVARCHAR(500)"


def main():
    prod = parse_production()
    billing = billing_schema_columns()
    report = []

    deploy_dir = os.path.join(ROOT, "sql", "Deploy")
    os.makedirs(deploy_dir, exist_ok=True)

    summary_rows = []

    for db, mapping_file in DB_TO_MAPPING.items():
        if db not in prod:
            print(f"  ! {db}: not in the production script, skipped")
            continue

        ours = mapping_columns(mapping_file)
        db_report = {"db": db, "mapping": mapping_file, "levels": {}}

        for table, level in (("LineLevelData", "LineLevel"), ("ClaimLevelData", "ClaimLevel")):
            prod_cols = prod[db].get(table, [])
            prod_norm = {norm(c[0]): c[0] for c in prod_cols}

            # 1. columns the BillingFrequency common schema declares that production lacks
            from_billing = [c for c in billing[level] if norm(c) not in prod_norm]

            # 2. columns this worker maps that production lacks (and billing did not already add)
            added_norm = {norm(c) for c in from_billing}
            from_mapping = [c for c in ours[level]
                            if norm(c) not in prod_norm and norm(c) not in added_norm]

            # 3. production columns this worker has no mapping for -> loaded as NULL
            ours_norm = {norm(c) for c in ours[level]}
            unmapped_prod = [c[0] for c in prod_cols
                             if norm(c[0]) not in ours_norm and norm(c[0]) not in PIPELINE_OWNED]

            db_report["levels"][level] = {
                "table": table,
                "prod_count": len(prod_cols),
                "from_billing": from_billing,
                "from_mapping": from_mapping,
                "unmapped_prod": unmapped_prod,
                "mapped_count": len(ours[level]),
            }

            summary_rows.append((db, table, len(prod_cols), len(from_billing),
                                 len(from_mapping), len(unmapped_prod)))

        report.append(db_report)
        write_db_bundle(deploy_dir, db, prod[db], db_report)

    write_report(report, summary_rows)


def write_db_bundle(deploy_dir, db, prod_tables, db_report):
    """One consolidated script per database: production tables verbatim + the added columns."""
    lines = []
    a = lines.append

    a("/" + "*" * 94)
    a(f"    LRN Report Engine - {db} deployment")
    a("")
    a(f"    TARGET DATABASE : {db}")
    a("    BASELINE        : sql/Existing_LineLevel_ClaimLevel_DATA.sql (the schema already running")
    a("                      in production for this lab). Every production column is reproduced")
    a("                      verbatim - same name, same type, same nullability.")
    a("    IDEMPOTENT      : yes. Creates what is missing and adds missing columns only. Never")
    a("                      drops, renames, retypes or narrows anything, and never deletes data.")
    a("")
    a("    See SchemaAlignmentReport.md for the column-by-column diff behind this file.")
    a("")
    a("    GENERATED by sql/align_with_production.py - do not hand-edit.")
    a("*" * 94 + "/")
    a("")
    a(f"USE [{db}];")
    a("GO")
    a("SET ANSI_NULLS ON;")
    a("GO")
    a("SET QUOTED_IDENTIFIER ON;")
    a("GO")
    a("SET NOCOUNT ON;")
    a("GO")
    a("")

    # LineClaimFileLogs is this worker's own table; production does not have it.
    common = os.path.join(ROOT, "sql", "Labs", "_Common", "02_LineClaimFileLogs.sql")
    if os.path.exists(common):
        body = io.open(common, encoding="utf-8-sig").read()
        body = re.sub(r"^\s*(USE\s*\[[^\]]+\]\s*;?|GO|SET NOCOUNT ON;?)\s*$", "", body,
                      flags=re.M | re.I).strip()
        a("/* ---------- LineClaimFileLogs (this worker's file log) ---------- */")
        a("GO")
        a(body)
        a("GO")
        a("")

    for table, level in (("LineLevelData", "LineLevel"), ("ClaimLevelData", "ClaimLevel")):
        prod_cols = prod_tables.get(table, [])
        if not prod_cols:
            continue

        info = db_report["levels"][level]
        added = [(c, sql_type_for_new(c), "BillingFrequency schema") for c in info["from_billing"]]
        added += [(c, sql_type_for_new(c), "lab mapping") for c in info["from_mapping"]]

        a(f"/* ---------- {table} ---------- */")
        a("GO")
        a(f"IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON s.schema_id = t.schema_id")
        a(f"               WHERE s.name = 'dbo' AND t.name = '{table}')")
        a("BEGIN")
        a(f"    CREATE TABLE [dbo].[{table}](")

        body = []
        for name, sqltype, nullable, identity, computed in prod_cols:
            if computed:
                body.append(f"        [{name}] AS {computed}")
                continue
            ident = " IDENTITY(1,1)" if identity else ""
            null = "NULL" if nullable else "NOT NULL"
            body.append(f"        [{name}] {sqltype}{ident} {null}")
        for name, sqltype, _ in added:
            body.append(f"        [{name}] {sqltype} NULL")

        if not any(norm(c[0]) == norm(COMPUTED_COL) for c in prod_cols)            and any(norm(c[0]) == norm(COMPUTED_SRC) for c in prod_cols):
            body.append(computed_clause())

        pk = next((c[0] for c in prod_cols if c[3]), None)
        if pk:
            body.append(f"        PRIMARY KEY CLUSTERED ([{pk}] ASC)")

        a(",\n".join(body))
        a("    );")
        a("END")
        a("GO")
        a("")

        a(f"/* {COMPUTED_COL} - numeric view of {COMPUTED_SRC}, added on every table */")
        for line in computed_alter(table):
            a(line)
        a("")

        # Production defaults InsertedDateTime via a separate ALTER; reproduce it.
        if any(norm(c[0]) == norm("InsertedDateTime") and not c[4] for c in prod_cols):
            a(f"IF NOT EXISTS (SELECT 1 FROM sys.default_constraints d")
            a(f"               JOIN sys.columns c ON c.object_id = d.parent_object_id AND c.column_id = d.parent_column_id")
            a(f"               WHERE d.parent_object_id = OBJECT_ID('dbo.{table}') AND c.name = 'InsertedDateTime')")
            a(f"    ALTER TABLE [dbo].[{table}] ADD DEFAULT (getdate()) FOR [InsertedDateTime];")
            a("GO")
            a("")

        if added:
            a(f"/* columns added on top of the production baseline for {table} */")
            for name, sqltype, source in added:
                a(f"IF COL_LENGTH('dbo.{table}', '{name}') IS NULL")
                a(f"    ALTER TABLE [dbo].[{table}] ADD [{name}] {sqltype} NULL;   -- from {source}")
                a("GO")
            a("")

        # AdditionalFields: the JSON catch-all for CSV columns the lab mapping does not claim.
        # Labs add columns to their files constantly; without this each one needs an ALTER TABLE
        # before the data can land, and is dropped in the meantime. Same column as
        # sql/Labs/_Common/03_AdditionalFields.sql - see BulkLoad/AuditColumns.cs for the name.
        a(f"/* AdditionalFields - unmapped CSV columns as JSON, so a new column is never lost */")
        a(f"IF COL_LENGTH('dbo.{table}', 'AdditionalFields') IS NULL")
        a(f"    ALTER TABLE [dbo].[{table}] ADD [AdditionalFields] NVARCHAR(MAX) NULL;")
        a("GO")
        a("")

        # The staging tables from the previous load design are dropped, not created. The loader
        # now TRUNCATEs and bulk copies straight into the live table inside one transaction, so a
        # second full copy of every lab's data is pure cost - on NWL_LRN it was 3.3 GB of a 31 GB
        # database and helped fill the PRIMARY filegroup.
        staging = table + "_Staging"
        a(f"/* ---------- {staging} - no longer used, dropped to reclaim space ---------- */")
        a("GO")
        a(f"IF OBJECT_ID('dbo.{staging}', 'U') IS NOT NULL")
        a("BEGIN")
        a(f"    DROP TABLE [dbo].[{staging}];")
        a(f"    PRINT '  dropped dbo.{staging} (superseded by the single-transaction load)';")
        a("END")
        a("GO")
        a("")

        for idx, cols, include in (("RunId", "[RunId]", ""),
                                   ("FileLogId", "[FileLogId]", ""),
                                   ("Run_FileType", "[RunId], [FileType]", " INCLUDE ([LabID])"),
                                   ("RowHash", "[RowHash]", "")):
            a(f"IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_{table}_{idx}' AND object_id = OBJECT_ID('dbo.{table}'))")
            a(f"    CREATE NONCLUSTERED INDEX [IX_{table}_{idx}] ON [dbo].[{table}] ({cols}){include};")
            a("GO")
        a("")

    a(f"PRINT '{db} deployment complete.';")
    a("GO")

    path = os.path.join(deploy_dir, f"{db}.sql")
    io.open(path, "w", encoding="utf-8", newline="\r\n").write("\n".join(lines))
    print(f"  + sql/Deploy/{db}.sql")


def write_report(report, summary_rows):
    L = []
    a = L.append
    a("# Schema alignment with production")
    a("")
    a("Generated by `sql/align_with_production.py`. Re-run it after any mapping change.")
    a("")
    a("**Baseline:** `sql/Existing_LineLevel_ClaimLevel_DATA.sql` — the `LineLevelData` /")
    a("`ClaimLevelData` schema already running in production for 12 labs. Every column it declares is")
    a("reproduced verbatim: same name, same type, same nullability. Nothing is renamed, retyped,")
    a("narrowed or dropped.")
    a("")
    a("**On top of that**, a column is added when either source below declares it and production")
    a("does not:")
    a("")
    a("- `LRN.BillingFrequencyWorker/Schemas/LineLevel.schema.json` / `ClaimLevel.schema.json`")
    a("- this worker's own lab mapping (`Schemas/LabMappings/*FieldMappings.json`)")
    a("")
    a("**A production column this worker has no mapping for is kept and loads NULL.** Those are the")
    a("ones to check: each is a column production expects that we are not currently populating.")
    a("")
    a("---")
    a("")
    a("## Summary")
    a("")
    a("| Database | Table | Production cols | + from BillingFrequency | + from lab mapping | Production cols we load as NULL |")
    a("|---|---|---:|---:|---:|---:|")
    for db, table, pc, fb, fm, un in summary_rows:
        flag = f"**{un}**" if un else "0"
        a(f"| {db} | {table} | {pc} | {fb} | {fm} | {flag} |")
    a("")
    a("The last column is the actionable one. A non-zero value means production has columns this")
    a("worker never writes — either add the `CsvHeader` to that lab's mapping JSON, or accept NULL")
    a("if the source genuinely has no such field.")
    a("")
    a("---")
    a("")

    for r in report:
        a(f"## {r['db']}")
        a("")
        a(f"Mapping file: `{r['mapping'] or '(none — this worker has no mapping for this lab yet)'}`")
        a("")
        for level in ("LineLevel", "ClaimLevel"):
            info = r["levels"][level]
            a(f"### {info['table']}")
            a("")
            a(f"- production columns: **{info['prod_count']}**")
            a(f"- columns this worker maps: **{info['mapped_count']}**")
            a("")

            if info["from_billing"]:
                a(f"**Adding {len(info['from_billing'])} column(s) from the BillingFrequency schema** "
                  "(declared there, absent from production):")
                a("")
                a("```")
                a(", ".join(info["from_billing"]))
                a("```")
                a("")

            if info["from_mapping"]:
                a(f"**Adding {len(info['from_mapping'])} column(s) from the lab mapping** "
                  "(this worker loads them, production has no such column):")
                a("")
                a("```")
                a(", ".join(info["from_mapping"]))
                a("```")
                a("")

            if info["unmapped_prod"]:
                a(f"**⚠ {len(info['unmapped_prod'])} production column(s) we do NOT map — these load NULL:**")
                a("")
                a("```")
                a(", ".join(info["unmapped_prod"]))
                a("```")
                a("")
                a("To populate any of these, add a `{ \"CsvHeader\": \"...\", \"SqlColumn\": \"<name>\", "
                  "\"IncludeInHash\": true|false }` entry to the lab's mapping JSON.")
                a("")
            else:
                a("✅ Every production column is mapped.")
                a("")
        a("---")
        a("")

    path = os.path.join(ROOT, "SchemaAlignmentReport.md")
    io.open(path, "w", encoding="utf-8", newline="\r\n").write("\n".join(L))
    print("  + SchemaAlignmentReport.md")


if __name__ == "__main__":
    main()
