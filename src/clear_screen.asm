SECTION "ClearScreen Reconstruction", ROM0

ClearScreen::
    ld bc, SCREEN_AREA
    inc b
    ld hl, wTileMap
    ld a, " "
.loop
    ld [hli], a
    dec c
    jr nz, .loop
    dec b
    jr nz, .loop
    jp Delay3
