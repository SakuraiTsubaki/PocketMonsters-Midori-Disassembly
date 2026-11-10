SECTION "Jump Table Call Reconstruction", ROM0

CallFunctionInTable::
    push hl
    push de
    push bc
    add a
    ld d, 0
    ld e, a
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, .returnAddress
    push de
    jp hl
.returnAddress
    pop bc
    pop de
    pop hl
    ret
