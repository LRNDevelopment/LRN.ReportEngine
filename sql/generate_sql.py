#!/usr/bin/env python3
"""
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
    if not os.path.exists(FIELDS_XLSX):
        sys.exit(f"Missing {FIELDS_XLSX}")

    sheets = excel_sheets(FIELDS_XLSX)
    # Workbook sheet names do not match lab names exactly.
    sheet_alias = {
        "NorthWest": "Northwest", "Beech_Tree": "BeechTree", "Rising Tides": "RisingTides",
        "PCR Labs of America": "PCRLOA", "Certus": "Certus", "Augustus": "Augustus",
        "Elixir": "Elixir", "Cove": "Cove", "PhiLife": "PHILIFE", "InHealthDTR": "InHEalthDTR",
    }

    written = []
    for lab_id, lab_name, db, mapping_file in LABS:
        mapping_path = os.path.join(MAPPINGS, mapping_file)
        if not os.path.exists(mapping_path):
            print(f"  ! {lab_name}: mapping {mapping_file} not found, skipped")
            continue

        mapping = json.load(io.open(mapping_path, encoding="utf-8-sig"))
        sheet_name = sheet_alias.get(lab_name)
        rows = sheets.get(sheet_name)
        if rows is None:
            print(f"  ! {lab_name}: no workbook sheet '{sheet_name}', skipped")
            continue

        claim_types, line_types = declared_types(rows)
        lab_dir = os.path.join(OUT, "Labs", db)
        os.makedirs(lab_dir, exist_ok=True)

        for seq, (level_key, types, table_default) in enumerate(
                [("LineLevel", line_types, "LineLevelData"),
                 ("ClaimLevel", claim_types, "ClaimLevelData")], start=1):

            level = mapping.get(level_key) or {}
            table = (level.get("SqlTableName") or f"dbo.{table_default}").split(".")[-1]
            staging = table + "_Staging"

            cols = []
            for f in level.get("Fields", []):
                name = (f.get("SqlColumn") or "").strip()
                if not name or name.lower() in AUDIT_NAMES:
                    continue  # LabID/LabName are stamped by the loader, declared in AUDIT above
                cols.append((name, sql_type(name, types.get(name, "nvarchar"))))

            script = build_table_script(db, table, staging, cols, f"{table}")
            path = os.path.join(lab_dir, f"{seq:02d}_{table}.sql")
            with io.open(path, "w", encoding="utf-8", newline="\r\n") as fh:
                fh.write(script)
            written.append(os.path.relpath(path, ROOT).replace("\\", "/"))
            print(f"  + {os.path.relpath(path, ROOT)}  ({len(cols)} business columns)")

    # 00_DeployAll.sql - :r includes, run with SQLCMD mode enabled.
    deploy = [
        "/* Master deployment script. Run in SSMS with SQLCMD Mode ON (Query > SQLCMD Mode),",
        "   or via: sqlcmd -S <server> -i sql/00_DeployAll.sql",
        "   Every referenced script is idempotent and safe to re-run. */",
        "",
        ":setvar Path \".\"",
        "",
        "PRINT '== LRNMaster ==';",
        ":r $(Path)\\LRNMaster\\01_ReportRunIdInfoLog.sql",
        ":r $(Path)\\LRNMaster\\02_ReportsWorkflowTracker.sql",
        ":r $(Path)\\LRNMaster\\03_ReportTypeMaster.sql",
        ":r $(Path)\\LRNMaster\\04_AddColumns_RunLog_StepLog_InfoLog.sql",
        ":r $(Path)\\LRNMaster\\05_usp_ReportRunIdInfoLog_Insert.sql",
        ":r $(Path)\\LRNMaster\\06_usp_ReportsWorkflowTracker_Upsert.sql",
        "",
        "PRINT '== Per-lab: LineClaimFileLogs (create or migrate) ==';",
    ]
    # The migration script has no USE of its own (it is normally run with sqlcmd -d <LabDb>),
    # so switch database before each include.
    for _, _, db, _ in LABS:
        deploy.append(f"USE [{db}];")
        deploy.append("GO")
        deploy.append(":r $(Path)\\Labs\\_Common\\02_LineClaimFileLogs.sql")
    deploy += ["", "PRINT '== Per-lab data tables ==';"]
    for rel in written:
        deploy.append(":r $(Path)\\" + rel[len("sql/"):].replace("/", "\\"))
    deploy.append("")

    with io.open(os.path.join(OUT, "00_DeployAll.sql"), "w", encoding="utf-8", newline="\r\n") as fh:
        fh.write("\n".join(deploy))
    print(f"  + sql/00_DeployAll.sql")


if __name__ == "__main__":
    main()
