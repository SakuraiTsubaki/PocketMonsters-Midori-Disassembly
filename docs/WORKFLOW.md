# Workflow

1. Hash a lawful local ROM input with `tools/hash_input.py`; never commit it.
2. Add its identity to `research/releases.csv`.
3. Verify header metadata, size, hashes, region, language, and revision.
4. Open a bounded note from `research/templates/note.md`.
5. Add ranges to the architecture-specific analysis table with provenance.
6. Commit every lawful non-ROM result needed to inspect and reproduce the work.
7. For graphics and sprites, commit encoded data, metadata, and actual PNG
   output together.
8. Preserve exact commands, tool versions, logs, patches, and output hashes.
9. Run the repository validator, artifact verifier, tests, and compile check.

Observed bytes and derived facts must remain distinguishable from inference.
