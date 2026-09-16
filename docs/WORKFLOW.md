# Workflow

1. Hash a lawful local input with `tools/hash_input.py`.
2. Add a candidate row to `research/releases.csv`.
3. Verify header metadata, size, hashes, region, language, and revision.
4. Open a bounded note from `research/templates/note.md`.
5. Add ranges to the architecture-specific analysis table with provenance and
   confidence.
6. Add stable names to `analysis/symbols.csv`.
7. Preserve exact commands and generated-output hashes.
8. Run the validator, tests, and compile check.

Observed bytes and derived facts must remain distinguishable from inference.
