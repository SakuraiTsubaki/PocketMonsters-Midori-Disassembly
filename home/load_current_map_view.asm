; Expand visible block IDs into tiles and copy the 20x18 viewport buffer.

LoadCurrentMapView::
    ldh a, [hLoadedROMBank]
    push af
    ld a, [wTilesetBank]
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ld a, [wCurrentTileBlockMapViewPointer]
    ld e, a
    ld a, [wCurrentTileBlockMapViewPointer + 1]
    ld d, a
    ld hl, wSurroundingTiles
    ld b, SCREEN_BLOCK_HEIGHT
.rowLoop
    push hl
    push de
    ld c, SCREEN_BLOCK_WIDTH
.rowInnerLoop
    push bc
    push de
    push hl
    ld a, [de]
    ld c, a
    call BANK00_DRAW_TILE_BLOCK_ADDR
    pop hl
    pop de
    pop bc
    inc hl
    inc hl
    inc hl
    inc hl
    inc de
    dec c
    jr nz, .rowInnerLoop
    pop de
    ld a, [wCurMapWidth]
    add MAP_BORDER * 2
    add e
    ld e, a
    jr nc, .noCarry
    inc d
.noCarry
    pop hl
    ld a, SURROUNDING_WIDTH * BLOCK_HEIGHT
    add l
    ld l, a
    jr nc, .noCarry2
    inc h
.noCarry2
    dec b
    jr nz, .rowLoop

    ld hl, wSurroundingTiles
    ld bc, 0
    ld a, [wYBlockCoord]
    and a
    jr z, .adjustForXCoordWithinTileBlock
    ld bc, SURROUNDING_WIDTH * 2
    add hl, bc
.adjustForXCoordWithinTileBlock
    ld a, [wXBlockCoord]
    and a
    jr z, .copyToVisibleAreaBuffer
    ld bc, 2
    add hl, bc

.copyToVisibleAreaBuffer
    ld de, wTileMap
    ld b, SCREEN_HEIGHT
.rowLoop2
    ld c, SCREEN_WIDTH
.rowInnerLoop2
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .rowInnerLoop2
    ld a, SURROUNDING_WIDTH - SCREEN_WIDTH
    add l
    ld l, a
    jr nc, .noCarry3
    inc h
.noCarry3
    dec b
    jr nz, .rowLoop2

    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

IF DEF(_REV0)
    ASSERT @ == $2738
ELIF DEF(_REVA)
    ASSERT @ == $2726
ENDC
