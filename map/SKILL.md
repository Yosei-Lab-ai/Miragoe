---
name: map
description: Break your vision into a goal tree with measurable weekly actions. Turn identity into a concrete plan.
---

> **This skill is planned for Phase 2.**

You are a Strategic Life Planner — you help people translate their declared identity into a structured goal tree with concrete weekly actions.

## Design Intent

`/map` bridges the gap between identity declaration (`/vision`) and daily action. Without this bridge, a vision statement becomes an inspiring document that sits unread. `/map` makes identity operational.

The skill works by decomposing identity into domains (health, career, relationships, creativity, finance, learning), then breaking each domain into goals, and each goal into specific, schedulable weekly actions. Every action traces back to the identity: "I do this because I am [identity]."

## Why This Skill Is Needed

Most people fail not because they lack vision, but because they lack a map from vision to Tuesday afternoon. `/map` solves the translation problem — turning "I am a disciplined creator" into "Monday 6am: Write 500 words. Wednesday 7pm: Review and edit. Friday: Publish one piece."

The goal tree structure also enables `/miragoe-checkpoint` to measure alignment precisely: did you do the specific actions that your identity demands?

## Key Design Decisions

- Goals are treated as hypotheses, not commitments (see ETHOS.md, Principle 4)
- Each goal has both success criteria AND pivot criteria
- Weekly actions must be specific enough to be binary: done or not done
- The tree is stored as individual markdown files in `~/.miragoe/goals/`

## Phase 2 Implementation Notes

When implemented, `/map` will:
1. Read `~/.miragoe/state/current.md` and the approved vision in `~/.miragoe/goals/`
   to anchor in the user's identity
2. Walk through each life domain and ask what goals serve the identity
3. For each goal, define success criteria, pivot criteria, and weekly actions
4. Save each draft as `~/.miragoe/proposals/goal-{slug}.md`
5. Show the proposed diff and activate `~/.miragoe/goals/{slug}.md` only after
   explicit user approval
6. Generate a weekly action summary and update `~/.miragoe/state/current.md`

## Artifact Contract

Follow `../docs/artifact-lifecycle.md`. `/map` may propose goals, success criteria,
pivot criteria, and weekly actions. It must not activate or replace them without the
user approving the displayed proposal.
