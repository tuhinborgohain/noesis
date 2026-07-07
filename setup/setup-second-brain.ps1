#requires -Version 5.1

param([string]$Vault = ".")

# setup-second-brain.ps1
# Scaffolds the second-brain vault and writes the Claude Code slash commands.
# Safe to inspect: it only creates folders and writes markdown files. No network, no deletion.
# Usage:  .\setup-second-brain.ps1 my-second-brain

function Write-File($Path, $Content) {
  $full = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
  $dir  = Split-Path -Parent $full
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  $enc = New-Object System.Text.UTF8Encoding $false     # UTF-8, no BOM
  [System.IO.File]::WriteAllText($full, $Content, $enc)
}

Write-Host "Scaffolding second brain in: $Vault"

# --- Folders -----------------------------------------------------------------
$dirs = @(
  "raw/articles","raw/transcripts","raw/clips","raw/meetings","raw/uploads",
  "wiki/concepts","wiki/entities","wiki/projects",
  "synth","meta","meta/daily","Templates",".claude/commands"
)
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path (Join-Path $Vault $d) | Out-Null }

# keep empty dirs under git
$keep = @("raw/articles","raw/transcripts","raw/clips","raw/meetings","raw/uploads",
          "wiki/concepts","wiki/entities","wiki/projects","synth","meta","meta/daily")
foreach ($d in $keep) { Write-File (Join-Path $Vault (Join-Path $d ".gitkeep")) "" }

# --- Starter index + log -----------------------------------------------------
$indexMd = @'
---
type: system
role: index
updated: 2026-07-06
---

# _index - Map of Content (read first)

The agent reads this at the start of a session to re-orient. Keep it current.

## Active projects
-

## Live theses (synth/)
-

## Key concepts
-
'@

$logMd = @'
---
type: system
role: log
updated: 2026-07-06
---

# _log - chronological action log

Newest first. Each entry: date - source - pages touched - one-line rationale.

## 2026-07-06
- Vault initialized.
'@

$idx = Join-Path $Vault "_index.md"
$log = Join-Path $Vault "_log.md"
if (-not (Test-Path $idx)) { Write-File $idx $indexMd }
if (-not (Test-Path $log)) { Write-File $log $logMd }

# --- Slash commands ----------------------------------------------------------
$ingest = @'
---
description: Compile a raw source into wiki pages with claims, provenance, confidence
argument-hint: [path to a file in raw/, or a note reference]
allowed-tools: Read, Write, Edit, Glob, Grep
---
Ingest this source: $ARGUMENTS
(If nothing is specified, process the newest unprocessed file in raw/.)

Follow the page schema in CLAUDE.md. For the source:
1. Create or update the relevant concepts/, entities/, and projects/ pages.
2. Set a provisional confidence on any new core claim and say why.
3. Link tightly only - where understanding A genuinely changes how I see B; state each edge's reason.
4. If the source conflicts with an existing page, append a [!contradiction] callout with both claims and sources. Never overwrite silently.
5. If a pattern now appears across 3+ sources, PROPOSE (don't create) a new synth/ thesis.
6. Append an entry to _log.md and update _index.md.
End with: what this source makes newly worth a deeper look, and which of my existing pages it quietly undermines.
'@

$daily = @'
---
description: End-of-day synthesis of everything created or changed today
allowed-tools: Read, Write, Edit, Glob, Grep
---
Review everything created or changed in the vault today (use file modified times and _log.md).
- Summarize what changed in 3-5 lines.
- Distill 1-3 atomic insights worth keeping (one idea each).
- Propose links from today's notes to existing pages (tight-link test; give the reason for each).
- List open loops and decisions currently pending.
- Flag anything from today that contradicts something I concluded earlier.
Write the result into today's daily note in meta/daily/ (name it with today's date; create if needed).
Close with two sections: "Tomorrow, look at..." and "Questions you're avoiding."
'@

$connect = @'
---
description: Connection Engine - hidden links, missing edges, emergent themes
argument-hint: [folder, tag, or date range to scan; default = whole wiki/ and synth/]
allowed-tools: Read, Write, Glob, Grep
---
Scan this slice of the vault: $ARGUMENTS (default: all of wiki/ and synth/).
Your job is to find what I can't see myself. Write a report to meta/connections-<today>.md covering:
1. Non-obvious connections (especially cross-domain) not yet linked - show reasoning; rate surprise x usefulness.
2. Missing edges - pairs of existing notes that pass the tight-link test but have no link yet; propose them with reasons.
3. Emergent themes / clusters I may not have named.
4. Self-contradictions across my own notes.
5. Second-order implications ("if these two are both true, then ___").
Rank everything by how much it would change my thinking. Then propose 1-2 new synth/ theses, each with a core claim, supporting notes, and a starting confidence. Show your work.
'@

