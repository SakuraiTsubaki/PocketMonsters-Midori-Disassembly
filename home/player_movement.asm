; Advance the player sprite, scroll the map, schedule redraws, and draw blocks.

AdvancePlayerSprite::
    ld a, [wSpritePlayerStateData1YStepVector]
    ld b, a
    ld a, [wSpritePlayerStateData1XStepVector]
    ld c, a
    ld hl, wWalkCounter
    dec [hl]
    jr nz, .afterUpdateMapCoords
    ld a, [wYCoord]
    add b
    ld [wYCoord], a
    ld a, [wXCoord]
    add c
    ld [wXCoord], a
.afterUpdateMapCoords
    ld a, [wWalkCounter]
    cp $07
    jp nz, .scrollBackgroundAndSprites

    ld a, c
    cp $01
    jr nz, .checkIfMovingWest
    ld a, [wMapViewVRAMPointer]
    ld e, a
    and $E0
    ld d, a
    ld a, e
    add $02
    and $1F
    or d
    ld [wMapViewVRAMPointer], a
    jr .adjustXCoordWithinBlock
.checkIfMovingWest
    cp $FF
    jr nz, .checkIfMovingSouth
    ld a, [wMapViewVRAMPointer]
    ld e, a
    and $E0
    ld d, a
    ld a, e
    sub $02
    and $1F
    or d
    ld [wMapViewVRAMPointer], a
    jr .adjustXCoordWithinBlock
.checkIfMovingSouth
    ld a, b
    cp $01
    jr nz, .checkIfMovingNorth
    ld a, [wMapViewVRAMPointer]
    add $40
    ld [wMapViewVRAMPointer], a
    jr nc, .adjustXCoordWithinBlock
    ld a, [wMapViewVRAMPointer + 1]
    inc a
    and $03
    or $98
    ld [wMapViewVRAMPointer + 1], a
    jr .adjustXCoordWithinBlock
.checkIfMovingNorth
    cp $FF
    jr nz, .adjustXCoordWithinBlock
    ld a, [wMapViewVRAMPointer]
    sub $40
    ld [wMapViewVRAMPointer], a
    jr nc, .adjustXCoordWithinBlock
    ld a, [wMapViewVRAMPointer + 1]
    dec a
    and $03
    or $98
    ld [wMapViewVRAMPointer + 1], a

.adjustXCoordWithinBlock
    ld a, c
    and a
    jr z, .pointlessJump
.pointlessJump
    ld hl, wXBlockCoord
    ld a, [hl]
    add c
    ld [hl], a
    cp $02
    jr nz, .checkForMoveToWestBlock
    xor a
    ld [hl], a
    ld hl, wXOffsetSinceLastSpecialWarp
    inc [hl]
    ld de, wCurrentTileBlockMapViewPointer
    call MoveTileBlockMapPointerEast
    jr .updateMapView
.checkForMoveToWestBlock
    cp $FF
    jr nz, .adjustYCoordWithinBlock
    ld a, $01
    ld [hl], a
    ld hl, wXOffsetSinceLastSpecialWarp
    dec [hl]
    ld de, wCurrentTileBlockMapViewPointer
    call MoveTileBlockMapPointerWest
    jr .updateMapView

.adjustYCoordWithinBlock
    ld hl, wYBlockCoord
    ld a, [hl]
    add b
    ld [hl], a
    cp $02
    jr nz, .checkForMoveToNorthBlock
    xor a
    ld [hl], a
    ld hl, wYOffsetSinceLastSpecialWarp
    inc [hl]
    ld de, wCurrentTileBlockMapViewPointer
    ld a, [wCurMapWidth]
    call MoveTileBlockMapPointerSouth
    jr .updateMapView
.checkForMoveToNorthBlock
    cp $FF
    jr nz, .updateMapView
    ld a, $01
    ld [hl], a
    ld hl, wYOffsetSinceLastSpecialWarp
    dec [hl]
    ld de, wCurrentTileBlockMapViewPointer
    ld a, [wCurMapWidth]
    call MoveTileBlockMapPointerNorth

.updateMapView
    call LoadCurrentMapView
    ld a, [wSpritePlayerStateData1YStepVector]
    cp $01
    jr nz, .checkIfMovingNorth2
    call ScheduleSouthRowRedraw
    jr .scrollBackgroundAndSprites
.checkIfMovingNorth2
    cp $FF
    jr nz, .checkIfMovingEast2
    call ScheduleNorthRowRedraw
    jr .scrollBackgroundAndSprites
.checkIfMovingEast2
    ld a, [wSpritePlayerStateData1XStepVector]
    cp $01
    jr nz, .checkIfMovingWest2
    call ScheduleEastColumnRedraw
    jr .scrollBackgroundAndSprites
.checkIfMovingWest2
    cp $FF
    jr nz, .scrollBackgroundAndSprites
    call ScheduleWestColumnRedraw

