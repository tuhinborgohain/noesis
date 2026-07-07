---
type: system
role: prompt-library
status: living
updated: 2026-07-06
---

# Second Brain — Prompt Library

Copy-paste rituals. Run the maintenance ones (R1, R2, R3, R7, Lint) in Claude Code / Cowork
pointed at the vault. Run the analysis ones (R4, R5) and the bridge (R6) in the browser surface
with a pasted slice. Every ritual assumes the agent has read the Operating System file first.

Each prompt already carries the **standing instruction**: don't stop at the answer — surface what
wasn't asked, what's stale, what needs deciding, and anything that contradicts an earlier
conclusion.

---

## R1 · Ingest & Structure

> Ingest the source(s) in `raw/` that I point to. For each:
> 1. Update or create the relevant `concept`, `entity`, and `project` pages in `wiki/`, using the
>    page schema (core claim; key claims with inline provenance; assumptions made explicit;
>    disconfirming evidence; connections stating *why* each link matters; open questions).
> 2. Set a provisional `confidence` on any new core claim and say why.
> 3. Link tightly only — where understanding A genuinely changes how I see B. State each edge's
>    reason.
> 4. If the source conflicts with an existing page, append a `[!contradiction]` callout with both
>    claims and sources. Never overwrite silently.
> 5. If a pattern now appears across **3+ sources**, *propose* (don't auto-create) a new `synth/`
>    thesis note.
> 6. Append to `_log.md`: date, source, pages touched, one-line rationale. Update `_index.md`.
> End with: what this source makes newly worth a deeper look, and which of my existing pages it
> quietly undermines.

---

## R2 · Daily Synthesis  *(end of day)*

> Review everything created or changed in the vault today.
> - Summarize what changed in 3–5 lines.
> - Distill 1–3 *atomic* insights worth keeping (one idea each).
> - Propose links from today's notes to existing pages — apply the tight-link test and give the
>   reason for each.
> - List open loops and decisions currently pending.
> - Flag anything from today that contradicts something I concluded earlier in the vault.
> Close with two short sections: **"Tomorrow, look at…"** and **"Questions you're avoiding."**

---

## R3 · Connection Engine  *(weekly — the hidden-insight ritual)*

> Scan this slice of the vault: [name the folders/tags/date range]. Your job is to find what I
> can't see myself. Produce a report in `meta/` covering:
> 1. **Non-obvious connections** — relationships between notes, especially *cross-domain* ones,
>    that aren't yet linked. For each, show the reasoning and rate it *surprise × usefulness*.
> 2. **Missing edges** — pairs of existing notes that pass the tight-link test but have no link
>    yet. Propose the links with reasons.
> 3. **Emergent themes** — clusters or repeated motifs forming across notes I may not have named.
> 4. **Self-contradictions** — places where my own notes disagree with each other.
> 5. **Second-order implications** — "if these two things are both true, then ___."
> Rank everything by how much it would change my thinking. Then propose 1–2 new `synth/` theses,
> each with a core claim, its supporting notes, and a starting confidence. Show your work; I want
> to audit the reasoning, not just the conclusions.

---

## R4 · Assumption & Contradiction Audit  *(rationalization — on demand)*

> Target: [paste or name a note / thesis]. Stress-test it, hard.
> - Extract every assumption — explicit *and* implicit. Mark which are load-bearing and which are
>   actually evidenced vs. merely asserted.
> - Find internal contradictions, and contradictions with other notes in the vault.
> - State the falsifiers: what specific evidence would change the core claim? If there are none,
>   say the claim is unfalsifiable as written and fix that.
> - Give a calibrated confidence (0–1) with the reasoning behind the number.
> - Steelman the strongest position that disagrees with this note — the version its smartest
>   opponent would hold.
> Output an `[!audit]` callout I can append to the note, plus a revised confidence.

---

## R5 · Decision Red-Team / Premortem  *(hyper-analytical — on decisions)*

> Target: [paste or name a decision note]. Run the full analytical battery:
> - **Steelman the rejected option** — the strongest case for the path I'm not taking.
> - **Premortem** — it's 12 months later and this decision failed. Write the most likely story of
>   *why*.
> - **Second-order & downstream effects** — what this causes, then what *that* causes.
> - **Base rates** — what's the reference class, and what usually happens to decisions like this?
> - **Evidence that would move me** — the 3 pieces of information that would most change the call.
> - **Blind spots** — who or what am I not accounting for? (Stakeholders, incentives, constraints.)
> End with one line: a recommended **pre-commitment / tripwire** — the observable signal that
> should force me to revisit this.

---

## R6 · Connector Bridge  *(enterprise cross-data — browser + connectors)*

> Here is a slice of my vault: [paste the relevant notes]. Cross-reference it against the live
> systems I'm connected to. Pull the related items from Jira / Confluence / SharePoint / Outlook /
> Teams / calendar as appropriate, then reconcile the two:
> - **Drift** — where my notes and the tracked reality now disagree.
> - **Committed but untracked** — things I decided in notes that aren't reflected in Jira/Confluence.
> - **Tracked but uncaptured** — things moving in the enterprise systems that my vault doesn't know.
> - **Stale expectations** — stakeholders whose last update predates a decision they care about.
> - **Undocumented decisions** — choices visible in tickets/threads but never written down.
> Give every claim provenance (which system, which item). Then propose concrete updates to *both*
> the vault and the source system. Pull only what I'm authorized to see; flag anything that looks
> client-confidential before quoting it back.

---

## R7 · Monthly Compounding Review  *(keeps the brain alive and growing in value)*

> Produce a `meta/` review of the whole vault:
> - **Health** — orphan pages, stale notes (not updated vs. their sources), over-linked hubs,
>   `contested` pages needing resolution, schema violations (missing confidence/provenance).
> - **Promotions** — which `developing` pages are ready to become `established`; which recurring
>   patterns are ready to become `synth/` theses.
> - **Ripe theses** — which theses have now accumulated enough evidence to *act on*.
> - **Gaps** — the most valuable things I clearly don't know yet and should research next.
> End with **"The 3 things this month's knowledge is telling you to do."** Be specific and blunt.

---

## Lint  *(weekly minimum — enhanced health check)*

> Health-check the vault and write findings to `meta/lint-YYYY-MM-DD.md`:
> - Broken `[[links]]` and orphan pages.
> - Contradictions not yet resolved into callouts.
> - Pages stale relative to their cited sources.
> - Content gaps the wiki itself implies I should research next.
> - Schema violations: pages missing `confidence`, `sources`, or a falsifier section.
> Propose fixes; make the safe ones; list the judgment calls for me.
