# PocketMonsters-Midori-Disassembly

Disassembly of Japanese Pocket Monsters Midori (Green), supporting Rev 0 and Rev A with source, graphics, text, audio, maps, and data for byte-exact ROM reconstruction.

## Research restart — 2026-09-14

The current research environment has **no local retail ROM images available**. Work therefore proceeds from publicly accessible evidence: public disassemblies and source reconstructions, repository history, official material, technical documentation, maps, graphics, text, audio, release metadata, glitch/unused-data research, archives, and other attributable public sources.

The governing scope is **Japanese releases as the historical origin point, followed by an exhaustive survey of all regional, language, revision, and official re-release variants**. Existing repository claims and earlier analysis are retained as evidence, but are revalidated rather than automatically trusted.

Current restart ledgers:

- [`docs/PUBLIC_SOURCE_CENSUS.md`](docs/PUBLIC_SOURCE_CENSUS.md) — public-source evidence registry and search frontier.
- [`docs/PUBLIC_GITHUB_CRAWL_2026-09-14.md`](docs/PUBLIC_GITHUB_CRAWL_2026-09-14.md) — repository/branch/fork discovery and classification queue.

Any older references to locally available source ROMs or direct byte comparisons record an earlier analysis state and **do not describe the currently available inputs**.

## Goal

Reconstruct both Japanese Midori revisions from repository contents alone, without requiring an original ROM as a build input. Generated ROM binaries are build outputs and are not committed.

## Baseline ROMs

| Revision | Size | Banks | Header version | SHA-1 |
| --- | ---: | ---: | ---: | --- |
| Rev 0 | 524,288 bytes | 32 | `0x00` | `82c0eef40a5e2423699d9fd8ba15dfaa8b51d196` |
| Rev A | 524,288 bytes | 32 | `0x01` | `4b97cd44aa3f0dd290bfe7b3ac17b7bd8270897b` |

The two revisions differ at 46,168 byte positions, so revision handling must cover real code/data differences rather than only header metadata.

See [`docs/ROM_BASELINES.md`](docs/ROM_BASELINES.md) for verified metadata and [`docs/DISASSEMBLY_PLAN.md`](docs/DISASSEMBLY_PLAN.md) for the working roadmap.

## Target source layout

```text
constants/   macros/      hardware/
home/        engine/      data/
maps/        text/        gfx/
audio/       ram/         revisions/
tools/       docs/
```

The intended end state is an editable semantic disassembly: graphics, Japanese text, audio, maps, game data and executable code are restored into source-oriented formats and assembled back into byte-exact Rev 0 / Rev A ROM images.

## 📚 Documentation

| Document | Purpose |
| --- | --- |
| [Documentation Hub](docs/README.md) | Central entry point for project documentation |
| [Project Status](docs/PROJECT_STATUS.md) | Reconstruction and matching status |
| [Version Coverage](docs/VERSIONS.md) | Supported releases, revisions, sizes, and hashes |
| [Disassembly Standards](docs/DISASSEMBLY_STANDARDS.md) | Source reconstruction and provenance standards |
| [Build and Matching](docs/BUILD_AND_MATCHING.md) | Reproducible build and exact-match workflow |
| [Verification](docs/VERIFICATION.md) | Evidence levels and matching criteria |
| [Asset Workflow](docs/ASSET_WORKFLOW.md) | Graphics, sprites, deduplication, manifests, and review batches |
| [Contributing](CONTRIBUTING.md) | Contribution and pull-request guidance |
