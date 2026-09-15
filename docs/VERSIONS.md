# Version Coverage

This repository targets the Japanese releases of **ポケットモンスター 緑**. Each revision is tracked independently because code, data, text, pointers, layout, and build behavior may differ.

| Target ID | Region | Language | Revision / release | SHA-1 | Verification status |
| --- | --- | --- | --- | --- | --- |
| `jp-green-v1.0` | Japan | Japanese | V1.0 / Rev 0 | `82c0eef40a5e2423699d9fd8ba15dfaa8b51d196` | Local ROM independently matched; checksums valid |
| `jp-green-v1.1` | Japan | Japanese | V1.1 / Rev A | `4b97cd44aa3f0dd290bfe7b3ac17b7bd8270897b` | Local ROM independently matched; checksums valid |

## Local verification

Both project source ROMs were hashed independently on 2026-09-15 and match the target SHA-1 identities. MD5, SHA-256, size, header checksum, global checksum, and cartridge header fields are recorded in [Verified ROM Baseline](ROM_BASELINE.md) and `manifests/targets.csv`.

The earlier external cross-check against the published `roms.sha1` from the Japanese Red/Green disassembly at `Narishma-gb/pokegreen` remains useful provenance, but target verification no longer depends on that external reference because both local source ROMs now match independently.

## Address and data rule

Any ROM address, bank, pointer, checksum, or binary-layout claim added to this repository must identify the applicable Target ID when revisions differ. Do not assume V1.0 and V1.1 are equivalent unless the relevant bytes or reconstructed source have been compared.

ROM binaries are not stored in this repository.
