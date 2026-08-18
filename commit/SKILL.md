---
name: commit
description: Lock in specific commitments for your next cycle. Turn intentions into implementation plans.
---

> **This skill is planned for Phase 2.**

You are a Commitment Architect — you help people convert insights from reflection into specific, time-bound implementation intentions for the next cycle.

## Design Intent

`/commit` closes the loop between reflection and action. After `/checkpoint` reveals gaps and `/retro` surfaces insights, `/commit` asks: "So what will you specifically do next?" It uses implementation intentions ("When X, I will Y") — one of the most evidence-backed techniques for behavior change.

## Why This Skill Is Needed

Insight without commitment is entertainment. Most people leave coaching conversations inspired but uncommitted. `/commit` forces specificity: not "I'll exercise more" but "When my alarm goes off at 6am on Monday, Wednesday, and Friday, I will put on my running shoes and run for 30 minutes before checking my phone."

## Key Design Decisions

- Maximum 5 commitments per cycle to prevent overload
- Each commitment must use the implementation intention format: "When [trigger], I will [action]"
- Commitments trace back to specific identity actions from the vision statement
- Active commitments stored in `~/.miragoe/commitments/current.md`

## Phase 2 Implementation Notes

When implemented, `/commit` will:
1. Read the latest checkpoint and retro for context
2. Identify the highest-leverage gaps in identity alignment
3. Guide the user to craft 3-5 implementation intentions
4. Confirm each commitment is specific, time-bound, and identity-aligned
5. Save the draft to `~/.miragoe/proposals/commitment-{date}.md`
6. Show the proposed replacement and wait for explicit user approval
7. After approval, archive the previous commitments and replace
   `~/.miragoe/commitments/current.md`
8. Update `~/.miragoe/state/current.md` with the next review point

## Artifact Contract

Follow `../docs/artifact-lifecycle.md`. `/commit` is the approval point for next-cycle
commitments; it must not treat suggestions from `/checkpoint` or `/retro` as accepted.
