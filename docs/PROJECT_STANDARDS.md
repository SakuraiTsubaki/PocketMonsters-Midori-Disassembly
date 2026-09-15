# Project Standards

## Naming and layout

- Use stable, descriptive, machine-friendly paths.
- Prefer ASCII-safe generic directory and tooling names unless verified source conventions require otherwise.
- Avoid spaces in machine-oriented paths.
- Preserve meaningful original IDs, indices, symbols, and archive/member identifiers.
- Represent material region, language, revision, release, or version differences in paths or metadata.
- Do not force another generation or platform's internal layout onto this target.

## Source and generated material

Prefer editable source plus reproducible conversion over opaque output. Generated files should identify source and method. Keep scripts and tools required to regenerate important outputs.

## Deduplication and evidence

Deduplicate only with strong reproducible evidence. Separate confirmed observations from hypotheses; use `unknown` or `TBD` rather than inventing metadata.

## Repository safety

Do not commit retail ROM images, rebuilt playable ROM images, console keys, or equivalent complete game-image containers.
