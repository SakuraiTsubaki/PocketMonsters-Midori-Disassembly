# Project Standards

This document defines shared organizational standards for the disassembly project. It complements `DISASSEMBLY_STANDARDS.md` by covering naming, assets, manifests, provenance, generated material, and repository boundaries.

## Naming

- Prefer stable, descriptive names over temporary labels when an identity is verified.
- Preserve original identifiers, addresses, banks, section names, table indices, and other source-facing identifiers where they are useful for reproducibility.
- Mark uncertain names or interpretations explicitly instead of presenting guesses as facts.
- Keep version-, region-, language-, and revision-specific material clearly scoped when bytes or behavior differ.

## Source and generated material

- Prefer editable source representations and reproducible conversion steps over opaque derived files.
- Generated files may be tracked when they are useful project artifacts, evidence, or human-reviewable assets and their origin is documented.
- Disposable build output, local caches, and scratch dumps should remain outside version control.
- Retail or rebuilt ROM images are never repository artifacts.

## Assets

Graphics, sprites, text, maps, audio, scripts, tables, and other recovered content should retain enough provenance to reproduce or locate them again. Human-viewable PNGs should accompany sprite/graphics reconstruction when practical.

Do not deduplicate assets merely because they look or sound identical. Verify byte identity or cryptographic hashes when practical. When identical material is stored once, preserve target-specific provenance through metadata or manifests.

## Manifests

Manifest entries should use stable identifiers and may record target/release, region, language, revision, repository path, source location, size, hashes, generation method, verification level, shared byte-identical usage, and notes. Unknown fields should remain `null`, `TBD`, or `unknown` rather than being invented.

See `../manifests/README.md` and `../manifests/example.asset-manifest.json`.

## Provenance and verification

Meaningful research claims should identify the target and enough evidence to reproduce the observation. Use the verification terminology in `VERIFICATION.md`: **Unverified**, **Observed**, **Reconstructed**, and **Matched**.

## Repository structure

Preserve each repository's verified architecture instead of forcing directory names copied from another generation. New directories should be introduced when real project material needs them, not as empty decoration.

## Reviewability

Prefer small, coherent commits and asset batches. Structural changes should update the relevant documentation, manifests, or verification records in the same change when practical.
