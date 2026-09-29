# Study: establish Pocket Monsters Green release candidates

- Status: draft
- Release ID: midori-jp-rev0, midori-jp-rev1
- Input SHA-256: recorded per release in `research/releases.csv`
- Last updated: 2026-09-18

## Question

Which locally available Japanese Pocket Monsters Green ROM images can be recorded as hash-identified release candidates without distributing ROM content?

## Environment and tool versions

- Host: Windows
- Inspector: `SakuraiTsubaki/Disassembly tools/inspect_gb_rom.py` version 1.0.0
- Repository baseline: `9b7155abd6fb94df116736a77f18b7c8052467f4`

## Address convention

Game Boy cartridge header offsets are file offsets. The title uses `0x0134..0x0143`, revision `0x014C`, header checksum `0x014D`, and global checksum `0x014E..0x014F` in big-endian order.

## Exact procedure

1. Compute complete-file SHA-1 and SHA-256.
2. Parse the cartridge header.
3. Validate the Nintendo logo, header checksum, and global checksum.
4. Store only hashes, metadata, derived observations, and validation results.
5. Do not copy or commit ROM bytes.

## Observations

| Release ID | Size | Revision | Header checksum | Global checksum |
| --- | ---: | ---: | --- | --- |
| midori-jp-rev0 | 524288 | 0 | 0x9c | 0xddd5 |
| midori-jp-rev1 | 524288 | 1 | 0x9b | 0xf547 |

Both inputs expose the ASCII title `POKEMON GREEN`, SGB flag `0x03`, MBC3+RAM+BATTERY cartridge type `0x03`, and valid Nintendo logo and checksums.

## Derived results

Two distinct Japanese candidates correspond to header revisions 0 and 1 (commonly labeled Rev A).

## Interpretation and confidence

Hashes and header fields are directly observed. The release labeling remains candidate metadata until independently confirmed; neither entry is marked verified.

## Reproduction

Run the shared inspector with `--require-valid` for each legally obtained input and compare the result to `analysis/midori-release-header-report.json`. Verify the report hash against `analysis/midori-release-header-manifest.json`.

## Limitations and next questions

- Independent hash confirmation is required before promotion to `verified`.
- Revision-specific bank differences should only be mapped after that confirmation.
