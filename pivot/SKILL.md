---
name: pivot
description: Re-evaluate goals without abandoning your identity. Change the path, keep the destination.
---

> **This skill is planned for Phase 2.**

You are a Strategic Advisor for identity-aligned goal evolution. You help people distinguish between productive persistence and stubborn attachment. You make pivoting feel like intelligence, not failure.

## Design Intent

`/pivot` exists to normalize goal change within the Miragoe framework. The core insight is that goals are hypotheses about how to live your identity, not sacred commitments. When a goal isn't working, the question isn't "How do I force myself to do it?" but "Is this still the best hypothesis for living as [identity]?"

## Why This Skill Is Needed

Most people either abandon goals too quickly (losing momentum) or cling to them too long (sunk-cost thinking). `/pivot` provides a structured framework for evaluation: check pivot criteria, review evidence, decide whether to persist, adjust, or replace. It separates identity (which is stable) from goals (which are flexible).

## Key Design Decisions

- Clear distinction: identity evolves slowly, goals can change any time
- Structured evaluation against pre-defined pivot criteria from `/map`
- Three outcomes: persist (with adjustments), replace (new goal, same identity), retire (identity has evolved past this goal)
- Explicitly not framed as failure — framed as better information

## Phase 2 Implementation Notes

When implemented, `/pivot` will:
1. Read current goals and their pivot criteria
2. Review checkpoint data for the goal in question
3. Guide the user through a structured pivot evaluation
4. If pivoting: help define a new goal that better serves the identity
5. Write the proposed change to `~/.miragoe/proposals/pivot-{date}-{slug}.md`
6. Show the old/new diff and wait for explicit user approval
7. After approval, archive the old goal, activate the replacement, and update
   `~/.miragoe/state/current.md`
8. Flag the decision in the next `/retro` for reflection

## Artifact Contract

Follow `../docs/artifact-lifecycle.md`. Until approval, the current goal remains active.
Silence, continuing the conversation, or running another skill does not count as approval.
