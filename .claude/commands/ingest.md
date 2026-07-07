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
3. Link tightly only — where understanding A genuinely changes how I see B; state each edge's reason.
4. If the source conflicts with an existing page, append a [!contradiction] callout with both claims and sources. Never overwrite silently.
5. If a pattern now appears across 3+ sources, PROPOSE (don't create) a new synth/ thesis.
6. Append an entry to _log.md and update _index.md.
End with: what this source makes newly worth a deeper look, and which of my existing pages it quietly undermines.
