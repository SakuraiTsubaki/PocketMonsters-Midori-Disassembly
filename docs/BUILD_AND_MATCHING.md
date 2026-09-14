# Build and Matching Guide

The long-term goal of a disassembly build is reproducibility: a clean checkout, documented toolchain, and committed source should be sufficient to recreate each supported target without committing retail ROM binaries.

## Define the target first

Every matching claim must identify the exact target release. Record region, language, revision or release identifier, expected size, and one or more authoritative hashes when available.

Do not compare output against a different revision merely because the game title is the same.

## Reproducible build expectations

- document assembler, linker, converter, compressor, and other required tool versions when they affect output;
- keep generated build products outside version control unless they are intentionally tracked evidence;
- keep source inputs and conversion steps reproducible;
- avoid hidden local inputs that are not described by the repository;
- preserve target-specific build switches and layout rules explicitly.

## Matching procedure

1. Select one documented target.
2. Build from a clean project state with the documented toolchain.
3. Compare size and cryptographic hash against the target.
4. If the full image does not match, localize the mismatch by bank, section, range, object, or asset where practical.
5. Record the mismatch and evidence before changing source.
6. Repeat until the defined exact-match criterion is satisfied.

## Match terminology

- **Unverified** — no independent comparison has been completed.
- **Observed** — structure or behavior has been confirmed in the identified target.
- **Reconstructed** — editable source reproduces the intended local structure or data with documented steps.
- **Matched** — the defined output comparison succeeds exactly for the identified target.

A function, bank, asset, or complete build should not be called `Matched` unless the exact-match criterion is stated and satisfied.

## Multi-version builds

Shared source is encouraged when bytes and behavior are genuinely shared. Differences between revisions, languages, and regions should remain explicit and reproducible rather than being erased for convenience.
