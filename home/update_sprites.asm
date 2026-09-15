; Sprite update wrapper. Byte-identical in both revisions.

IF DEF(_REV0)
    ASSERT @ == $0EBD
ELIF DEF(_REVA)
    ASSERT @ == $0EAB
ENDC
UpdateSprites::
    ld a, [wUpdateSpritesEnabled]
    dec a
    ret nz

    ; homecall _UpdateSprites (bank 1, address $4A1D)
    ldh a, [hLoadedROMBank]
    push af
    ld a, $01
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call $4A1D
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

IF DEF(_REV0)
    ASSERT @ == $0ED6
ELIF DEF(_REVA)
    ASSERT @ == $0EC4
ENDC
