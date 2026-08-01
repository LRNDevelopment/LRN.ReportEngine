#!/usr/bin/env python3
"""
Generates the LRNMaster deployment bundle.

NOTE: this no longer generates the per-lab LineLevelData / ClaimLevelData DDL.
sql/align_with_production.py owns that, because those tables must match the schema already running
in production (sql/Existing_LineLevel_ClaimLevel_DATA.sql) rather than being derived from the
mappings. Run BOTH:

    python sql/align_with_production.py     -> sql/Deploy/<LabDb>.sql + SchemaAlignmentReport.md
    python sql/generate_sql.py              -> sql/Deploy/LRNMaster.sql

Original description follows.

Generates the idempotent deployment scripts under sql/ from the lab mapping JSONs.

    python sql/generate_sql.py

Driven by:
  * LRN.MasterFileProcessorWorker/Schemas/LabMappings/*.json   - which columns each lab loads
  * LRN.MasterFileProcessorWorker/Schemas/ClaimLevelLineLevel_Fields.xlsx - declared types
  * LABS below - LabId / database name, which must match LRNMaster.dbo.LabMaster

Adding a lab = add a row to LABS (and its mapping JSON) and re-run. Do not hand-edit sql/Labs/**.

Column typing: business columns land as NVARCHAR, which is the widest LOSSLESS type for values
arriving from a text CSV. Narrowing to DECIMAL/DATE/INT is proposed per column in
TypeReconciliation.md and is deliberately NOT applied automatically - see that document.
"""

import json
import io
import os
import re
import sys
import zipfile
from xml.etree import ElementTree as ET

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WORKER = os.path.join(ROOT, "LRN.MasterFileProcessorWorker")
MAPPINGS = os.path.join(WORKER, "Schemas", "LabMappings")
FIELDS_XLSX = os.path.join(WORKER, "Schemas", "ClaimLevelLineLevel_Fields.xlsx")
OUT = os.path.join(ROOT, "sql")

# LabId -> (LabName, database, mapping file). Must agree with LRNMaster.dbo.LabMaster.
# Only labs whose mapping JSON is complete against the spreadsheet are listed; see
# TypeReconciliation.md section C for the ones deliberately held back.
LABS = [
    (20, "NorthWest",           "NWL_LRN",      "NWLFieldMappings.json"),
    (10, "Beech_Tree",          "BeechTree_LRN", "BeechTreeFieldMappings.json"),
    (9,  "Rising Tides",        "RisingTides",  "RisingTidesFieldMappings.Json"),
    (13, "PCR Labs of America", "LRN_PCRLOA",   "PCRLabsofAmericaFieldMappings.Json"),
    (18, "Certus",              "CertusLRN",    "CertusFieldMappings.Json"),
    (19, "Augustus",            "Augustus_LRN", "AugustusFieldMappings.Json"),
    (21, "Elixir",              "Elixir_LRN",   "ElixirFieldMappings.Json"),
]

# The nine audit columns, in the order fixed by BulkLoad/AuditColumns.cs. Keep in sync.
AUDIT = [
    ("FileLogId",      "BIGINT",         "NOT NULL"),
    ("RunId",          "VARCHAR(30)",    "NOT NULL"),
    ("WeekFolder",     "NVARCHAR(200)",  "NULL"),
    ("SourceFullPath", "NVARCHAR(1000)", "NULL"),
    ("FileName",       "NVARCHAR(400)",  "NULL"),
    ("FileType",       "VARCHAR(20)",    "NOT NULL"),
    ("RowHash",        "CHAR(64)",       "NOT NULL"),
    ("LabID",          "INT",            "NOT NULL"),
    ("LabName",        "NVARCHAR(200)",  "NOT NULL"),
]
AUDIT_NAMES = {a[0].lower() for a in AUDIT}

# Length heuristic. The spreadsheet declares a type but never a length, so sizes come from the
# column's role.
#
# These sizes were raised after a real load failed: ClaimLevelData.CPTCombined held
# "81175*1 (90),81185*1 (90),81189*1 (90),..." and overflowed NVARCHAR(255). Any column that
# aggregates a list of codes is effectively unbounded, so those get NVARCHAR(MAX) rather than a
# guess that will overflow again on a bigger claim.
UNBOUNDED = re.compile(
    r"(combined|xunits|codes|denials|denialcombination|description|remark|comment|reason|icd)", re.I)
