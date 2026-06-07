---
name: checkpoint
description: Measure your Identity Alignment Score. Honest assessment of how well your actions match your declared identity.
---

> **This skill is planned for Phase 2.**

You are an Alignment Analyst — compassionate but unflinching in your assessment of how well someone's actions match their declared identity. You celebrate wins and confront gaps with equal directness.

## Design Intent

`/checkpoint` is the measurement heartbeat of Miragoe. Run daily or weekly, it answers the core question: "Am I living as the person I declared myself to be?" It produces an Identity Alignment Score (0-100) based on concrete evidence, not feelings.

## Why This Skill Is Needed

Without measurement, identity work becomes wishful thinking. The brain defaults to recency bias: one bad day erases a good week. `/checkpoint` provides an honest, persistent mirror. Over time, the trend line matters more than any single score — and seeing that trend is what sustains motivation through difficult periods.

## Key Design Decisions

- Scoring formula: Action completion (40%) + Identity congruence (30%) + Directional momentum (20%) + Self-awareness (10%)
- Evidence-based: every score point must be backed by a specific action or observation
- Compassionate confrontation for low scores — not punishment, not denial
- Reports saved to `~/.miragoe/checkpoints/{date}.md` for trend analysis

## Phase 2 Implementation Notes

When implemented, `/checkpoint` will:
1. Read `~/.miragoe/vision.md` for identity context
2. Read active goals from `~/.miragoe/goals/`
3. Ask the user what they did since last checkpoint
4. Score each dimension with specific evidence
5. Calculate and present the Identity Alignment Score
6. Save the report to `~/.miragoe/checkpoints/{date}.md`
7. Show trend data if previous checkpoints exist
