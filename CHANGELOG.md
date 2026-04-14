# Changelog

All notable changes to Lifestack will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] — Phase 0: Architecture consolidation

### Changed
- **Single-vision rule.** `vision.md` is now the canonical, single active vision
  file. Previously the design was split across `~/.lifestack/vision.md` and
  `~/.lifestack/goals/vision-{slug}.md` in different docs. `/vision` now evolves
  the existing file in place and snapshots the prior version to `history/`.
  Multiple parallel visions are explicitly not supported.
- **Reference-type journaling.** `/journal` now reads the user's existing daily
  journal (configured via `~/.lifestack/config.yml`) and writes a lightweight
  identity reflection that links back, instead of duplicating prose. Standalone
  mode is kept as a fallback for users without an external journaling practice.
- **`goals/` reserved for the goal tree.** The vision statement no longer lives
  under `goals/`. `goals/` is exclusively for `/map` output.
- **ARCHITECTURE.md is the single source of truth.** Skill contracts
  (who-reads-what, who-writes-what) are codified there. CLAUDE.md, docs/skills.md,
  and every SKILL.md have been aligned.

### Added
- `~/.lifestack/config.yml` spec and scaffolding (journal source path, cycle
  length, checkpoint cadence). `setup` now creates a commented template.
- Evolve/replace flow for re-running `/vision` on an existing declaration.
- Skill contract table in ARCHITECTURE.md.

## [0.1.0] — 2026-03-24

### Added
- Initial project structure
- `/vision` skill — identity declaration and vision statement creation
- Phase 2 skill stubs: `/map`, `/checkpoint`, `/commit`, `/retro`, `/journal`, `/mentor`, `/pivot`, `/unblock`
- Templates: vision statement, weekly plan, checkpoint report
- Setup script for installation
- Core documentation: README, CLAUDE.md, ETHOS.md, ARCHITECTURE.md
