# Japanese startup main block

The cartridge entry chain reaches `0x09DA`. This verified 52-byte basic
block disables interrupts, clears hardware registers, calls `0x0167`, sets
the stack, and clears the 8 KiB WRAM range beginning at `0xC000`. Its bytes
match Aka at this boundary, while ROM identity remains independently bound.
This does not promote the release candidate to verified.