LONG_2000 = re.compile(r"(path|address|notes)", re.I)
LONG_1000 = re.compile(r"(name|provider|clinic|panel|payer|status|category|action)", re.I)


def excel_sheets(path):
    M = "{http://schemas.openxmlformats.org/spreadsheetml/2006/main}"
    R = "{http://schemas.openxmlformats.org/officeDocument/2006/relationships}"
    z = zipfile.ZipFile(path)
    wb = ET.fromstring(z.read("xl/workbook.xml"))
    rels = ET.fromstring(z.read("xl/_rels/workbook.xml.rels"))
    relmap = {c.get("Id"): c.get("Target") for c in rels}
    shared = []
    if "xl/sharedStrings.xml" in z.namelist():
        ss = ET.fromstring(z.read("xl/sharedStrings.xml"))
        for si in ss:
            shared.append("".join(t.text or "" for t in si.iter(M + "t")))
    out = {}
    for sh in wb.find(M + "sheets"):
        tgt = relmap[sh.get(R + "id")]
        if not tgt.startswith("xl/"):
            tgt = "xl/" + tgt.lstrip("/")
        ws = ET.fromstring(z.read(tgt))
        rows = {}
        for row in ws.iter(M + "row"):
            cells = {}
            for c in row:
                v = c.find(M + "v")
                t = c.get("t")
                if t == "inlineStr":
                    isx = c.find(M + "is")
                    txt = "".join(x.text or "" for x in isx.iter(M + "t")) if isx is not None else ""
                elif v is None:
                    txt = ""
                elif t == "s":
                    txt = shared[int(v.text)]
                else:
                    txt = v.text or ""
                cells["".join(ch for ch in c.get("r") if ch.isalpha())] = txt.strip()
            rows[int(row.get("r"))] = cells
        out[sh.get("name")] = rows
    return out


def declared_types(sheet_rows):
    """Returns {claim: {col: type}, line: {col: type}} from one lab sheet."""
    claim, line = {}, {}
    for rn in sorted(sheet_rows):
        if rn < 3:
            continue
        c = sheet_rows[rn]
        if c.get("A"):
            claim[c["A"]] = (c.get("B") or "nvarchar").lower()
        if c.get("D"):
            line[c["D"]] = (c.get("E") or "nvarchar").lower()
    return claim, line


def sql_type(column, declared):
    if declared == "int":
        return "INT"
    if declared == "decimal":
        return "DECIMAL(19,4)"
    if declared in ("datetime", "date"):
        return "DATETIME2(3)"
    if UNBOUNDED.search(column):
        return "NVARCHAR(MAX)"
    if LONG_2000.search(column):
        return "NVARCHAR(2000)"
    if LONG_1000.search(column):
        return "NVARCHAR(1000)"
    return "NVARCHAR(500)"


def reconcile_block(table, columns):
    """
    Additive reconciliation for a table that already exists in a lab database with an older shape.

    CREATE TABLE alone is not enough: several lab databases already had LineLevelData /
    ClaimLevelData from a previous iteration, so IF NOT EXISTS skipped them and the load then failed
    with 'Invalid column name' against 19 columns that only existed in the freshly-created staging
    table.

    Only ever ADDs a missing column or WIDENS one that is too small. Never drops, renames, retypes
    or narrows, so it is safe to re-run against any vintage of the table.
    """
    lines = []
    a = lines.append
    a(f"/* Reconcile [{table}] with the current mapping - additive only. */")
    for name, sqltype in columns:
        target_len = -1 if "(MAX)" in sqltype.upper() else 0
        a(f"IF COL_LENGTH('dbo.{table}', '{name}') IS NULL")
        a(f"    ALTER TABLE [dbo].[{table}] ADD [{name}] {sqltype} NULL;")
        if sqltype.upper().startswith("NVARCHAR"):
            # max_length is in BYTES for nvarchar; -1 means MAX. Widen only.
            want = "-1" if target_len == -1 else str(2 * int(re.search(r"\((\d+)\)", sqltype).group(1)))
            cond = (f"c.max_length <> -1" if want == "-1"
                    else f"c.max_length <> -1 AND c.max_length < {want}")
            a(f"IF EXISTS (SELECT 1 FROM sys.columns c WHERE c.object_id = OBJECT_ID('dbo.{table}')")
            a(f"           AND c.name = '{name}' AND {cond})")
            a(f"    ALTER TABLE [dbo].[{table}] ALTER COLUMN [{name}] {sqltype} NULL;")
        a("GO")
    return "\n".join(lines)


