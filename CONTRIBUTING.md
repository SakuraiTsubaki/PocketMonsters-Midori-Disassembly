# Contributing

## Preserve the work

Commit every lawful, useful non-ROM work product: analysis, research material,
reports, documentation, source, tools, configuration, logs, manifests,
checklists, comparisons, CSV/JSON/YAML, graphics, sprites, palettes, fonts,
icons, tiles, converted data, patches, and verification evidence.

ROM images are the only excluded project artifacts. Never commit an original,
modified, patched, rebuilt, renamed, or archived ROM. Record ROM identity by
metadata and hashes.

Graphics and sprite work must include actual reviewable PNG output together with
encoded data and metadata. Do not preserve only hashes or manifests when the
result itself can lawfully be stored.

Credentials, editor metadata, caches, and virtual environments are machine-local
and are not work products.

## Research quality

- Record file offsets separately from CPU or bus addresses.
- Label claims observed, derived, inferred, or unknown, with confidence.
- Document exact commands and tool versions.
- Keep reusable cross-target work in `SakuraiTsubaki/Disassembly`.
- Do not claim completeness or byte-exactness without automated verification.

## Required checks

```sh
python tools/validate_repository.py .
python tools/verify_artifacts.py .
python -m unittest discover -s tests -v
python -m compileall -q tools tests
```
