# Midori ClearScreenArea disassembly

`midori-jp-rev0` is the Japanese origin reference. All 2 cataloged releases (Japanese) contain exactly one 18-byte ROM0 routine. It fills a B-by-C tilemap rectangle with tile 0x7F, restores the row start and dimensions for each row, and advances by the 20-tile screen width. Candidate status is retained; maps publish hashes and behavior, not ROM bytes.
