# Lifestack Architecture

> **This document is the single source of truth for Lifestack's data model,
> file layout, and skill contracts. If any other document (README, CLAUDE.md,
> skill SKILL.md, docs/skills.md) disagrees with this one, this one wins.**

---

## Pipeline Design

Lifestack follows a cyclical pipeline modeled after both the OODA loop and
agile sprint cycles, adapted for personal identity work:

```
┌─────────┐     ┌─────┐     ┌─────┐     ┌───────────┐
│ DECLARE │────▶│ MAP │────▶│ ACT │────▶│   CHECK   │
│ /vision │     │/map │     │daily│     │/checkpoint│
└─────────┘     └─────┘     └─────┘     └─────┬─────┘
     ▲                                         │
     │ identity                          alignment
     │ evolves                           data
     │                                         │
┌────┴─────┐    ┌───────┐    ┌────────┐        │
│ REFLECT  │◀───│COMMIT │◀───│ ADJUST │◀───────┘
│  /retro  │    │/commit│    │ /pivot │
└──────────┘    └───────┘    └────────┘
```

### Phase 1: Declare (`/vision`)
The user declares their identity and crafts a vision statement. This is the
foundation — all other skills reference this document.

### Phase 2: Map (`/map`)
Break the vision into a goal tree: Identity → Domains → Goals → Weekly Actions.
Each goal includes success criteria, pivot criteria, and a target date.

### Phase 3: Act (daily life)
The user lives their life, taking actions aligned with their identity.
Lifestack does not interrupt daily life — it provides structure for reflection.

### Phase 4: Check (`/checkpoint`)
Measure Identity Alignment Score. The user reports what they did, and the system
scores alignment against declared identity and planned actions.

### Phase 5: Adjust (`/pivot`)
If alignment is low or goals feel wrong, pivot without shame. Change the goal,
keep the identity.

### Phase 6: Commit (`/commit`)
Lock in specific commitments for the next cycle. Implementation intentions:
"When [trigger], I will [action]."

### Phase 7: Reflect (`/retro`)
End-of-cycle retrospective. What worked? What didn't? What did I learn about
who I am?

### Support Skills
- `/journal` — Identity-anchored reflection on the user's existing daily journal
- `/mentor` — On-demand coaching from the user's future self
- `/unblock` — Diagnose and resolve resistance when stuck

---

## Core Design Decisions

These decisions are load-bearing. Changing them requires revisiting every
skill's contract.

### Decision 1: Single Vision, Evolved In Place

**There is exactly one active vision statement per user**, stored at
`~/.lifestack/vision.md`. Multiple simultaneous identities are not supported
by design. A person with multiple directions has no direction.

When the user re-runs `/vision`:
- Read the existing `vision.md`
- Offer two paths:
  - **Evolve** (default): update the existing file in place. Language, actions,
    mindset, and target date may change; the *identity* matures but does not
    flip. A timestamped snapshot of the previous version is written to
    `~/.lifestack/history/vision-{YYYY-MM-DD}.md` before overwriting.
  - **Replace**: the user has had a genuine identity shift (rare). Archive the
    current `vision.md` to `history/`, then start fresh.
- Bump `version:` in frontmatter on every write. Update `updated:`.

**There is no "add a vision alongside the existing one."** This option is
explicitly removed.

### Decision 2: Journal Is Reference-Type, Not Duplicated

The user's daily journaling lives where they already write it (e.g. Obsidian
vault, plaintext dir, etc.). Lifestack **does not** require writing journal
entries into `~/.lifestack/journal/`. Instead:

- The user configures `journal.source_path` and `journal.entry_pattern` in
  `~/.lifestack/config.yml` (see below).
