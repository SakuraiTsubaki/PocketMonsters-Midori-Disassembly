# Manifest Guide

This directory contains target inventories and metadata that support reproducible disassembly work. Existing manifests are project data and must be preserved when extending this guide.

## Reusable example

Use [`example.asset-manifest.json`](example.asset-manifest.json) as the starting point for a new asset manifest. Copy it, assign a stable asset identifier and repository path, then replace placeholders only as information is verified.

Useful fields may include target/release ID, region, language, revision, source bank/section/address/range/offset/index/symbol, logical identifier, repository path, format, size, hashes, generation method, verification state, `shared_with`, and notes.

## Rules

- Do not invent unknown metadata; use `TBD`, `unknown`, or `null` explicitly.
- Prefer stable identifiers and cryptographic hashes when identity matters.
- Preserve provenance even when a byte-identical asset is stored only once.
- Do not deduplicate assets solely because they look or sound identical; verify byte/hash identity when practical.
- Keep retail/rebuilt ROM images and console keys out of Git.
- Use verification terms consistently with `../docs/VERIFICATION.md`.

See `../docs/PROJECT_STANDARDS.md`, `../docs/ASSET_WORKFLOW.md`, `../docs/VERIFICATION.md`, and `../docs/DISASSEMBLY_STANDARDS.md`.
