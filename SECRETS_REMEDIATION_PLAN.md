# Secrets remediation plan

**Status: a proposal. Nothing in this document has been run.** Step 1 (rotation) is independent of
the rewrite and should happen regardless.

## What is exposed in pushed history today

Found by scanning `origin/DEV`. These are live values sitting in the remote where anyone with repo
access — and anyone who has ever cloned or forked it — can read them.

| # | Credential | Where | Introduced |
|---|---|---|---|
| S1 | Azure AD application secret `BOZ8Q~…` | `LRN.DenialDatabaseWorker/appsettings.json`, `LRN.MasterFileProcessorWorker/appsettings.json` | commit `6d8dd54` "code changes" |
| S2 | Azure AD application secret `BOZ8Q~…` | **`.codex_build/DenialDatabaseWorker/appsettings.json`** | commit `461240f` "denial code changes" |
| S3 | SQL password `Labrevnavigator@…` for `sqladmin` on `lrnanalytics-sqlmi.public.…database.windows.net` | both `appsettings.json` files and `.codex_build/**` | multiple commits |
| S4 | Teams incoming webhook (`…webhook.office.com/webhookb2/…`) | both `appsettings.json` files and `.codex_build/**` | multiple commits |

The newer Azure secret `9Dn8Q~…` was **never pushed** — GitHub's push protection blocked it, and it
has since been replaced with a placeholder in the two commits now on `DEV`.

### `.codex_build/` is the bigger problem

`.codex_build/` is a **build output directory that was committed** — 92 files, including a full copy
of `DenialDatabaseWorker/appsettings.json` with S2/S3/S4 in it. It is not in `.gitignore`, so it will
keep being re-committed and will keep re-publishing whatever secrets the real config holds.

**Fix this first — it is one line and prevents recurrence:**

```bash
printf '\n# Build output accidentally committed; contains rendered appsettings\n.codex_build/\n' >> .gitignore
git rm -r --cached .codex_build
git commit -m "Stop tracking .codex_build build output"
```

That stops the bleeding. It does **not** remove the existing copies from history — that needs the
rewrite below.

---

## Step 1 — Rotate (do this first, independent of everything else)

A rewrite does not un-leak anything. Anyone could already hold these. Rotate before or during, not
after.

1. **Azure AD app** `0cde51ec-0b8f-429e-9cb6-10ba6944f72c` (tenant `b13b3679-…`) — delete the
   `BOZ8Q~…` secret in Entra ID → App registrations → Certificates & secrets. Also delete `9Dn8Q~…`
   if it was ever used anywhere, since it briefly existed in a local commit.
2. **SQL login** `sqladmin` on `lrnanalytics-sqlmi` — change the password. Note this is an
   *admin* login reachable on a public endpoint (`…public.4e3a76f4ed99.database.windows.net,3342`);
   consider whether it should be admin at all, and whether the endpoint needs to be public.
3. **Teams webhook** — delete and recreate the connector in the target channel.
4. Check the Entra sign-in logs and the SQL audit log for use from unexpected IPs.

## Step 2 — Supply the new values out-of-band

The placeholders now in `appsettings.json` read `PUT_IN_USER_SECRETS_OR_ENV` (the convention this
repo already used for the SMTP password). Both workers use the standard .NET host, so environment
variables and user-secrets both bind with no code change:

```bash
# local dev
dotnet user-secrets --project LRN.DenialDatabaseWorker set "DenialDatabaseProcessor:SharePoint:ClientSecret" "<new>"
dotnet user-secrets --project LRN.DenialDatabaseWorker set "ConnectionStrings:DenialDatabase" "<new>"

# service host (double underscore = nesting)
setx ConnectionStrings__DefaultConnection "<new>"
setx MasterFileProcessor__SharePoint__ClientSecret "<new>"
```

Better still for the Azure SQL connections: switch to Managed Identity / Entra authentication and
remove the password from the connection string entirely.

## Step 3 — Rewrite published history

⚠ **This rewrites shared history.** Every collaborator must re-clone or hard-reset; anyone who
doesn't will silently re-push the old commits. Coordinate a freeze window first. Do not run this on
a Friday.

`git-filter-repo` is the supported tool (`git filter-branch` is deprecated and far slower):

```bash
pip install git-filter-repo
```

**1. Back up.**

```bash
git clone --mirror https://github.com/LRNDevelopment/LRN.ReportEngine LRN.ReportEngine-backup.git
```

**2. Fresh mirror to operate on.**

```bash
git clone --mirror https://github.com/LRNDevelopment/LRN.ReportEngine rewrite.git
cd rewrite.git
```

**3. Write the replacement list** — `replacements.txt`, real values on the left:

```
BOZ8Q~<rest-of-the-secret>==>PUT_IN_USER_SECRETS_OR_ENV
9Dn8Q~<rest-of-the-secret>==>PUT_IN_USER_SECRETS_OR_ENV
Labrevnavigator@<rest>==>PUT_IN_USER_SECRETS_OR_ENV
regex:https://3eclaimsprocessingllc\.webhook\.office\.com/webhookb2/[^"]+==>PUT_IN_USER_SECRETS_OR_ENV
```

**4. Purge the build directory and scrub the values.**

```bash
git filter-repo --path .codex_build --invert-paths
git filter-repo --replace-text replacements.txt
```

**5. Verify nothing survives.**

```bash
git log --all -S'BOZ8Q~' --oneline          # expect empty
git log --all -S'Labrevnavigator' --oneline # expect empty
git log --all --name-only | grep codex_build # expect empty
```

**6. Push.** Branch protection on `master`/`DEV` must be lifted for the window.

```bash
git push --force --all
git push --force --tags
```

**7. Everyone re-clones.** Existing clones are now incompatible; a `git pull` will create a mess.

**8. Ask GitHub Support to garbage-collect** the unreachable objects. Until they do, the old commits
remain reachable by SHA, and any fork or PR still holds them. This is why Step 1 is not optional.

## Step 4 — Prevent recurrence

- `.gitignore`: add `.codex_build/`, and confirm `bin/`, `obj/`, `appsettings.*.local.json` are covered.
- Enable **GitHub secret scanning + push protection** repo-wide (it is clearly already on for pushes —
  it is what blocked this one and did its job).
- Consider a `pre-commit` hook running `gitleaks` so this fails locally rather than at push time.
- Treat committed `appsettings.json` as a template only: placeholders in the repo, real values in
  user-secrets, environment variables, or Key Vault.

---

## Effort and risk

| Step | Effort | Risk |
|---|---|---|
| 1. Rotate | ~30 min | Low — but breaks running services until step 2 is done. Sequence them together. |
| 2. Out-of-band config | ~1 h | Low |
| 3. History rewrite | ~2 h + team coordination | **High** — shared history, force-push, everyone re-clones |
| 4. Prevention | ~30 min | None |

If the rewrite is judged too disruptive, **steps 1, 2 and 4 alone remove the actual risk.** Rotated
credentials in history are inert. The rewrite only buys tidiness and removes the temptation to reuse
an old value.