.scrollBackgroundAndSprites
    ld a, [wSpritePlayerStateData1YStepVector]
    ld b, a
    ld a, [wSpritePlayerStateData1XStepVector]
    ld c, a
    sla b
    sla c
    ldh a, [hSCY]
    add b
    ldh [hSCY], a
    ldh a, [hSCX]
    add c
    ldh [hSCX], a
    ld hl, wSprite01StateData1YPixels
    ld a, [wNumSprites]
    and a
    jr z, .done
    ld e, a
.spriteShiftLoop
    ld a, [hl]
    sub b
    ld [hli], a
    inc l
    ld a, [hl]
    sub c
    ld [hl], a
    ld a, $0E
    add l
    ld l, a
    dec e
    jr nz, .spriteShiftLoop
.done
    ret

MoveTileBlockMapPointerEast::
    ld a, [de]
    add $01
    ld [de], a
    ret nc
    inc de
    ld a, [de]
    inc a
    ld [de], a
    ret

MoveTileBlockMapPointerWest::
    ld a, [de]
    sub $01
    ld [de], a
    ret nc
    inc de
    ld a, [de]
    dec a
    ld [de], a
    ret

MoveTileBlockMapPointerSouth::
    add MAP_BORDER * 2
    ld b, a
    ld a, [de]
    add b
    ld [de], a
    ret nc
    inc de
    ld a, [de]
    inc a
    ld [de], a
    ret

MoveTileBlockMapPointerNorth::
    add MAP_BORDER * 2
    ld b, a
    ld a, [de]
    sub b
    ld [de], a
    ret nc
    inc de
    ld a, [de]
    dec a
    ld [de], a
    ret

ScheduleNorthRowRedraw::
    ld hl, wTileMap
    call CopyToRedrawRowOrColumnSrcTiles
    ld a, [wMapViewVRAMPointer]
    ldh [hRedrawRowOrColumnDest], a
    ld a, [wMapViewVRAMPointer + 1]
    ldh [hRedrawRowOrColumnDest + 1], a
    ld a, REDRAW_ROW
    ldh [hRedrawRowOrColumnMode], a
    ret

CopyToRedrawRowOrColumnSrcTiles::
    ld de, wRedrawRowOrColumnSrcTiles
    ld c, 2 * SCREEN_WIDTH
.loop
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ret

ScheduleSouthRowRedraw::
    ld hl, wTileMap + 16 * SCREEN_WIDTH
    call CopyToRedrawRowOrColumnSrcTiles
    ld a, [wMapViewVRAMPointer]
    ld l, a
    ld a, [wMapViewVRAMPointer + 1]
    ld h, a
    ld bc, $0200
    add hl, bc
    ld a, h
    and $03
    or $98
    ldh [hRedrawRowOrColumnDest + 1], a
    ld a, l
    ldh [hRedrawRowOrColumnDest], a
    ld a, REDRAW_ROW
    ldh [hRedrawRowOrColumnMode], a
    ret

ScheduleEastColumnRedraw::
    ld hl, wTileMap + 18
    call ScheduleColumnRedrawHelper
    ld a, [wMapViewVRAMPointer]
    ld c, a
    and $E0
    ld b, a
    ld a, c
    add 18
    and $1F
    or b
    ldh [hRedrawRowOrColumnDest], a
    ld a, [wMapViewVRAMPointer + 1]
    ldh [hRedrawRowOrColumnDest + 1], a
    ld a, REDRAW_COL
    ldh [hRedrawRowOrColumnMode], a
    ret

ScheduleColumnRedrawHelper::
    ld de, wRedrawRowOrColumnSrcTiles
    ld c, SCREEN_HEIGHT
.loop
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    inc de
    ld a, SCREEN_WIDTH - 1
    add l
    ld l, a
    jr nc, .noCarry
    inc h
.noCarry
    dec c
    jr nz, .loop
    ret

ScheduleWestColumnRedraw::
    ld hl, wTileMap
    call ScheduleColumnRedrawHelper
    ld a, [wMapViewVRAMPointer]
    ldh [hRedrawRowOrColumnDest], a
    ld a, [wMapViewVRAMPointer + 1]
    ldh [hRedrawRowOrColumnDest + 1], a
    ld a, REDRAW_COL
    ldh [hRedrawRowOrColumnMode], a
    ret

DrawTileBlock::
    push hl
    ld a, [wTilesetBlocksPtr]
    ld l, a
    ld a, [wTilesetBlocksPtr + 1]
    ld h, a
    ld a, c
    swap a
    ld b, a
    and $F0
    ld c, a
    ld a, b
    and $0F
    ld b, a
    add hl, bc
    ld d, h
    ld e, l
    pop hl
    ld c, BLOCK_HEIGHT
.loop
    push bc
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hl], a
    inc de
    ld bc, SURROUNDING_WIDTH - (BLOCK_WIDTH - 1)
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    ret

IF DEF(_REV0)
    ASSERT @ == $295E
ELIF DEF(_REVA)
    ASSERT @ == $294C
ENDC
