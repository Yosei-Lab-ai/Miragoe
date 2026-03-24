# Lifestack

**A self-actualization skill pack for Claude Code.**

> gstack ships products. Lifestack ships *you*.

## Core Philosophy: Identity-First Achievement

Most productivity systems start with goals: "I want to run a marathon."
Lifestack starts with identity: **"I am a runner."**

This is not wordplay. Research in Identity-Based Motivation (Oyserman, 2007) and
James Clear's identity-based habits framework shows that when people adopt an
identity *first*, their behavior naturally aligns — not through willpower, but
through self-consistency. You don't need discipline to act like yourself.

Lifestack encodes this insight into a repeatable pipeline:

```
Identity → Map → Act → Check → Adjust → Commit → Reflect
   │         │      │      │        │        │        │
 /vision   /map  (daily) /check  /pivot   /commit  /retro
                  point
```

## Quick Start

```bash
# 1. Install
git clone https://github.com/sho/lifestack.git
cd lifestack && bash setup

# 2. Declare who you are
/vision

# 3. Check your alignment (daily or weekly)
/checkpoint
```

## Skills

| Skill | Phase | Description |
|-------|-------|-------------|
| `/vision` | 1 | Declare your identity and craft a vision statement |
| `/map` | 2 | Break your vision into a goal tree with weekly actions |
| `/checkpoint` | 2 | Measure your Identity Alignment Score |
| `/commit` | 2 | Lock in commitments for the next cycle |
| `/retro` | 2 | Reflect on what worked, what didn't, and why |
| `/journal` | 2 | Guided journaling with identity-anchored prompts |
| `/mentor` | 2 | Get compassionate confrontation from your future self |
| `/pivot` | 2 | Re-evaluate goals without abandoning identity |
| `/unblock` | 2 | Diagnose and resolve psychological resistance |

## The Pipeline

```
┌─────────────────────────────────────────────────────────┐
│                    LIFESTACK PIPELINE                    │
│                                                         │
│  ┌──────────┐   ┌──────┐   ┌─────┐   ┌───────────┐    │
│  │ /vision  │──▶│ /map │──▶│ Act │──▶│/checkpoint│    │
│  │ Identity │   │ Plan │   │Daily│   │  Measure  │    │
│  └──────────┘   └──────┘   └─────┘   └─────┬─────┘    │
│       ▲                                      │          │
│       │         ┌────────┐   ┌──────┐        │          │
│       │    ┌────│ /pivot │◀──│adjust│◀───────┘          │
│       │    │    └────────┘   └──────┘                   │
│       │    ▼                                            │
│  ┌────┴─────┐   ┌────────┐                             │
│  │ /commit  │──▶│ /retro │                              │
│  │ Lock in  │   │Reflect │                              │
│  └──────────┘   └────────┘                             │
│                                                         │
│  Support skills: /journal  /mentor  /unblock            │
└─────────────────────────────────────────────────────────┘
```

## Psychological Foundations

Lifestack draws from:

- **Identity-Based Motivation** (Oyserman, 2007) — People are more likely to act
  when behavior feels identity-congruent ("this is what someone like me does")
- **Identity-Based Habits** (James Clear, *Atomic Habits*) — The most effective
  way to change behavior is to change the underlying identity
- **Self-Determination Theory** (Deci & Ryan) — Intrinsic motivation requires
  autonomy, competence, and relatedness
- **Implementation Intentions** (Gollwitzer) — "When X happens, I will do Y"
  dramatically increases follow-through
- **Compassionate Self-Confrontation** — Growth requires honest assessment
  without shame

## Comparison with gstack

| | gstack | Lifestack |
|---|---|---|
| **Domain** | Software development | Personal self-actualization |
| **Unit of work** | Sprint / PR | Identity cycle / week |
| **Ships** | Products | The person you want to become |
| **Core metric** | Velocity | Identity Alignment Score |
| **Philosophy** | Ship fast, learn fast | Be first, do follows |

They complement each other. Use gstack for your craft. Use Lifestack for yourself.

## Privacy

All data is stored locally in `~/.lifestack/`. Nothing is sent to any cloud
service. Your identity work stays on your machine.

## License

MIT — see [LICENSE](LICENSE)
