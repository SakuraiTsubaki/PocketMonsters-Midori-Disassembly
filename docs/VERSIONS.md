# Version Coverage

This repository targets the Japanese releases of **ポケットモンスター 緑**. Each revision is tracked independently because code, data, text, pointers, layout, and build behavior may differ.

| Target ID | Region | Language | Revision / release | SHA-1 | Verification status |
| --- | --- | --- | --- | --- | --- |
| `jp-green-v1.0` | Japan | Japanese | V1.0 | `82c0eef40a5e2423699d9fd8ba15dfaa8b51d196` | External reproducible reference; local ROM match pending |
| `jp-green-v1.1` | Japan | Japanese | V1.1 | `4b97cd44aa3f0dd290bfe7b3ac17b7bd8270897b` | External reproducible reference; local ROM match pending |

## Evidence

The SHA-1 identities above were cross-checked against the published `roms.sha1` from the Japanese Red/Green disassembly maintained at `Narishma-gb/pokegreen`.

These entries establish target identities; they do **not** mean a local ROM has already been independently matched in this repository. When a local source ROM is available, record its independently computed hashes and promote the target's verification state only after a successful match.

## Address and data rule

Any ROM address, bank, pointer, checksum, or binary-layout claim added to this repository must identify the applicable Target ID. Do not assume V1.0 and V1.1 are equivalent unless the relevant bytes or reconstructed source have been compared.

ROM binaries are not stored in this repository.
