SECTION "Array Search Reconstruction", ROM0

IsInArray::
    ld b, 0
IsInRestOfArray::
    ld c, a
.loop
    ld a, [hl]
    cp -1
    jr z, .notfound
    cp c
    jr z, .found
    inc b
    add hl, de
    jr .loop
.notfound
    and a
    ret
.found
    scf
    ret
