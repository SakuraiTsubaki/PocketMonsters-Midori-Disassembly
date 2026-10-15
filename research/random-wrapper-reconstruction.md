# Green Random wrapper reconstruction

Both Japanese Green revisions were SHA-256 gated and independently matched to the complete 17-byte `Random` wrapper. Rev0 places it at `$3e8c` and calls `Bankswitch` at `$3620`; Rev1 uses `$3e7a` and `$360e`. Both far-call the verified `$04:$7fea` `Random_`, return `hRandomAdd=$ffd3` in A, and preserve BC, DE, and HL.

The naming and expansion are based on `pret/pokered@af519899719f0754965776faac0e836a3b906e6d`, `home/random.asm` and `macros/farcall.asm`. Green is Japanese-only. No ROM bytes are published.
