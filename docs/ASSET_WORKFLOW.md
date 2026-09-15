# Asset Workflow

This document defines how graphics, sprites, text, maps, audio, scripts, tables, and other reconstructed assets should be extracted, reviewed, deduplicated, documented, and committed.

## 1. Identify the target

Record the verified game version, region, language, and revision before treating an asset as target-specific. Unknown fields should remain `TBD`, `unknown`, or `null` instead of being guessed.

## 2. Record provenance

Keep enough information to locate the asset again, such as bank/section, address or offset, table index, archive path, symbol, extraction tool, conversion command, or source manifest entry.

## 3. Preserve editable source

Prefer reconstructed source data and reproducible conversion steps over opaque output. When graphics or sprites are reconstructed, keep the source representation and include a human-viewable PNG when practical so the asset can be reviewed directly on GitHub.

## 4. Verify before deduplicating

Assets that look or sound identical are not automatically identical. Compare bytes or cryptographic hashes when practical before merging assets shared across revisions, languages, or regions.

If an asset is byte-identical:

1. keep one representative copy where practical;
2. record all verified users in metadata or manifests;
3. preserve target-specific provenance even when the stored file is shared.

If bytes differ, retain the distinct variants and document the difference.

## 5. Register and verify

Update manifests, checksums, or project metadata with the asset identity, target coverage, source location, hashes, generation method, and verification level. Use the same `Unverified`, `Observed`, `Reconstructed`, and `Matched` terminology defined in `VERIFICATION.md`.

## 6. Commit in reviewable batches

Prefer small, coherent batches over very large asset uploads. For sprite or graphics work, keep the reconstructed graphics source, human-viewable PNG, palette/tilemap metadata where relevant, and manifest updates together when practical.

## Review checklist

- [ ] target identity is recorded or explicitly unknown
- [ ] provenance is documented
- [ ] editable/reconstructed source is retained where practical
- [ ] human-viewable PNGs are included for sprite/graphics work when practical
- [ ] byte/hash identity was checked before deduplication
- [ ] genuinely different variants remain separate
- [ ] manifests/checksums are updated
- [ ] verification status is accurate
- [ ] no retail or rebuilt ROM image is committed
- [ ] the batch is small enough to review comfortably
