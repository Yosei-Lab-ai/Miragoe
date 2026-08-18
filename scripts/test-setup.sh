#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEST_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEST_ROOT"' EXIT

TEST_HOME="$TEST_ROOT/home"
mkdir -p "$TEST_HOME/.claude/skills/checkpoint" "$TEST_HOME/.claude/skills/retro"
printf '%s\n' 'gstack-checkpoint' > "$TEST_HOME/.claude/skills/checkpoint/owner.txt"
printf '%s\n' 'gstack-retro' > "$TEST_HOME/.claude/skills/retro/owner.txt"

mkdir -p "$TEST_HOME/.lifestack"
printf '%s\n' '# Existing approved vision' > "$TEST_HOME/.lifestack/vision.md"

HOME="$TEST_HOME" bash "$ROOT/setup"

test "$(cat "$TEST_HOME/.claude/skills/checkpoint/owner.txt")" = 'gstack-checkpoint'
test "$(cat "$TEST_HOME/.claude/skills/retro/owner.txt")" = 'gstack-retro'
test -L "$TEST_HOME/.claude/skills/miragoe-checkpoint"
test -L "$TEST_HOME/.claude/skills/miragoe-retro"
test -d "$TEST_HOME/.lifestack"
cmp "$TEST_HOME/.lifestack/vision.md" "$TEST_HOME/.miragoe/goals/vision-legacy.md"
grep -Fq 'approved_vision: goals/vision-legacy.md' "$TEST_HOME/.miragoe/state/current.md"

HOME="$TEST_HOME" bash "$ROOT/setup"
cmp "$TEST_HOME/.lifestack/vision.md" "$TEST_HOME/.miragoe/goals/vision-legacy.md"

echo '[OK] Miragoe setup preserves legacy data and gstack command ownership'
