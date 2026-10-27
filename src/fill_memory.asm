SECTION "FillMemory Reconstruction", ROM0

FillMemory::
    push de
    ld d, a
.loop
    ld a, d
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    pop de
    ret
