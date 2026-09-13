# PocketMonsters-Midori-Disassembly

Disassembly of Japanese Pocket Monsters Midori (Green), supporting Rev 0 and Rev A with source, graphics, text, audio, maps, and data for byte-exact ROM reconstruction.

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
