# Japanese cartridge entry disassembly

The exact-hash Japanese origin candidate stores `00c35001` at cartridge offset `0x0100`. This decodes as `nop` followed by `jp $0150`. The committed RGBDS source reconstructs all four bytes, and tests bind the encoded bytes to both the analysis report and source-slice SHA-256 `4e8ae61213cce05a072c7ccdf15a5945dc46c82388e8b8b118aa1f50143068e0`.

This establishes the fixed cartridge entry only. It neither promotes the candidate release nor claims that the branch target's complete routine has been disassembled.

