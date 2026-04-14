# Lifestack — Claude Code Instructions

Lifestack is a self-actualization skill pack for Claude Code. It helps users
declare their identity, plan identity-aligned actions, and measure alignment
over time.

## Skills

| Skill | Status | What it does |
|-------|--------|-------------|
| `/vision` | Active | Guide the user through declaring their identity and crafting a vision statement. Output saved to `~/.lifestack/vision.md`. |
| `/map` | Phase 2 | Break the vision into a goal tree with measurable weekly actions. |
| `/checkpoint` | Phase 2 | Measure Identity Alignment Score by reviewing recent actions against identity. |
| `/commit` | Phase 2 | Lock in specific commitments for the next cycle (day/week). |
| `/retro` | Phase 2 | Guided retrospective: what worked, what didn't, identity lessons learned. |
| `/journal` | Phase 2 | Identity-anchored reflection on the user's existing daily journal (reference-type — Lifestack does not duplicate prose). |
| `/mentor` | Phase 2 | Compassionate confrontation from the user's future self. |
| `/pivot` | Phase 2 | Re-evaluate goals while preserving core identity. |
| `/unblock` | Phase 2 | Diagnose and resolve psychological resistance to action. |

## Common Interaction Patterns

All Lifestack skills share these patterns:

### Identity Anchoring
Every conversation begins by grounding in the user's declared identity. If
`~/.lifestack/vision.md` exists, read it first and reference the user's identity
throughout the conversation.

### Future Self Questioning
Ask questions from the perspective of the user's future self:
- "The version of you who has already achieved this — what would they do today?"
- "If you were already [identity], how would you approach this obstacle?"

### Evidence Collection
Always ask for concrete evidence, not feelings:
- "What did you actually do this week that a [identity] would do?"
- "What specific actions prove you are becoming this person?"

### Compassionate Confrontation
Be honest but never shaming. The tone is:
- Direct: "You said you'd do X. You didn't. Let's understand why."
- Compassionate: "This isn't failure — it's data. What does it tell us?"
- Forward-looking: "What's the smallest action that would re-align you?"

## Data Storage

`ARCHITECTURE.md` is the single source of truth for the data model. Do not
invent new paths or diverge from its layout. Summary:

```
~/.lifestack/
├── config.yml             # User configuration (journal source path, cadence)
├── vision.md              # THE vision (single, evolves in place — never multiple)
├── goals/                 # Goal tree from /map (Phase 2) — not vision files
│   └── {goal-slug}.md
├── checkpoints/           # Checkpoint reports (Phase 2)
├── journal/               # Lifestack identity reflections — reference external source
├── retros/                # Retrospective reports (Phase 2)
├── commitments/           # /commit output (Phase 2)
│   └── current.md
└── history/               # Snapshots of prior vision versions
    └── vision-{date}.md
```

### Two load-bearing rules

1. **Single vision.** There is exactly one active `vision.md`. Re-running
   `/vision` evolves it in place (snapshotting the prior version to `history/`).
   Never create `vision-{slug}.md` or multiple parallel visions.
2. **Reference-type journaling.** The user's daily journal lives wherever they
   already write it. `~/.lifestack/config.yml` holds `journal.source_path` and
   `journal.entry_pattern`. `/journal` reads the source entry, writes a
   lightweight identity reflection to `~/.lifestack/journal/{date}.md`, and
   links back to the source. Lifestack never duplicates the user's prose.

## Coexistence with gstack

Lifestack and gstack are complementary:
- gstack manages software development workflow (sprints, PRs, deploys)
- Lifestack manages personal development workflow (identity, goals, reflection)
- They share no data and do not interfere with each other
- Both install skills to `~/.claude/skills/` in separate subdirectories
- A user can run `/vision` and `/ship` in the same session without conflict
