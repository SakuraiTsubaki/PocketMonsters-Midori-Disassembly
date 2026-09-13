# ROM baselines

This project targets the Japanese releases of Pocket Monsters Midori (Green), Rev 0 and Rev A.

## Rev 0

- Size: 524,288 bytes (0x80000)
- ROM banks: 32 × 0x4000
- Header title: `POKEMON GREEN`
- Header version: `0x00`
- SGB flag: `0x03`
- Cartridge type: `0x03`
- ROM size code: `0x04`
- RAM size code: `0x03`
- Header checksum: `0x9C`
- Global checksum: `0xDDD5`
- MD5: `e30ffbab1f239f09b226477d84db1368`
- SHA-1: `82c0eef40a5e2423699d9fd8ba15dfaa8b51d196`
- SHA-256: `6576b4e0979e93d4a6fa02db893c294b7aeab3b841b1acc8658bc10b3554f33c`

## Rev A

- Size: 524,288 bytes (0x80000)
- ROM banks: 32 × 0x4000
- Header title: `POKEMON GREEN`
- Header version: `0x01`
- SGB flag: `0x03`
- Cartridge type: `0x03`
- ROM size code: `0x04`
- RAM size code: `0x03`
- Header checksum: `0x9B`
- Global checksum: `0xF547`
- MD5: `16ddd8897092936fbc0e286c6a6b23a2`
- SHA-1: `4b97cd44aa3f0dd290bfe7b3ac17b7bd8270897b`
- SHA-256: `3f0dc460ca8d06be1c9ac96307c939c0ea7baa366b40c2f1f4ad63242b6c4816`

## Revision comparison

The two baselines differ at 46,168 byte positions. The changes are not limited to the ROM header, so Rev A must be modeled as a real revision rather than a checksum/header variant.

Per-bank differing-byte counts:

| Bank | Bytes differing |
| ---: | ---: |
| 00 | 13,109 |
| 01 | 11,803 |
| 02 | 18 |
| 03 | 366 |
| 04 | 233 |
| 05 | 83 |
| 06 | 348 |
| 07 | 560 |
| 08 | 60 |
| 09 | 519 |
| 0A | 14 |
| 0B | 13 |
| 0C | 32 |
| 0D | 65 |
| 0E | 79 |
| 0F | 15,403 |
| 10 | 135 |
| 11 | 307 |
| 12 | 406 |
| 13 | 36 |
| 14 | 379 |
| 15 | 313 |
| 16 | 330 |
| 17 | 397 |
| 18 | 359 |
| 19 | 32 |
| 1A | 2 |
| 1B | 0 |
| 1C | 203 |
| 1D | 425 |
| 1E | 132 |
| 1F | 7 |

These values are verification baselines for the disassembly process. ROM binaries themselves are not stored in this repository.
