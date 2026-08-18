# Miragoe Artifact Lifecycle

Miragoe separates observations, proposals, and approved state. A skill may prepare a
change, but it must not silently rewrite the identity, goals, or current commitments.

## Storage and resume contract

| Stage | Artifact | Path | Write rule |
|---|---|---|---|
| Declare | Vision proposal | `~/.miragoe/proposals/vision-{slug}.md` | Create or revise until the user approves it. |
| Declare | Approved vision | `~/.miragoe/goals/vision-{slug}.md` | Create or replace only after explicit user approval. Archive the prior approved file first. |
| Map | Goal proposal | `~/.miragoe/proposals/goal-{slug}.md` | Proposal only; it cannot become active by implication. |
| Map | Approved goal | `~/.miragoe/goals/{slug}.md` | Activate only after explicit user approval. |
| Check | Checkpoint observation | `~/.miragoe/checkpoints/{date}-{id}.md` | Append a new immutable observation. Never rewrite an earlier checkpoint. |
| Adjust | Pivot proposal | `~/.miragoe/proposals/pivot-{date}-{slug}.md` | Preserve the active goal until the user approves the proposed diff. |
| Commit | Commitment proposal | `~/.miragoe/proposals/commitment-{date}.md` | Proposal only. |
| Commit | Approved commitments | `~/.miragoe/commitments/current.md` | Replace only after explicit user approval; archive the prior version. |
| Reflect | Retro observation | `~/.miragoe/retros/{date}-{id}.md` | Append a new immutable reflection. Suggested changes stay in the proposal section. |
| Resume | Current pointer | `~/.miragoe/state/current.md` | Record the last completed stage, next skill, and pending proposal after every run. |

## Required frontmatter

Every generated artifact must contain:

```yaml
status: proposed | approved | observed | archived
created: YYYY-MM-DD
updated: YYYY-MM-DD
source_skill: vision | map | checkpoint | pivot | commit | retro
resume_from: next skill or concrete next question
approval_required: true | false
```

Approved artifacts also include `approved_at`. Observations use `approval_required: false`
because they record what happened; any recommended canonical change inside them remains a
proposal and requires approval.

## Approval protocol

1. Read `~/.miragoe/state/current.md` and the referenced approved artifacts.
2. Create or update a proposal, then show the user the destination path and material diff.
3. Ask for explicit approval before activating, replacing, archiving, or retiring approved state.
4. After approval, preserve the prior version in `~/.miragoe/history/`, write the approved
   artifact, and update the resume pointer.
5. Without approval, leave approved state untouched and point `state/current.md` to the
   pending proposal.

`/checkpoint` and `/retro` never approve their own recommendations and never update vision,
goals, or commitments automatically.
