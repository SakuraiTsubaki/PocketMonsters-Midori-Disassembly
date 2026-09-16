# PocketMonsters-Midori-Disassembly

Target-specific research, tooling, and analysis for **Pocket Monsters Midori / Pokémon Green**.

## Target profile

| Field | Baseline |
| --- | --- |
| Platform | Game Boy |
| CPU | Sharp SM83 |
| Toolchain direction | RGBDS |
| Intended scope | Japanese Rev 0 and Rev A releases, subject to hash-verified baseline confirmation. |

## Purpose

- identify and verify supported retail revisions;
- document the target's binary layout and formats;
- develop deterministic target-specific tools;
- publish reproducible analysis before source reconstruction begins.

## Layout

- [`research/`](research/) — target identity, references, hypotheses, and notes;
- [`tools/`](tools/) — target-specific inspection and extraction utilities;
- [`analysis/`](analysis/) — reproducible maps, reports, and findings.

Reusable methods and cross-target utilities belong in
[`SakuraiTsubaki/Disassembly`](https://github.com/SakuraiTsubaki/Disassembly).

## Ground rules

- ROM images, firmware, keys, save data, and proprietary binary inputs are not
  committed.
- Every fact derived from a binary records the input hash, release identity,
  address range, tool version, and reproduction command.
- Completeness and byte-exact build claims require automated verification.

This is a clean foundation. No previous experimental work was migrated.
