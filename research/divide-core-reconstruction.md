# Green _Divide core reconstruction

The verified `Divide` homecall target begins an exact 136-byte `_Divide` routine in both Japanese Green revisions. Rev0 is the origin reference and rev1 has the same full code hash and HRAM layout. The routine performs restoring long division on one to four big-endian dividend bytes and returns a four-byte quotient plus one-byte remainder.

Naming and control flow follow `pret/pokered@af519899719f0754965776faac0e836a3b906e6d`, `engine/math/multiply_divide.asm`. Reports publish addresses, structure, and hashes without ROM bytes.
