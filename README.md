# Claude + Obsidian Second Brain

A compounding, self-maintaining knowledge base built with **Claude Code** and **Obsidian**.

Instead of asking an AI to re-read your raw files every time you have a question, you let it build
and maintain an interlinked markdown **wiki** that keeps improving as you add sources — synthesis
happens once and gets updated, not recomputed. On top of that sits an *analyst* layer: a set of
"rituals" that surface hidden connections between your notes, stress-test your own reasoning, and
tell you what's decaying or needs a decision.

It's built on Andrej Karpathy's [*LLM Wiki*](https://gist.github.com/karpathy) pattern, extended
with three additions: a **reasoning layer** on every page (explicit assumptions, falsifiers, a
calibrated confidence), a **connection engine** that hunts non-obvious and *missing* links, and
**proactivity** baked into every ritual.

Everything is plain markdown in a folder. You own it, it's portable, and it works with any editor.

## How it works

| Folder | Layer | What lives here |
|---|---|---|
| `raw/` | inputs | Your source material — articles, transcripts, notes, clips. Never hand-edited by the agent's rules, but this is what you feed in. |
| `wiki/` | knowledge | Agent-written, interlinked pages: `concepts/`, `entities/`, `projects/`. |
| `synth/` | theses | Conclusions that have survived scrutiny. |
| `meta/` | analysis | Reports the rituals produce: connection maps, audits, reviews, health checks. |
| `CLAUDE.md` | constitution | The rules the agent reads first, every session. |
| `.claude/commands/` | rituals | The analytical passes, as slash commands. |

## Setup (VS Code — the easy way)

1. Install [VS Code](https://code.visualstudio.com/).
2. In VS Code, open the Extensions view (`Ctrl+Shift+X` / `Cmd+Shift+X`), search **Claude Code**, and
   install the extension published by **Anthropic**. It bundles Claude Code, so there's no separate
   command-line install. You'll need a paid Claude account (Pro, Max, Team, or Enterprise).
3. Clone this repo and open the folder in VS Code (**File → Open Folder**).
4. Open the Claude Code panel (the **spark ✱** icon) and sign in with your Claude account.
5. Drop a few sources into `raw/`, then type `/ingest` in the panel (or just ask in plain English).
   Reload the window once (`Ctrl+Shift+P` → *Developer: Reload Window*) so the slash commands appear.

*Command-line alternative:* install the Claude Code CLI, `cd` into this folder, and run `claude`.

## The rituals

| Command | Cadence | What it does |
|---|---|---|
| `/ingest` | on new source | Compiles a source into wiki pages with claims, provenance, and a confidence rating. |
| `/daily` | end of day | Distills what changed, proposes links, flags open loops. |
| `/connect` | weekly | Finds non-obvious connections, **missing** links, and emerging themes → writes to `meta/`. |
| `/audit` | on demand | Stress-tests a note: surfaces assumptions, contradictions, and falsifiers. |
| `/redteam` | on decisions | Premortem, inversion, second-order effects, base rates, steelman. |
| `/bridge` | as needed | Reconciles the vault against connected systems (Jira, Confluence, etc.) — needs MCP. |
| `/monthly` | monthly | Vault health, promotes theses, finds gaps, recommends next actions. |
| `/lint` | weekly | Broken links, orphans, stale pages, schema violations. |

You don't have to use the commands — you can just chat with it: *"What are my biggest open
questions?"*, *"Where do my notes contradict each other?"*, *"Summarize what I know about X."*

## Data & privacy

Everything is local markdown; nothing leaves your machine except what you send to the AI. The
included `.gitignore` excludes `raw/`, `wiki/`, `synth/`, and `meta/`, so **your actual notes and
analysis are never committed** — this repo shares the *method*, not your knowledge. If you adapt it
for work, keep confidential or proprietary material out and follow your organization's data and
publishing policies.

## Credits & notes

Method inspired by Andrej Karpathy's *LLM Wiki*. Built to run on Claude Code (Anthropic) and
Obsidian, which are independent third-party tools; this project is not affiliated with or endorsed
by either. Add your own license before publishing (MIT is a common choice for something like this).
