# Game Boy header logo extraction

The Japanese origin candidate contributes the fixed 48-byte header logo at ROM range `0x0104`–`0x0133`. The shared extractor decodes twenty-four 4×4 one-bit tiles arranged 12×2 and writes a deterministic 384×64 nearest-neighbor PNG from the logical 48×8 raster.

The manifest binds the exact local ROM identity, source-slice hash, analysis report, and PNG hash. No ROM binary or raw ROM slice is stored, and the candidate release status is unchanged.

