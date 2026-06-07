# Miragoe Architecture

## Pipeline Design

Miragoe follows a cyclical pipeline modeled after both the OODA loop and
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
Miragoe does not interrupt daily life — it provides structure for reflection.

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
- `/journal` — Structured journaling at any point in the cycle
- `/mentor` — On-demand coaching from the user's future self
- `/unblock` — Diagnose and resolve resistance when stuck

## Data Model

### Vision Statement (`~/.miragoe/vision.md`)

```markdown
---
created: 2026-03-24
updated: 2026-03-24
version: 1
---

# Identity Declaration
I am [identity statement].

# Core Desire
[What drives this identity — the deep why]

# Identity Actions
1. [Daily/weekly action that proves this identity]
2. ...
3. ...
4. ...
5. ...

# Identity Mindset
- When facing difficulty: [thought pattern]
- When making choices: [decision framework]
- When experiencing failure: [recovery pattern]

# Success Criteria
- [Concrete, measurable indicator of identity alignment]
- ...

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

### Goal Tree (`~/.miragoe/goals/{slug}.md`) — Phase 2

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

### Checkpoint Report (`~/.miragoe/checkpoints/{date}.md`) — Phase 2

```markdown
---
date: 2026-03-24
alignment_score: 75
actions_completed: 4
actions_planned: 5
---

# Identity Alignment Score: 75/100

## What I Did
- [Action 1] — aligned with [identity aspect]
- [Action 2] — aligned with [identity aspect]

## What I Missed
- [Missed action] — because [honest reason]

## Identity Insights
- [What I learned about who I am]

## Next Actions
- [Specific commitment for next cycle]
```

### Journal Entry (`~/.miragoe/journal/{date}.md`) — Phase 2

```markdown
---
date: 2026-03-24
mood: [1-10]
identity_reflection: [one sentence]
---

# Journal: 2026-03-24

## Identity Check-in
[Am I living as the person I declared?]

## Today's Evidence
[What I did today that proves my identity]

## Friction
[Where identity and reality clashed]

## Tomorrow's Intention
[One specific identity-aligned action for tomorrow]
```

## Directory Structure (`~/.miragoe/`)

```
~/.miragoe/
├── vision.md                  # Current active vision statement
├── goals/                     # Goal tree (one file per goal)
│   ├── morning-movement.md
│   └── deep-work-blocks.md
├── checkpoints/               # Weekly/daily checkpoint reports
│   ├── 2026-03-17.md
│   └── 2026-03-24.md
├── journal/                   # Daily journal entries
│   └── 2026-03-24.md
├── retros/                    # Cycle-end retrospectives
│   └── 2026-03-24.md
├── commitments/               # Active commitments
│   └── current.md
└── history/                   # Archived vision statements
    └── vision-2026-03-24.md
```

## Obsidian Integration

All Miragoe data is stored as plain Markdown with YAML frontmatter. This means
the `~/.miragoe/` directory can be opened directly as an Obsidian vault:

- Frontmatter fields are indexed by Obsidian's metadata system
- Internal links (e.g., `[[vision]]`) work across documents
- Dataview queries can aggregate checkpoint scores over time
- Graph view shows relationships between identity, goals, and actions

To set up: Open Obsidian → Open folder as vault → Select `~/.miragoe/`

No plugins are required for basic functionality. Recommended plugins:
- **Dataview** — Query checkpoint scores, journal trends
- **Calendar** — Navigate journal and checkpoint entries by date
- **Templater** — Use Miragoe templates directly in Obsidian

## Common Interaction Patterns (Detail)

### Pattern: Identity Anchoring Protocol

Every skill begins with:

1. Check if `~/.miragoe/vision.md` exists
2. If yes: Read it, extract the Identity Declaration, greet the user with
   reference to their identity
3. If no: Suggest running `/vision` first (except `/vision` itself)

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
