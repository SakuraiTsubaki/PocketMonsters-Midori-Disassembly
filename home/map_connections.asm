; Seamless west/east/north/south map-connection transitions.

CheckMapConnections::
    ld a, [wXCoord]
    cp $FF
    jr nz, .checkEastMap
    ld a, [wWestConnectedMap]
    ld [wCurMap], a
    ld a, [wWestConnectedMapXAlignment]
    ld [wXCoord], a
    ld a, [wYCoord]
    ld c, a
    ld a, [wWestConnectedMapYAlignment]
    add c
    ld c, a
    ld [wYCoord], a
    ld a, [wWestConnectedMapViewPointer]
    ld l, a
    ld a, [wWestConnectedMapViewPointer + 1]
    ld h, a
    srl c
    jr z, .savePointer1
.pointerAdjustmentLoop1
    ld a, [wWestConnectedMapWidth]
    add MAP_BORDER * 2
    ld e, a
    ld d, 0
    ld b, 0
    add hl, de
    dec c
    jr nz, .pointerAdjustmentLoop1
.savePointer1
    ld a, l
    ld [wCurrentTileBlockMapViewPointer], a
    ld a, h
    ld [wCurrentTileBlockMapViewPointer + 1], a
    jp .loadNewMap

.checkEastMap
    ld b, a
    ld a, [wCurrentMapWidth2]
    cp b
    jr nz, .checkNorthMap
    ld a, [wEastConnectedMap]
    ld [wCurMap], a
    ld a, [wEastConnectedMapXAlignment]
    ld [wXCoord], a
    ld a, [wYCoord]
    ld c, a
    ld a, [wEastConnectedMapYAlignment]
    add c
    ld c, a
    ld [wYCoord], a
    ld a, [wEastConnectedMapViewPointer]
    ld l, a
    ld a, [wEastConnectedMapViewPointer + 1]
    ld h, a
    srl c
    jr z, .savePointer2
.pointerAdjustmentLoop2
    ld a, [wEastConnectedMapWidth]
    add MAP_BORDER * 2
    ld e, a
    ld d, 0
    ld b, 0
    add hl, de
    dec c
    jr nz, .pointerAdjustmentLoop2
.savePointer2
    ld a, l
    ld [wCurrentTileBlockMapViewPointer], a
    ld a, h
    ld [wCurrentTileBlockMapViewPointer + 1], a
    jp .loadNewMap

.checkNorthMap
    ld a, [wYCoord]
    cp $FF
    jr nz, .checkSouthMap
    ld a, [wNorthConnectedMap]
    ld [wCurMap], a
    ld a, [wNorthConnectedMapYAlignment]
    ld [wYCoord], a
    ld a, [wXCoord]
    ld c, a
    ld a, [wNorthConnectedMapXAlignment]
    add c
    ld c, a
    ld [wXCoord], a
    ld a, [wNorthConnectedMapViewPointer]
    ld l, a
    ld a, [wNorthConnectedMapViewPointer + 1]
    ld h, a
    ld b, 0
    srl c
    add hl, bc
    ld a, l
    ld [wCurrentTileBlockMapViewPointer], a
    ld a, h
    ld [wCurrentTileBlockMapViewPointer + 1], a
    jp .loadNewMap

.checkSouthMap
    ld b, a
    ld a, [wCurrentMapHeight2]
    cp b
    jr nz, .didNotEnterConnectedMap
    ld a, [wSouthConnectedMap]
    ld [wCurMap], a
    ld a, [wSouthConnectedMapYAlignment]
    ld [wYCoord], a
    ld a, [wXCoord]
    ld c, a
    ld a, [wSouthConnectedMapXAlignment]
    add c
    ld c, a
    ld [wXCoord], a
    ld a, [wSouthConnectedMapViewPointer]
    ld l, a
    ld a, [wSouthConnectedMapViewPointer + 1]
    ld h, a
    ld b, 0
    srl c
    add hl, bc
    ld a, l
    ld [wCurrentTileBlockMapViewPointer], a
    ld a, h
    ld [wCurrentTileBlockMapViewPointer + 1], a

.loadNewMap
    call BANK00_LOAD_MAP_HEADER_ADDR
    call BANK00_PLAY_DEFAULT_MUSIC_FADE_ADDR
    ld b, SET_PAL_OVERWORLD
    call BANK00_RUN_PALETTE_COMMAND_ADDR
    ld b, $05
    ld hl, BANK05_INIT_MAP_SPRITES_ADDR
    call BANK00_FARCALL_ADDR
    call BANK00_LOAD_TILE_BLOCK_MAP_ADDR
    jp BANK00_OVERWORLD_LOOP_LESS_DELAY_ADDR

.didNotEnterConnectedMap
    jp OverworldLoop

IF DEF(_REV0)
    ASSERT @ == $22E0
ELIF DEF(_REVA)
    ASSERT @ == $22CE
ENDC
