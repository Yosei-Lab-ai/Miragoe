#!/usr/bin/env python3
"""Validate Miragoe's public artifact and approval contract."""

from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]


def require(path: str, needles: list[str]) -> list[str]:
    text = (ROOT / path).read_text(encoding="utf-8")
    return [f"{path}: missing {needle!r}" for needle in needles if needle not in text]


def main() -> int:
    errors: list[str] = []
    errors += require("setup", ["SKILLS=(vision map checkpoint", ".miragoe", "state/current.md", "explicit user approval"])
    errors += require("docs/artifact-lifecycle.md", ["Vision proposal", "Approved vision", "Current pointer", "status: proposed", "never approve their own recommendations"])
    for skill in ("vision", "map", "checkpoint", "pivot", "commit", "retro"):
        errors += require(f"{skill}/SKILL.md", ["artifact-lifecycle.md"])
    errors += require("checkpoint/SKILL.md", ["immutable", "Never overwrite"])
    errors += require("retro/SKILL.md", ["immutable", "never rewrites"])
    errors += require("ARCHITECTURE.md", ["~/.miragoe/state/current.md", "~/.miragoe/proposals/"])

    tracked = "\n".join(p.read_text(encoding="utf-8", errors="ignore") for p in ROOT.rglob("*.md"))
    personal_prefix = "/Users/" + "nakahara" + "shogo/"
    if personal_prefix in tracked:
        errors.append("public Markdown contains a personal absolute path")
    if "~/.miragoe/vision.md" in tracked:
        errors.append("legacy single vision path remains in public Markdown")

    if errors:
        print("[FAIL] Miragoe artifact contract")
        for error in errors:
            print(f"- {error}")
        return 2
    print("[OK] Miragoe artifact contract")
    return 0


if __name__ == "__main__":
    sys.exit(main())
