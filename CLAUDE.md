# Miragoe — Claude Code Instructions

Miragoe is a self-actualization skill pack for Claude Code. It helps users
declare their identity, plan identity-aligned actions, and measure alignment
over time.

## Skills

| Skill | Status | What it does |
|-------|--------|-------------|
| `/vision` | Active | Guide the user through declaring their identity and crafting a vision statement. Approved output lives in `~/.miragoe/goals/vision-{slug}.md`. |
| `/map` | Phase 2 | Break the vision into a goal tree with measurable weekly actions. |
| `/checkpoint` | Phase 2 | Measure Identity Alignment Score by reviewing recent actions against identity. |
| `/commit` | Phase 2 | Lock in specific commitments for the next cycle (day/week). |
| `/retro` | Phase 2 | Guided retrospective: what worked, what didn't, identity lessons learned. |
| `/journal` | Phase 2 | Identity-anchored journaling with structured prompts. |
| `/mentor` | Phase 2 | Compassionate confrontation from the user's future self. |
| `/pivot` | Phase 2 | Re-evaluate goals while preserving core identity. |
| `/unblock` | Phase 2 | Diagnose and resolve psychological resistance to action. |

## Common Interaction Patterns

All Miragoe skills share these patterns:

### Identity Anchoring
Every conversation begins by grounding in the user's declared identity. If
`~/.miragoe/state/current.md` exists, read it first and resolve the referenced
approved vision in `~/.miragoe/goals/`. Reference that identity throughout the conversation.

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

All user data lives in `~/.miragoe/`:

```
~/.miragoe/
├── vision.md              # Current vision statement
├── goals/                 # Goal tree (Phase 2)
│   └── {goal-slug}.md
├── checkpoints/           # Checkpoint reports (Phase 2)
│   └── {date}.md
├── journal/               # Journal entries (Phase 2)
│   └── {date}.md
├── retros/                # Retrospective reports (Phase 2)
│   └── {date}.md
└── history/               # Archived vision statements
    └── vision-{date}.md
```

## Coexistence with gstack

Miragoe and gstack are complementary:
- gstack manages software development workflow (sprints, PRs, deploys)
- Miragoe manages personal development workflow (identity, goals, reflection)
- They share no data and do not interfere with each other
- Both install skills to `~/.claude/skills/` in separate subdirectories
- A user can run `/vision` and `/ship` in the same session without conflict
