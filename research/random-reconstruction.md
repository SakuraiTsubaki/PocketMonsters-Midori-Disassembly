# Green Random_ reconstruction

Japanese Green rev0 and rev1 were SHA-256 gated and scanned independently. Each contains exactly one complete 17-byte `Random_` shape at bank `$04:$7FEA`.

Both releases have code SHA-256 `4f8dcfd55a40324b60e01baf3a1cfc0263398ba741ad3b73c697de486139d985` and state bytes `hRandomAdd=$FFD3`, `hRandomSub=$FFD4`. They sample `DIV`, update the two states by addition/subtraction with carry, and return the updated subtraction state in A.

Names and semantics are corroborated by `pret/pokered@af519899719f0754965776faac0e836a3b906e6d`, `engine/math/random.asm`. Reports publish identities, locations and hashes without ROM bytes.
