# Green Multiply wrapper reconstruction

Both Japanese Green revisions contain one verified 13-byte home-bank `Multiply` wrapper. Rev0 places it at `$38f5` and targets `$0d:$7e73` through `Bankswitch` `$3620`; rev1 places it at `$38e3`, retains the same core target, and uses `Bankswitch` `$360e`. It preserves HL/BC and returns after the far call.

Naming and macro expansion follow `pret/pokered@af519899719f0754965776faac0e836a3b906e6d`, `home/math.asm` and `macros/farcall.asm`. No ROM bytes are published.
