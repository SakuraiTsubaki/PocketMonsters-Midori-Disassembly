; Count the set bits in b bytes starting at hl.

CountSetBits::
    ld c, 0
.loop
    ld a, [hli]
    ld e, a
    ld d, 8
.innerLoop
    srl e
    ld a, 0
    adc c
    ld c, a
    dec d
    jr nz, .innerLoop
    dec b
    jr nz, .loop
    ld a, c
    ld [wNumSetBits], a
    ret

IF DEF(_REV0)
    ASSERT @ == $16A7
ELIF DEF(_REVA)
    ASSERT @ == $1695
ENDC