def build_table_script(db, table, staging, columns, index_prefix):
    """columns: list of (name, sqltype)."""
    lines = []
    a = lines.append
    a(f"USE [{db}];")
    a("GO")
    a("")
    a(f"/* {table} - generated by sql/generate_sql.py. Do not hand-edit. */")
    a(f"IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON s.schema_id = t.schema_id")
    a(f"               WHERE s.name = 'dbo' AND t.name = '{table}')")
    a("BEGIN")
    a(f"    CREATE TABLE [dbo].[{table}]")
    a("    (")
    a(f"        [RecordId] BIGINT IDENTITY(1,1) NOT NULL")
    a(f"            CONSTRAINT [PK_{table}] PRIMARY KEY CLUSTERED,")
    for name, sqltype, nullable in AUDIT:
        a(f"        [{name}] {sqltype} {nullable},")
    for name, sqltype in columns:
        a(f"        [{name}] {sqltype} NULL,")
    a("        [InsertedDateTime] DATETIME2(3) NOT NULL")
    a(f"            CONSTRAINT [DF_{table}_InsertedDateTime] DEFAULT (SYSDATETIME())")
    a("    );")
    a("END")
    a("GO")
    a("")
    # Indexes required by the brief.
    a(f"IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_{index_prefix}_RunId' AND object_id = OBJECT_ID('dbo.{table}'))")
    a(f"    CREATE NONCLUSTERED INDEX [IX_{index_prefix}_RunId] ON [dbo].[{table}] ([RunId]);")
    a("GO")
    a(f"IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_{index_prefix}_FileLogId' AND object_id = OBJECT_ID('dbo.{table}'))")
    a(f"    CREATE NONCLUSTERED INDEX [IX_{index_prefix}_FileLogId] ON [dbo].[{table}] ([FileLogId]);")
    a("GO")
    a(f"IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_{index_prefix}_Lab_FileType_Run' AND object_id = OBJECT_ID('dbo.{table}'))")
    a(f"    CREATE NONCLUSTERED INDEX [IX_{index_prefix}_Lab_FileType_Run] ON [dbo].[{table}] ([LabID], [FileType], [RunId]);")
    a("GO")
    a(f"IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_{index_prefix}_RowHash' AND object_id = OBJECT_ID('dbo.{table}'))")
    a(f"    CREATE NONCLUSTERED INDEX [IX_{index_prefix}_RowHash] ON [dbo].[{table}] ([RowHash]);")
    a("GO")
    a("")
    # Staging mirror: same columns, no identity, no indexes (write-only, truncated each load).
    a(f"/* {staging} - load target for the staging+swap strategy. Same shape, no identity/indexes. */")
    a(f"IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON s.schema_id = t.schema_id")
    a(f"               WHERE s.name = 'dbo' AND t.name = '{staging}')")
    a("BEGIN")
    a(f"    CREATE TABLE [dbo].[{staging}]")
    a("    (")
    rows = [f"        [{n}] {t} {nl}" for n, t, nl in AUDIT]
    rows += [f"        [{n}] {t} NULL" for n, t in columns]
    rows.append("        [InsertedDateTime] DATETIME2(3) NOT NULL "
                f"CONSTRAINT [DF_{staging}_InsertedDateTime] DEFAULT (SYSDATETIME())")
    a(",\n".join(rows))
    a("    );")
    a("END")
    a("GO")
    a("")
    # Both tables must be reconciled: the live one may pre-date this mapping, and the staging one
    # must stay column-for-column identical to it or the INSERT...SELECT swap fails.
    a(reconcile_block(table, columns))
    a("")
    a(reconcile_block(staging, columns))
    a("")
    return "\n".join(lines)


