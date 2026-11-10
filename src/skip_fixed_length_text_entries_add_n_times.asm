SECTION "Array Stride Reconstruction", ROM0

SkipFixedLengthTextEntries::
    and a
    ret z
    ld bc, NAME_LENGTH
.skipLoop
    add hl, bc
    dec a
    jr nz, .skipLoop
    ret

AddNTimes::
    and a
    ret z
.loop
    add hl, bc
    dec a
    jr nz, .loop
    ret
