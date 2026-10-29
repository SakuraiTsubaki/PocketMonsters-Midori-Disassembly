SECTION "ClearScreenArea Reconstruction", ROM0

ClearScreenArea::
    ld a, " "
    ld de, SCREEN_WIDTH
.loopRows
    push hl
    push bc
.loopTiles
    ld [hli], a
    dec c
    jr nz, .loopTiles
    pop bc
    pop hl
    add hl, de
    dec b
    jr nz, .loopRows
    ret