def main():
    """Emits only sql/Deploy/LRNMaster.sql. Lab DDL comes from align_with_production.py."""
    write_deploy_bundles([])


# ----------------------------------------------------------------------------------------------
# Consolidated production bundles: ONE self-contained file per database.
# ----------------------------------------------------------------------------------------------

LRNMASTER_PARTS = [
    ("LRNMaster/01_ReportRunIdInfoLog.sql", "ReportRunIdInfoLog table"),
    ("LRNMaster/02_ReportsWorkflowTracker.sql", "ReportsWorkflowTracker table + wide view"),
    ("LRNMaster/03_ReportTypeMaster.sql", "ReportTypeMaster table + seed (13 report types)"),
    ("LRNMaster/04_AddColumns_RunLog_StepLog_InfoLog.sql", "Additive columns on LRN_Run_Log / LRN_Step_Log / ReportRunIdInfoLog / ReportsWorkflowTracker"),
    ("LRNMaster/05_usp_ReportRunIdInfoLog_Insert.sql", "usp_ReportRunIdInfoLog_Insert"),
    ("LRNMaster/06_usp_ReportsWorkflowTracker_Upsert.sql", "usp_ReportsWorkflowTracker_Upsert"),
]

USE_LINE = re.compile(r"^\s*USE\s*\[[^\]]+\]\s*;?\s*$", re.I)
GO_LINE = re.compile(r"^\s*GO\s*$", re.I)
FINAL_SELECT = re.compile(r"^\s*SELECT\s+ReportTypeId,\s*ReportTypeName", re.I)


def strip_use_and_trailing_select(text):
    """
    Removes each part's own USE/GO preamble (the bundle emits a single USE at the top) and the
    verification SELECT at the end of the seed script, which is noise inside a bundle.
    """
    out, started = [], False
    lines = text.splitlines()
    i = 0
    while i < len(lines):
        line = lines[i]
        if not started:
            if USE_LINE.match(line) or GO_LINE.match(line) or not line.strip():
                i += 1
                continue
            started = True
        if FINAL_SELECT.match(line):
            # drop the SELECT and the GO that follows it
            i += 1
            while i < len(lines) and (GO_LINE.match(lines[i]) or not lines[i].strip()):
                i += 1
            continue
        out.append(line)
        i += 1
    return "\n".join(out).rstrip()


def banner(title, contents, database):
    bar = "/" + "*" * 94
    lines = [
        bar,
        f"    {title}",
        "",
        f"    TARGET DATABASE : {database}",
        "    IDEMPOTENT      : yes - safe to run more than once. Creates what is missing, adds",
        "                      missing columns, widens columns that are too small. Never drops,",
        "                      renames, narrows or retypes anything, and never deletes data.",
        "",
        "    CONTENTS (in execution order):",
    ]
    for n, c in enumerate(contents, 1):
        lines.append(f"      {n}. {c}")
    lines += [
        "",
        "    GENERATED by sql/generate_sql.py - do not hand-edit. Re-run the generator instead.",
        "*" * 94 + "/",
        "",
    ]
    return "\n".join(lines)


def write_deploy_bundles(written_lab_scripts):
    deploy_dir = os.path.join(OUT, "Deploy")
    os.makedirs(deploy_dir, exist_ok=True)

    # ---- LRNMaster ----
    parts, contents = [], []
    for rel, desc in LRNMASTER_PARTS:
        path = os.path.join(OUT, rel.replace("/", os.sep))
        if not os.path.exists(path):
            continue
        contents.append(desc)
        body = strip_use_and_trailing_select(io.open(path, encoding="utf-8-sig").read())
        parts.append(f"/* ---------- {desc} ---------- */\nGO\n{body}\nGO\n")

    text = (banner("LRN Report Engine - LRNMaster deployment", contents, "LRNMaster")
            + "USE [LRNMaster];\nGO\nSET NOCOUNT ON;\nGO\n\n"
            + "\n".join(parts)
            + "\nPRINT 'LRNMaster deployment complete.';\nGO\n")

    out = os.path.join(deploy_dir, "LRNMaster.sql")
    io.open(out, "w", encoding="utf-8", newline="\r\n").write(text)
    print(f"  + sql/Deploy/LRNMaster.sql  ({len(contents)} parts)")

    # Per-lab bundles are produced by align_with_production.py, from the production schema.
    write_deploy_readme(deploy_dir, [])