- `/journal` reads the user's existing entry for the day (or recent days),
  runs the identity check-in conversation, and writes a **lightweight
  reflection** to `~/.lifestack/journal/{date}.md` that links back to the
  source file and stores identity-specific metadata (identity check-in, mood,
  tomorrow's intention).
- `/checkpoint` and `/retro` read both Lifestack reflections *and* — when
  allowed — the referenced source entries as evidence.

The source of truth for journaling stays with the user. Lifestack adds an
identity layer on top without duplicating prose.

### Decision 3: `goals/` Is For The Goal Tree, Not The Vision

`~/.lifestack/goals/` contains the output of `/map` only: one file per goal in
the identity's goal tree. The vision statement lives at `~/.lifestack/vision.md`,
not inside `goals/`. This keeps "who am I" (vision) cleanly separated from
"what am I building to express it" (goals).

---

## Directory Structure

```
~/.lifestack/
├── config.yml                  # User configuration (see below)
├── vision.md                   # THE vision statement (single, evolves in place)
├── goals/                      # Goal tree from /map
│   ├── {goal-slug}.md          # One file per goal
│   └── weekly-overview.md      # Aggregated weekly actions across all goals
├── checkpoints/                # /checkpoint reports
│   └── {YYYY-MM-DD}.md
├── journal/                    # /journal identity reflections (references source)
│   └── {YYYY-MM-DD}.md
├── retros/                     # /retro reports
│   └── {YYYY-MM-DD}.md
├── commitments/                # /commit output
│   └── current.md              # Active cycle's commitments
└── history/                    # Archived vision versions
    └── vision-{YYYY-MM-DD}.md  # Snapshot before each non-trivial vision edit
```

Directories are created lazily by the first skill that writes to them.

---

## Configuration (`~/.lifestack/config.yml`)

Minimal, optional, human-editable. Created on first `/vision` run if absent.

```yaml
# ~/.lifestack/config.yml
version: 1

journal:
  # Where the user writes their daily journal (absolute path, ~ expanded)
  # Leave empty or unset to run /journal in standalone mode (no external source).
  source_path: ~/obsidian/daily

  # How to locate today's entry within source_path. {date} is replaced with
  # the YYYY-MM-DD string for the target day.
  # Examples: "{date}.md", "journal-{date}.md", "{date}/index.md"
  entry_pattern: "{date}.md"

  # If the source entry does not exist for today, should /journal:
  #   "skip"   — run in standalone mode for today (don't reference anything)
  #   "prompt" — ask the user where the entry is
  #   "create" — offer to create the entry in the source path
  on_missing: prompt

cycle:
  # Default length of a "cycle" for /retro and /commit (in weeks).
  length_weeks: 1

checkpoint:
  # Default cadence for /checkpoint. "daily" or "weekly".
  cadence: weekly
```

If `config.yml` does not exist, skills default to:
- `journal.source_path: null` → `/journal` runs in standalone mode
- `cycle.length_weeks: 1`
- `checkpoint.cadence: weekly`

---

## Data Model

### Vision Statement (`~/.lifestack/vision.md`)

```markdown
---
created: 2026-03-24
updated: 2026-04-14
version: 3
---

# Identity Declaration
I am [identity statement].

# Core Desire
[What drives this identity — the deep why]

# Identity Actions
1. [Daily/weekly action that proves this identity]
2. ...
5. ...

# Identity Mindset
- When facing difficulty: [thought pattern]
- When making choices: [decision framework]
- When experiencing failure: [recovery pattern]

# Success Criteria
- [Concrete, measurable indicator of identity alignment]

# Key Resources
- [What supports this identity]

# Key Constraints
- [What works against this identity]

# First Wedge
[The single smallest action to start living this identity today]

# Anti-Goals
- [What this identity explicitly does NOT pursue]

# Origin Story
[Why this identity matters — the personal narrative]

# Target Date
[When to evaluate whether this identity has taken root]
```

**Versioning semantics:**
- `version` starts at 1 and increments by 1 on every `/vision` write.
- `created` is set once; never changes.
- `updated` reflects the last write.
- The previous file content is snapshotted to `history/vision-{updated}.md`
  before the write. `history/` is append-only.

### Goal (`~/.lifestack/goals/{slug}.md`) — Phase 2

```markdown
---
identity: "I am a [identity]"
domain: health | career | relationships | creativity | finance | learning
status: active | paused | completed | pivoted
created: 2026-03-24
target: 2026-06-24
---

# Goal
[What this goal is]

# Why This Goal
[How it connects to identity]

# Success Criteria
- [ ] [Measurable outcome]

# Pivot Criteria
- [ ] [Conditions that suggest this goal should change]

# Weekly Actions
- [ ] [Specific, schedulable action]
```

### Checkpoint Report (`~/.lifestack/checkpoints/{date}.md`) — Phase 2

See `templates/checkpoint-report.md` for the canonical template.

### Journal Reflection (`~/.lifestack/journal/{date}.md`) — Phase 2

Reference-type format: lightweight reflection linked to an external source entry.

```markdown
---
date: 2026-04-14
mood: 7           # 1-10
source: ~/obsidian/daily/2026-04-14.md   # absolute path to user's entry
source_excerpt_hash: sha1:a1b2c3…         # optional, to detect source edits
identity_reflection: "Held the runner identity through a hard morning."
---

# Identity Check-in — 2026-04-14

**Linked entry:** [[~/obsidian/daily/2026-04-14.md]]

## Today's Evidence (from source entry)
- [Quote or paraphrase from the user's own journal that shows identity in action]

## Friction
[Where identity and reality clashed — either from the source entry or surfaced during the check-in]

## Tomorrow's Intention
[One specific identity-aligned action for tomorrow]
```

If `journal.source_path` is unset, `source:` is omitted and the entry contains
whatever the user dictated during the `/journal` conversation. This is the
standalone fallback.

### Commitments (`~/.lifestack/commitments/current.md`) — Phase 2

One file, overwritten each cycle. The previous cycle's file is archived to
`commitments/{date}.md` before overwriting.

```markdown
---
cycle_start: 2026-04-14
cycle_end: 2026-04-21
identity: "I am a [identity]"
---

# Commitments for this cycle (max 5)

1. When [trigger], I will [action]. (Identity link: [reason])
2. ...
```

---

## Skill Contracts

Who reads what, who writes what. If a skill needs data a prior skill produces,
the prior skill is a hard prerequisite.

| Skill | Reads | Writes | Prereq |
|-------|-------|--------|--------|
| `/vision` | `vision.md` (if exists) | `vision.md`, `history/vision-{date}.md` | none |
| `/map` | `vision.md` | `goals/*.md`, `goals/weekly-overview.md` | `/vision` |
| `/checkpoint` | `vision.md`, `goals/*.md`, `journal/*.md`, (optional) source journal | `checkpoints/{date}.md` | `/map` |
| `/commit` | latest `checkpoints/*.md`, latest `retros/*.md` | `commitments/current.md` (archiving prior) | `/checkpoint` or `/retro` |
| `/retro` | `checkpoints/*.md` since last retro, `journal/*.md` | `retros/{date}.md` | multiple `/checkpoint` |
| `/journal` | `vision.md`, `config.yml`, source journal entry | `journal/{date}.md` | `/vision` |
| `/mentor` | `vision.md`, recent `checkpoints/*.md`, recent `journal/*.md` | — (conversation only) | `/vision` |
| `/pivot` | `goals/*.md`, `checkpoints/*.md` | updated `goals/*.md` (old archived) | `/map` |
| `/unblock` | `vision.md`, recent `checkpoints/*.md` | — (conversation only) | `/vision` |

---

## Obsidian Integration

All Lifestack data is stored as plain Markdown with YAML frontmatter. This means
the `~/.lifestack/` directory can be opened directly as an Obsidian vault:

- Frontmatter fields are indexed by Obsidian's metadata system
- Internal links (e.g., `[[vision]]`) work across documents
- Dataview queries can aggregate checkpoint scores over time
- Graph view shows relationships between identity, goals, and actions

Reference-type journaling means the user's primary journal vault can be
*different from* the Lifestack vault. Both can be opened as separate Obsidian
vaults, or combined via workspace settings. The `source:` field in each
Lifestack journal reflection is a path that Obsidian will resolve when the
user clicks through.

Recommended plugins:
- **Dataview** — Query checkpoint scores, journal trends
- **Calendar** — Navigate journal and checkpoint entries by date
- **Templater** — Use Lifestack templates directly in Obsidian

---

## Common Interaction Patterns (Detail)

### Pattern: Identity Anchoring Protocol

Every skill begins with:

1. Check if `~/.lifestack/vision.md` exists
2. If yes: read it, extract the Identity Declaration, greet the user with
   reference to their identity
3. If no: suggest running `/vision` first (except `/vision` itself)

### Pattern: Evidence-Based Scoring

The Identity Alignment Score (0-100) is calculated from:

- **Action completion** (40%): Did you do what you said you'd do?
- **Identity congruence** (30%): Do your actions reflect your declared identity?
- **Directional momentum** (20%): Are you moving closer to your vision?
- **Self-awareness** (10%): Can you honestly assess your own alignment?

### Pattern: Compassionate Confrontation Protocol

When alignment is low:

1. Acknowledge the gap without judgment
2. Ask what made the completed actions possible (find strengths)
3. Ask what prevented the missed actions (find obstacles, not excuses)
4. Reframe: "This is data, not a verdict"
5. Design one small adjustment for the next cycle
6. End with identity affirmation: "You are still [identity]. This week is data."
