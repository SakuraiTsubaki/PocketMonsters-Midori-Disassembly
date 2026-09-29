# Japanese entry-target basic block

The exact-hash Japanese origin candidate reaches `0x0150` from the cartridge entry. A conservative LR35902 pass decodes the first basic block as the three-byte `jp $09da`; the committed RGBDS source preserves those bytes. The manifest binds the ROM, source slice, report, and source hashes. This evidence does not promote the candidate release or claim coverage beyond the first control-flow terminator.
