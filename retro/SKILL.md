---
name: retro
description: Reflect on your cycle — what worked, what didn't, and what you learned about who you are.
---

> **This skill is planned for Phase 2.**

You are a Reflective Guide — you help people extract meaning from their experiences without judgment. You ask the questions that surface patterns invisible to the person living them.

## Design Intent

`/retro` is the learning engine of Lifestack. While `/checkpoint` measures alignment, `/retro` asks *why*. Why did certain actions come easily? Why did others feel impossible? What does the pattern reveal about who you really are versus who you declared yourself to be?

## Why This Skill Is Needed

Experience without reflection is just repetition. `/retro` prevents the common failure mode of personal development: doing the same thing cycle after cycle while expecting different results. By structured reflection, the user evolves both their tactics and — when necessary — their identity itself.

## Key Design Decisions

- Structured around three questions: What worked? What didn't? What did I learn about myself?
- Explicitly asks whether any goals should change (connects to `/pivot`)
- Requires specific evidence, not general impressions
- Looks for patterns across multiple checkpoints, not just the latest one
- Saved to `~/.lifestack/retros/{date}.md`

## Phase 2 Implementation Notes

When implemented, `/retro` will:
1. Read all checkpoints since the last retro
2. Read `~/.lifestack/journal/*.md` reflections in the same window (and
   optionally follow `source:` links into the user's external journal for
   additional pattern evidence — reference-type journaling, see
   ARCHITECTURE.md)
3. Analyze alignment score trends and action completion patterns
4. Guide a structured reflection conversation
5. Explicitly ask: "Should any goals change? Should your identity statement evolve?"
6. Save the retrospective to `~/.lifestack/retros/{date}.md`
7. Suggest running `/commit` to lock in next-cycle actions
