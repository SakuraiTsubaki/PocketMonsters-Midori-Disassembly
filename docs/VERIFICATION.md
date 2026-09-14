# Verification Guide

Verification should make every important reconstruction claim traceable to an identified target and repeatable evidence.

## Verification levels

- **Unverified** — proposed, imported, or inferred but not independently checked.
- **Observed** — confirmed directly in the identified target, extracted data, runtime behavior, or trusted comparison material.
- **Reconstructed** — editable project source reproduces the observed local structure, data, or behavior using documented steps.
- **Matched** — the reconstructed output satisfies a defined exact-match criterion against the identified target.

## Minimum evidence

When practical, record:

- target version / region / language / revision
- expected hash or stable identifier
- bank, section, address, offset, symbol, file path, table index, or asset identifier
- commands, scripts, and tool versions used
- expected and actual output
- hashes, byte comparisons, diffs, logs, screenshots, or test results
- known limitations or unresolved mismatches

## Rules

1. Do not treat hypotheses as confirmed findings.
2. Do not call material `Matched` without an exact comparison criterion.
3. Keep version-specific findings tied to the correct target.
4. Record meaningful mismatches instead of hiding or normalizing them.
5. Prefer reproducible commands and committed tooling over undocumented manual steps.
6. Keep retail ROM images and rebuilt ROM images outside the repository.

## Scope of verification

Verification may apply at multiple levels: a field, table, asset, routine, bank or section, subsystem, or complete build. State the scope explicitly so a local match is not mistaken for a whole-project match.