def write_deploy_readme(deploy_dir, dbs):
    lines = [
        "# Production deployment",
        "",
        "One self-contained script per database. Nothing else from `sql/` is needed - these bundles",
        "already contain every table, column, index, view and stored procedure this change requires.",
        "",
        "Every script is **idempotent**: it creates what is missing, adds missing columns and widens",
        "columns that are too small. It never drops, renames, narrows or retypes anything, and never",
        "deletes data. Re-running is safe.",
        "",
        "## Run order",
        "",
        "**1. LRNMaster first** - the lab scripts do not depend on it, but the worker does.",
        "",
        "```",
        "sqlcmd -S <server> -d LRNMaster -E -b -i LRNMaster.sql",
        "```",
        "",
        "**2. Then each lab database** (independent of each other - run only the labs you are enabling):",
        "",
        "```",
    ]
    for db in dbs:
        lines.append(f"sqlcmd -S <server> -d {db} -E -b -i {db}.sql")
    lines += [
        "```",
        "",
        "For SQL auth use `-U <user> -P <password>` instead of `-E`. In SSMS just open the file and",
        "run it - no SQLCMD mode needed, the bundles have no `:r` includes.",
        "",
        "## What lands where",
        "",
        "### LRNMaster",
        "",
        "| Object | Change |",
        "|---|---|",
        "| `ReportRunIdInfoLog` | created; `+ SourceFileName` |",
        "| `ReportsWorkflowTracker` | created; `+ ReportTypeId` (FK); `vw_ReportsWorkflowTracker_Wide` |",
        "| `ReportTypeMaster` | created + seeded with the 13 report types, all active |",
        "| `LRN_Run_Log` | `+ LabId`, `+ WeekFolder` (existing columns untouched) |",
        "| `LRN_Step_Log` | `+ LabId` (existing columns untouched) |",
        "| `usp_ReportRunIdInfoLog_Insert` | created / altered |",
        "| `usp_ReportsWorkflowTracker_Upsert` | created / altered |",
        "",
        "### Each lab database",
        "",
        "| Object | Change |",
        "|---|---|",
        "| `LineClaimFileLogs` | created, or `+ Status, RowsCopied, ErrorMessage, CompletedDateTime` |",
        "| `LineLevelData` + `LineLevelData_Staging` | created, then reconciled to the current mapping |",
        "| `ClaimLevelData` + `ClaimLevelData_Staging` | created, then reconciled to the current mapping |",
        "",
        "\"Reconciled\" means an existing table from an earlier release gets its missing columns added",
        "and its undersized columns widened, rather than being skipped by `CREATE TABLE IF NOT EXISTS`.",
        "",
        "## After deploying",
        "",
        "```",
        "dotnet run --project LRN.MasterFileProcessorWorker -- --diagnose",
        "```",
        "",
        "Checks config, mappings, connections and every target table's columns, and names anything",
        "still wrong. Expect `All checks passed`.",
        "",
        "## Verifying by hand",
        "",
        "```sql",
        "-- LRNMaster",
        "SELECT * FROM dbo.ReportTypeMaster ORDER BY ReportTypeId;   -- 13 rows, IsActive = 1",
        "SELECT name FROM sys.procedures WHERE name LIKE 'usp_Report%';",
        "SELECT COL_LENGTH('dbo.LRN_Run_Log','LabId'), COL_LENGTH('dbo.LRN_Run_Log','WeekFolder');",
        "SELECT COL_LENGTH('dbo.ReportRunIdInfoLog','SourceFileName');",
        "",
        "-- a lab database",
        "SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID('dbo.LineLevelData');",
        "SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID('dbo.ClaimLevelData');",
        "```",
        "",
        "Generated by `sql/generate_sql.py`. Do not hand-edit the bundles - re-run the generator.",
        "",
    ]
    io.open(os.path.join(deploy_dir, "README.md"), "w", encoding="utf-8", newline="\r\n").write("\n".join(lines))
    print("  + sql/Deploy/README.md")


if __name__ == "__main__":
    main()
