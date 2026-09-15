# ROM0 Disassembly Notes

ROM0 reconstruction has started from the two locally verified Japanese Pocket Monsters Midori ROMs.

## Reconstructed ranges

| Range | File | Status |
| --- | --- | --- |
| `$0000-$0067` | `asm/rom0/vectors.asm` | Reconstructed; Timer target differs by revision |
| `$0100-$014F` | `asm/rom0/header.asm` | Reconstructed for Rev 0 and Rev A |
| `$0150-$01C3` | `asm/rom0/bootstrap.asm` | Reconstructed instruction-for-instruction |

The bytes at `$0068-$00FF` are not yet classified. They differ heavily between revisions and are deliberately not mislabeled as executable code.

## Confirmed behavior in `$0150-$01C3`

- `$0150` transfers control to `$09DA` in both revisions.
- `$0153` temporarily selects ROM bank 3, calls `$4000`, and restores the previous bank.
- `$0167` waits for LY `$91`, clears LCDC bit 7, and temporarily masks IE bit 0 while doing so.
- `$0181` sets LCDC bit 7.
- `$0188` clears `$A0` bytes beginning at WRAM `$C300`.
- `$0193` writes `$A0` to 40 entries spaced four bytes apart from `$C300`.
- `$01A3` switches to the ROM bank passed in A, copies BC bytes from HL to DE, then restores the previous bank.
- `$01BB` is the underlying BC-byte copy loop.

Names such as `ClearC300Block` remain descriptive rather than semantic until the `$C300` work-RAM structure is independently identified.

## Revision rule

Source shared by both revisions stays common. Revision-specific bytes are guarded explicitly (currently `REV_A`) only where direct comparison proves a difference. Broad raw differences are not automatically treated as logic changes.

## Next targets

1. Follow the bootstrap destination at ROM0 `$09DA`.
2. Reconstruct VBlank `$0AAC`, Timer `$0D9A/$0D88`, and Serial `$0BA7` control flow.
3. Identify WRAM symbols used by the reconstructed routines, including `$FFB8`, `$CEE4`, and `$C300`.
4. Classify `$0068-$00FF` as data/padding/other before source reconstruction.
