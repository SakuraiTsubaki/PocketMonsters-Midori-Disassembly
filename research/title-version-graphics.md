# Green Version title graphics

`DisplayTitleScreen` in the matching `Narishma-gb/pokegreen` disassembly loads `Version_GFX` from `gfx/title/rg_version.1bpp` and doubles the ten 1bpp tiles into VRAM starting at tile ID `0x60`. The Green build's `VersionOnTitleScreenText` selects IDs `0x62 0x63 0x64 0x7f 0x65 0x66 0x67 0x68 0x69`.

The verified retail ROM contains the ten-tile sheet at `0x68000` and that exact nine-cell selection at `0x49da`. Composing the two ranges produces the displayed `Green Version` PNG. This resolves the earlier ambiguity: the raw sheet also contains Red glyphs, but the Green program's ROM-resident selection proves which tiles are displayed.

Revision 0 and revision 1 contain byte-identical tile and selection ranges, although their full-ROM SHA-256 identities differ. No official non-Japanese Green release exists, so this repository correctly has no English or European fallback asset for this game.
