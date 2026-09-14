# Disassembly Standards

This document defines the shared standards for reconstructing a retail game into readable, editable assembly source and reproducible project assets.

## Core principles

- Preserve the repository's verified architecture and existing source layout instead of forcing a structure copied from another generation.
- Identify the exact target version, region, language, revision, or release before making target-specific claims.
- Prefer labeled, structured assembly and editable data over opaque byte dumps when the format is understood.
- Treat raw extraction and `incbin`-style material as intermediate when a faithful structured representation can be reconstructed.
- Preserve real differences between revisions and localizations instead of flattening them into one assumed layout.
- Keep symbols, offsets, bank/section information, checksums, and other provenance close to the reconstructed material when practical.
- Do not commit retail ROM images, rebuilt ROM images, console keys, or other redistributable game binaries.

## Source reconstruction

A reconstruction should aim to make code and data understandable without changing the bytes required by the selected target. Use stable names for confirmed symbols and clearly mark uncertain names or interpretations. Comments should explain verified behavior, layout, constraints, or evidence rather than guesswork.

When multiple targets share source, keep common material shared where practical while preserving target-specific conditional logic or data where bytes differ.

## Data and assets

Graphics, text, maps, audio, scripts, tables, and other ROM content should be represented in editable project form when practical. Human-viewable graphics such as PNG previews should accompany reconstructed graphics source when they materially improve review and verification.

Byte-identical assets may be stored once and referenced by metadata or manifests. Do not deduplicate solely because assets look or sound the same; verify identity using hashes or byte comparison when practical.

## Evidence and provenance

For meaningful findings, record the target and enough evidence to reproduce the result, such as bank, section, address, offset, symbol, archive path, table index, hash, extraction command, or comparison method.

Use `TBD`, `unknown`, or an explicit hypothesis state when information has not been verified. Do not silently promote assumptions into project facts.

## Project boundaries

The repository may contain reconstructed source, extracted/recreated assets, tooling, manifests, checksums, analysis, tests, and documentation that support the disassembly. Temporary dumps, caches, and disposable build output should remain outside version control unless intentionally promoted into documented project material.
