; Home-bank multi-byte division wrapper.
Divide::
    push hl
    push de
    push bc
    homecall _Divide
    pop bc
    pop de
    pop hl
    ret
