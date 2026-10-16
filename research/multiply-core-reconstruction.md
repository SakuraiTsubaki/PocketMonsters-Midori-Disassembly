# Green _Multiply core reconstruction

The verified wrapper targets bound one exact 100-byte `_Multiply` routine in both Japanese Green revisions. Both have the same full code hash as every verified Red/Blue/Yellow release and use the same HRAM product layout at `$ff95..$ff98`. The routine performs eight shift-add iterations on a three-byte big-endian multiplicand.

Naming follows `pret/pokered@af519899719f0754965776faac0e836a3b906e6d`, `engine/math/multiply_divide.asm`. Reports publish addresses, structure, and hashes without ROM bytes.
