# Green BattleRandom reconstruction

Both Japanese Green revisions independently match the complete 56-byte link-synchronised routine. Rev0 is at `$0f:$718d`; Rev1 at `$0f:$7192`. Both use link state `$d0f0`, index `$ccde`, list `$d10d`, and link-battle value `$04`. Non-link execution jumps to the matching `Random`; the boundary refresh applies `5x+1` to nine seeds in the shared ten-byte list.

The naming and semantics follow `pret/pokered@af519899719f0754965776faac0e836a3b906e6d`, `engine/battle/core.asm`. No ROM bytes are published.
