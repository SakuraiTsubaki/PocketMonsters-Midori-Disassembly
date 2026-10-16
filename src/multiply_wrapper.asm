; Home-bank 24-bit multiplication wrapper.
Multiply::
    push hl
    push bc
    callfar _Multiply
    pop bc
    pop hl
    ret
