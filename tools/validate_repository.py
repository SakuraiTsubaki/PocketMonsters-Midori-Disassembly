#!/usr/bin/env python3
"""Validate a target disassembly research repository foundation."""

from __future__ import annotations

import argparse
import csv
import json
from pathlib import Path

COMMON = (
    "README.md", "CONTRIBUTING.md", "project.json",
    "config/toolchain.json", "docs/SCOPE.md", "docs/ARCHITECTURE.md",
    "docs/WORKFLOW.md", "docs/ROADMAP.md", "research/README.md",
    "research/releases.csv", "research/questions.md",
    "research/templates/note.md", "tools/README.md", "tools/hash_input.py",
    "analysis/README.md", "analysis/symbols.csv", "tests/test_foundation.py",
)
PROJECT_FIELDS = {
    "schema_version", "id", "repository", "title", "platform", "cpu",
    "architecture", "family", "status", "releases",
}


def csv_header(path: Path) -> list[str]:
    with path.open(newline="", encoding="utf-8") as stream:
        return next(csv.reader(stream), [])


def validate(root: Path) -> list[str]:
    errors: list[str] = []
    for relative in COMMON:
        if not (root / relative).is_file():
            errors.append(f"missing required file: {relative}")
    try:
        project = json.loads((root / "project.json").read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        return errors + [f"invalid project.json: {exc}"]
    missing = sorted(PROJECT_FIELDS - project.keys())
    if missing:
        errors.append(f"project.json missing: {', '.join(missing)}")
    architecture = project.get("architecture")
    architecture_file = "analysis/banks.csv" if architecture == "gb-sm83" else "analysis/sections.csv"
    if architecture not in {"gb-sm83", "gba-arm7tdmi"}:
        errors.append("project.json: unsupported architecture")
    if not (root / architecture_file).is_file():
        errors.append(f"missing required file: {architecture_file}")
    if csv_header(root / "research/releases.csv") != [
        "id", "region", "language", "revision", "status", "size", "sha1", "sha256", "notes"
    ]:
        errors.append("research/releases.csv: unexpected header")
    for path in sorted(root.rglob("*.json")):
        try:
            json.loads(path.read_text(encoding="utf-8"))
        except (OSError, json.JSONDecodeError) as exc:
            errors.append(f"invalid JSON {path.relative_to(root)}: {exc}")
    return errors


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("root", nargs="?", type=Path, default=Path("."))
    args = parser.parse_args()
    errors = validate(args.root.resolve())
    if errors:
        for error in errors:
            print(f"ERROR: {error}")
        return 1
    print("Target repository foundation is valid.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
