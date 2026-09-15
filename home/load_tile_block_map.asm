; Build the current map block buffer with a three-block connection border.

LoadTileBlockMap::
    ld hl, wOverworldMap
    ld a, [wMapBackgroundTile]
    ld d, a
    ld bc, OVERWORLD_MAP_SIZE
.backgroundTileLoop
    ld a, d
    ld [hli], a
    dec bc
    ld a, c
    or b
    jr nz, .backgroundTileLoop

    ld hl, wOverworldMap
    ld a, [wCurMapWidth]
    ldh [hMapWidth], a
    add MAP_BORDER * 2
    ldh [hMapStride], a
    ld b, 0
    ld c, a
    add hl, bc
    add hl, bc
    add hl, bc
    ld c, MAP_BORDER
    add hl, bc

    ld a, [wCurMapDataPtr]
    ld e, a
    ld a, [wCurMapDataPtr + 1]
    ld d, a
    ld a, [wCurMapHeight]
    ld b, a
.rowLoop
    push hl
    ldh a, [hMapWidth]
    ld c, a
.rowInnerLoop
    ld a, [de]
    inc de
    ld [hli], a
    dec c
    jr nz, .rowInnerLoop
    pop hl
    ldh a, [hMapStride]
    add l
    ld l, a
    jr nc, .noCarry
    inc h
.noCarry
    dec b
    jr nz, .rowLoop

    ld a, [wNorthConnectedMap]
    cp $FF
    jr z, .southConnection
    call BANK00_SWITCH_TO_MAP_ROM_BANK_ADDR
    ld a, [wNorthConnectionStripSrc]
    ld l, a
    ld a, [wNorthConnectionStripSrc + 1]
    ld h, a
    ld a, [wNorthConnectionStripDest]
    ld e, a
    ld a, [wNorthConnectionStripDest + 1]
    ld d, a
    ld a, [wNorthConnectionStripLength]
    ldh [hNorthSouthConnectionStripWidth], a
    ld a, [wNorthConnectedMapWidth]
    ldh [hNorthSouthConnectedMapWidth], a
    call LoadNorthSouthConnectionsTileMap

.southConnection
    ld a, [wSouthConnectedMap]
    cp $FF
    jr z, .westConnection
    call BANK00_SWITCH_TO_MAP_ROM_BANK_ADDR
    ld a, [wSouthConnectionStripSrc]
    ld l, a
    ld a, [wSouthConnectionStripSrc + 1]
    ld h, a
    ld a, [wSouthConnectionStripDest]
    ld e, a
    ld a, [wSouthConnectionStripDest + 1]
    ld d, a
    ld a, [wSouthConnectionStripLength]
    ldh [hNorthSouthConnectionStripWidth], a
    ld a, [wSouthConnectedMapWidth]
    ldh [hNorthSouthConnectedMapWidth], a
    call LoadNorthSouthConnectionsTileMap

.westConnection
    ld a, [wWestConnectedMap]
    cp $FF
    jr z, .eastConnection
    call BANK00_SWITCH_TO_MAP_ROM_BANK_ADDR
    ld a, [wWestConnectionStripSrc]
    ld l, a
    ld a, [wWestConnectionStripSrc + 1]
    ld h, a
    ld a, [wWestConnectionStripDest]
    ld e, a
    ld a, [wWestConnectionStripDest + 1]
    ld d, a
    ld a, [wWestConnectionStripLength]
    ld b, a
    ld a, [wWestConnectedMapWidth]
    ldh [hEastWestConnectedMapWidth], a
    call LoadEastWestConnectionsTileMap

.eastConnection
    ld a, [wEastConnectedMap]
    cp $FF
    jr z, .done
    call BANK00_SWITCH_TO_MAP_ROM_BANK_ADDR
    ld a, [wEastConnectionStripSrc]
    ld l, a
    ld a, [wEastConnectionStripSrc + 1]
    ld h, a
    ld a, [wEastConnectionStripDest]
    ld e, a
    ld a, [wEastConnectionStripDest + 1]
    ld d, a
    ld a, [wEastConnectionStripLength]
    ld b, a
    ld a, [wEastConnectedMapWidth]
    ldh [hEastWestConnectedMapWidth], a
    call LoadEastWestConnectionsTileMap
.done
    ret

LoadNorthSouthConnectionsTileMap::
    ld c, MAP_BORDER
.loop
    push de
    push hl
    ldh a, [hNorthSouthConnectionStripWidth]
    ld b, a
.innerLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .innerLoop
    pop hl
    pop de
    ldh a, [hNorthSouthConnectedMapWidth]
    add l
    ld l, a
    jr nc, .noCarry1
    inc h
.noCarry1
    ld a, [wCurMapWidth]
    add MAP_BORDER * 2
    add e
    ld e, a
    jr nc, .noCarry2
    inc d
.noCarry2
    dec c
    jr nz, .loop
    ret

LoadEastWestConnectionsTileMap::
    push hl
    push de
    ld c, MAP_BORDER
.innerLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .innerLoop
    pop de
    pop hl
    ldh a, [hEastWestConnectedMapWidth]
    add l
    ld l, a
    jr nc, .noCarry1
    inc h
.noCarry1
    ld a, [wCurMapWidth]
    add MAP_BORDER * 2
    add e
    ld e, a
    jr nc, .noCarry2
    inc d
.noCarry2
    dec b
    jr nz, LoadEastWestConnectionsTileMap
    ret

IF DEF(_REV0)
    ASSERT @ == $253A
ELIF DEF(_REVA)
    ASSERT @ == $2528
ENDC
