# Japanese main font

The Japanese Green retail ROM stores the main text font as 128 uncompressed 8×8 1bpp tiles. `FontGraphics` spans bank 4 addresses `0x4B19` through `0x4F19`, corresponding to file offsets `0x10B19` through `0x10F19`.

The layout and symbol boundary are corroborated by `Narishma-gb/pokegreen` source commit `953f41b34108621b2bf13c3b1e53abfc9c3e5aec` (`gfx/font.asm`, `home/load_font.asm`, and `gfx/font/font.png`) and symbols commit `bcb11e981bfc46428b388a42be249bcf547b1c93` (`pokegreen.sym` and `pokegreen11.sym`). The source PNG converts to one unique 1024-byte sequence in each verified local retail ROM at the documented offset.

Japanese revisions 0 and 1 have the same font range SHA-256, `11bfba65ad8f3b4a93f3c9b400afb611fb4072b26e2c40c77aab67bd08c9bf15`. `graphics/font/main-font-jp.png` is a deterministic 4× nearest-neighbour rendering produced by the common `extract_gb_1bpp.py` tool. The repository stores the PNG and hashes, not the raw ROM range or a ROM image.

The common `locate_gb_1bpp_loader.py` tool independently finds exactly one
matching loader in each full ROM. Revision 0 uses loader file offset `0x36CA`;
revision 1 uses `0x36B8`. Both load bank 4 address `0x4B19` (file offset
`0x10B19`) and request the same 1,024-byte, 128-tile range. The two loader
reports retain ROM, code-location, source-range, and content hashes without
including instruction bytes or font bytes.
