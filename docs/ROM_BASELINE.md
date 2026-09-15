# Verified ROM Baseline

This document records observations made directly from the two read-only Japanese Pocket Monsters Midori source ROMs used for this disassembly.

## Verified targets

| Target ID | Revision | Size | MD5 | SHA-1 | SHA-256 | Result |
| --- | --- | ---: | --- | --- | --- | --- |
| `jp-green-v1.0` | V1.0 / Rev 0 | 524,288 bytes | `e30ffbab1f239f09b226477d84db1368` | `82c0eef40a5e2423699d9fd8ba15dfaa8b51d196` | `6576b4e0979e93d4a6fa02db893c294b7aeab3b841b1acc8658bc10b3554f33c` | PASS |
| `jp-green-v1.1` | V1.1 / Rev A | 524,288 bytes | `16ddd8897092936fbc0e286c6a6b23a2` | `4b97cd44aa3f0dd290bfe7b3ac17b7bd8270897b` | `3f0dc460ca8d06be1c9ac96307c939c0ea7baa366b40c2f1f4ad63242b6c4816` | PASS |

Both files match the target SHA-1 values previously recorded in this repository. Header and global checksums also validate independently.

## Cartridge header

Both revisions report the same hardware layout except for the ROM version byte and checksums.

| Field | Rev 0 | Rev A | Meaning |
| --- | --- | --- | --- |
| Title | `POKEMON GREEN` | `POKEMON GREEN` | Cartridge title |
| SGB flag | `0x03` | `0x03` | Super Game Boy functions supported |
| Cartridge type | `0x03` | `0x03` | MBC1 + RAM + Battery |
| ROM size code | `0x04` | `0x04` | 512 KiB, 32 × 16 KiB ROM banks |
| RAM size code | `0x03` | `0x03` | 32 KiB external RAM |
| Destination | `0x00` | `0x00` | Japanese |
| Version | `0x00` | `0x01` | V1.0 / V1.1 |
| Header checksum | `0x9C` | `0x9B` | Valid |
| Global checksum | `0xDDD5` | `0xF547` | Valid |

## Revision comparison

The ROMs contain 32 banks of `0x4000` bytes. Direct byte comparison finds **46,168 differing bytes**. Bank `0x1B` is byte-identical; every other bank contains at least one difference.

The largest raw differences are in banks `0x00`, `0x01`, and `0x0F`. A large raw byte count does not by itself imply that the same amount of logic changed: shifted or relaid-out code/data can create broad byte differences. Revision analysis must therefore distinguish semantic changes from relocation/layout changes.

Per-bank hashes and raw differing-byte counts are recorded in `manifests/banks.csv`.

## Initial execution map

The first verified ROM0 control-flow anchors are:

| Address | Rev 0 | Rev A | Observation |
| --- | --- | --- | --- |
| `0x0038` | `jp $F080` | same | RST 38 vector |
| `0x0040` | `jp $0AAC` | same | VBlank interrupt vector |
| `0x0048` | `rst $38` | same | LCD interrupt vector dispatches through RST 38 |
| `0x0050` | `jp $0D9A` | `jp $0D88` | Timer interrupt vector differs by revision |
| `0x0058` | `jp $0BA7` | same | Serial interrupt vector |
| `0x0060` | `reti` | same | Joypad interrupt vector |
| `0x0100` | `nop; jp $0150` | same | Cartridge entry point |
| `0x0150` | `jp $09DA` | same | Main bootstrap transfer |

These are observed addresses, not yet final symbolic names. Names should only be promoted as behavior is confirmed through control-flow and data-flow analysis.

## Reproducibility

Run `tools/verify_rom.py` against local ROM files. ROM binaries are not stored in the repository.
