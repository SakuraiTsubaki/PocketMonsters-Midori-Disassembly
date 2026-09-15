# Project Status

## Current stage

**Disassembly started — verified baseline and ROM0 bootstrap**

Both Japanese Pocket Monsters Midori revisions used by this project are independently verified against the repository target identities. Structural mapping and ROM0 code reconstruction have begun.

| Area | Status |
| --- | --- |
| Version/revision inventory | Verified — 2/2 local targets matched |
| ROM / bank / section mapping | Started — 32-bank inventory and per-bank revision hashes recorded |
| Code reconstruction | Started — ROM0 vectors, cartridge entry, and bootstrap path identified |
| Data reconstruction | Not started |
| Scripts / events | Not started |
| Graphics / assets | Not started |
| Audio / resources | Not started |
| Maps / world data | Not started |
| Build / matching verification | Not started |

## Current verified anchors

- Cartridge entry: `ROM0:$0100 -> $0150`
- Bootstrap transfer: `ROM0:$0150 -> $09DA`
- VBlank vector: `ROM0:$0040 -> $0AAC`
- Timer vector: Rev 0 `$0D9A`; Rev A `$0D88`
- Serial vector: `ROM0:$0058 -> $0BA7`
- Bank `0x1B` is byte-identical across both revisions; the other 31 banks contain revision differences.

Next milestone: reconstruct ROM0 control flow from the bootstrap and interrupt targets, then separate code from embedded data while recording revision-specific labels and byte ranges.
