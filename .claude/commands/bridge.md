---
description: Connector Bridge - reconcile vault notes vs Jira/Confluence/M365 (needs MCP)
argument-hint: [notes or project to reconcile]
allowed-tools: Read, Write, Glob, Grep
---
NOTE: This needs the enterprise systems connected. In Claude Code, add them as MCP servers
(e.g. `claude mcp add ...`). If they aren't set up here, run this ritual in claude.ai where your
Atlassian / Microsoft 365 connectors already live, pasting in the notes below.

Take this slice of the vault: $ARGUMENTS. Cross-reference it against the connected systems:
- Drift - where my notes and tracked reality now disagree.
- Committed but untracked - decisions in notes not reflected in Jira/Confluence.
- Tracked but uncaptured - things moving in the systems that the vault doesn't know.
- Stale expectations - stakeholders whose last update predates a decision they care about.
- Undocumented decisions - choices visible in tickets/threads but never written down.
Give every claim provenance (which system, which item). Propose concrete updates to BOTH the vault and the source system. Flag anything that looks client-confidential before quoting it back.