$audit = @'
---
description: Assumption & contradiction audit - stress-test a note or thesis
argument-hint: [note to audit]
allowed-tools: Read, Edit, Glob, Grep
---
Target: $ARGUMENTS. Stress-test it, hard.
- Extract every assumption, explicit and implicit; mark which are load-bearing and which are actually evidenced vs. merely asserted.
- Find internal contradictions and contradictions with other notes.
- State the falsifiers: what evidence would change the core claim? If there are none, say it's unfalsifiable as written and fix that.
- Give a calibrated confidence (0-1) with the reasoning behind the number.
- Steelman the strongest position that disagrees with this note.
Append an [!audit] callout to the note and update its confidence.
'@

$redteam = @'
---
description: Decision red-team / premortem - full analytical battery on a decision
argument-hint: [decision note]
allowed-tools: Read, Edit, Glob, Grep
---
Target: $ARGUMENTS. Run:
- Steelman the rejected option - the strongest case for the path I'm not taking.
- Premortem: it's 12 months later and this decision failed. Write the most likely story of why.
- Second-order and downstream effects - what this causes, then what that causes.
- Base rates - the reference class, and what usually happens to decisions like this.
- The 3 pieces of evidence that would most change the call.
- Blind spots - who or what am I not accounting for.
End with one line: a recommended pre-commitment / tripwire. Append the results to the decision note's Red-team section.
'@

$bridge = @'
---
description: Connector Bridge - reconcile vault notes vs Jira/Confluence/M365 (needs MCP)
argument-hint: [notes or project to reconcile]
allowed-tools: Read, Write, Glob, Grep
---
NOTE: This needs the enterprise systems connected. In Claude Code, add them as MCP servers
(e.g. claude mcp add ...). If they aren't set up here, run this ritual in claude.ai where your
Atlassian / Microsoft 365 connectors already live, pasting in the notes below.

Take this slice of the vault: $ARGUMENTS. Cross-reference it against the connected systems:
- Drift - where my notes and tracked reality now disagree.
- Committed but untracked - decisions in notes not reflected in Jira/Confluence.
- Tracked but uncaptured - things moving in the systems that the vault doesn't know.
- Stale expectations - stakeholders whose last update predates a decision they care about.
- Undocumented decisions - choices visible in tickets/threads but never written down.
Give every claim provenance (which system, which item). Propose concrete updates to BOTH the vault and the source system. Flag anything that looks client-confidential before quoting it back.
'@

$monthly = @'
---
description: Monthly compounding review - health, promotions, gaps, next actions
allowed-tools: Read, Write, Edit, Glob, Grep
---
Produce a review at meta/review-<today>.md:
- Health: orphan pages, stale notes (vs. their cited sources), over-linked hubs, contested pages, schema violations (missing confidence/provenance/falsifiers).
- Promotions: which developing pages are ready to become established; which recurring patterns are ready to become synth/ theses.
- Ripe theses: which theses have accumulated enough evidence to act on.
- Gaps: the most valuable things I clearly don't know yet and should research next.
End with "The 3 things this month's knowledge is telling you to do." Be specific and blunt.
'@

$lint = @'
---
description: Health check - broken links, orphans, stale pages, schema violations
allowed-tools: Read, Edit, Glob, Grep
---
Health-check the vault; write findings to meta/lint-<today>.md:
- Broken [[links]] and orphan pages.
- Contradictions not yet resolved into callouts.
- Pages stale relative to their cited sources.
- Content gaps the wiki itself implies I should research next.
- Schema violations: pages missing confidence, sources, or a falsifier section.
Propose fixes; make the safe ones; list the judgment calls for me.
'@

$c = Join-Path $Vault ".claude/commands"
Write-File (Join-Path $c "ingest.md")  $ingest
Write-File (Join-Path $c "daily.md")   $daily
Write-File (Join-Path $c "connect.md") $connect
Write-File (Join-Path $c "audit.md")   $audit
Write-File (Join-Path $c "redteam.md") $redteam
Write-File (Join-Path $c "bridge.md")  $bridge
Write-File (Join-Path $c "monthly.md") $monthly
Write-File (Join-Path $c "lint.md")    $lint

Write-Host ""
Write-Host "Done. Created:"
Write-Host "  raw\  wiki\{concepts,entities,projects}\  synth\  meta\{,daily}\  Templates\"
Write-Host "  _index.md  _log.md"
Write-Host "  .claude\commands\  ->  /ingest /daily /connect /audit /redteam /bridge /monthly /lint"
Write-Host ""
Write-Host "Next: put CLAUDE.md and your templates in place, then run 'claude' in the vault."
