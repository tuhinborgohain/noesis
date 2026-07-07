---
type: system
role: templates
status: living
updated: 2026-07-06
---

# Second Brain — Page Templates

Copy each block into a new note. If you use the Templater or core Templates plugin, split these
into a `Templates/` folder and bind them to hotkeys. All page types share the reasoning-layer
frontmatter from the Operating System (§2).

---

## Source note  (`raw/` — captured input)

```md
---
type: source
status: seed
confidence: 0.0
created: {{date}}
updated: {{date}}
tags: []
sources: []          # original URL / doc / meeting
related: []
---

# {{title}}

**What it is:** one line — article / transcript / meeting / doc.
**Origin:** [link or citation]

## Raw capture
(clipped text or notes, unedited)

## Why I kept this
(one line — the reason it's worth thinking about)
```

---

## Concept note  (`wiki/concepts/`)

```md
---
type: concept
status: developing
confidence: 0.5
created: {{date}}
updated: {{date}}
tags: []
sources: []
related: []
---

# {{title}}

**Core claim:** one sentence.

## Key claims
- claim (→ [[source]])
- claim (→ [[source]])

## Assumptions
- assumption *(load-bearing)*
- assumption

## Disconfirming evidence / what would change my mind
- falsifier

## Connections
- [[note]] — *why this changes how I see it*

## Open questions
- question
```

---

## Entity note  (`wiki/entities/` — person, org, system, product)

```md
---
type: entity
status: developing
confidence: 0.6
created: {{date}}
updated: {{date}}
tags: []
sources: []
related: []
---

# {{title}}

**What / who:** one line.

## What matters about them
- point (→ [[source]])

## Relationships
- [[entity/concept]] — *nature of the link*

## Open questions
- question
```

---

## Project note  (`wiki/projects/` — active work thread)

```md
---
type: project
status: developing
confidence: 0.7
created: {{date}}
updated: {{date}}
tags: []
sources: []
related: []
---

# {{title}}

**Objective:** one line.
**Current status:** one line.

## Decisions made
- [[decision]] — date, one-line outcome

## Open loops
- [ ] item

## Connections
- [[note]] — *why relevant*
```

---

## Decision record  (`wiki/projects/` or `synth/`)

```md
---
type: decision
status: established
confidence: 0.6
created: {{date}}
updated: {{date}}
tags: []
sources: []
related: []
---

# Decision: {{title}}

**Decision:** what was chosen.
**Date / owner:** ___

## Context
what forced the choice.

## Options considered
- **Chosen:** ___ — because ___
- **Rejected:** ___ — because ___

## Assumptions this rests on
- assumption

## Tripwires (revisit if…)
- observable signal that should reopen this

## Red-team notes
(paste the output of R5 here)
```

---

## Thesis / synthesis note  (`synth/` — your evolving conclusions)

```md
---
type: thesis
status: developing
confidence: 0.4
created: {{date}}
updated: {{date}}
tags: []
sources: []
related: []
---

# Thesis: {{title}}

**Claim:** the thing I now believe, in one sentence.

## Why I believe it
- supporting point (→ [[note]])

## What would change my mind
- falsifier

## Strongest counter-position (steelman)
- the smartest opposing view

## Confidence log
- {{date}} — set to 0.4 because ___
```

---

## Daily note  (root or `meta/daily/`)

```md
---
type: daily
created: {{date}}
tags: [daily]
---

# {{date}}

## Captured today
- [[note]]

## R2 · Daily Synthesis output
(paste the agent's daily pass here)

## Tomorrow, look at…
-

## Questions I'm avoiding
-
```
