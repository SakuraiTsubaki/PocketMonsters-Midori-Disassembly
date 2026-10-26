# Green CopyData reconstruction

Both catalogued Japanese Green revisions were SHA-256 gated and scanned independently. Each contains exactly one complete nine-byte `CopyData` loop at ROM0 `$01BB` with code SHA-256 `4c81b1d98cede80c642119edcb1c3f45c1f05e97c1d9aafcf250b065f33d495c`.

The routine copies the nonzero BC-byte range at HL to DE, advances both pointers, and returns with BC zero. Green has no official localized releases, so the Japanese revisions are the complete official language set for this repository.

The name and semantics are corroborated by `pret/pokered@af519899719f0754965776faac0e836a3b906e6d`, `home/copy.asm`. Reports publish ROM identities, locations, semantics, and hashes without ROM bytes.
