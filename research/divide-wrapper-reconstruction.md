# Green Divide wrapper reconstruction

Both Japanese Green revisions place a 27-byte `Divide` wrapper immediately after `Multiply`. This early homecall form reads `hLoadedROMBank` with an absolute load, saves it, selects bank `$0d`, calls `_Divide` at `$7ed7`, restores the previous bank and AF/BC/DE/HL, and returns.

Naming follows `pret/pokered@af519899719f0754965776faac0e836a3b906e6d`, `home/math.asm` and `macros/farcall.asm`. No ROM bytes are published.
