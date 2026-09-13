; Load the current map's fixed header, connection headers, object data,
; sprite definitions, tileset metadata, wild data, and map music.

LoadMapHeader::
    ld b, $03
    ld hl, BANK03_MARK_TOWN_VISITED_AND_LOAD_TOGGLEABLE_OBJECTS_ADDR
    call BANK00_FARCALL_ADDR

    ld a, [wCurMapTileset]
    ld [wUnusedCurMapTilesetCopy], a
    ld a, [wCurMap]
    call BANK00_SWITCH_TO_MAP_ROM_BANK_ADDR

    ld a, [wCurMapTileset]
    ld b, a
    res BIT_NO_PREVIOUS_MAP, a
    ld [wCurMapTileset], a
    ldh [hPreviousTileset], a
    bit BIT_NO_PREVIOUS_MAP, b
    ret nz

    ld hl, MapHeaderPointers
    ld a, [wCurMap]
    sla a
    jr nc, .noCarry1
    inc h
.noCarry1
    add l
    ld l, a
    jr nc, .noCarry2
    inc h
.noCarry2
    ld a, [hli]
    ld h, [hl]
    ld l, a

    ld de, wCurMapHeader
    ld c, CUR_MAP_HEADER_LENGTH
.copyFixedHeaderLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .copyFixedHeaderLoop

    ld a, $FF
    ld [wNorthConnectedMap], a
    ld [wSouthConnectedMap], a
    ld [wWestConnectedMap], a
    ld [wEastConnectedMap], a

    ld a, [wCurMapConnections]
    ld b, a
    bit NORTH_F, b
    jr z, .checkSouth
    ld de, wNorthConnectedMap
    call CopyMapConnectionHeader
.checkSouth
    bit SOUTH_F, b
    jr z, .checkWest
    ld de, wSouthConnectedMap
    call CopyMapConnectionHeader
.checkWest
    bit WEST_F, b
    jr z, .checkEast
    ld de, wWestConnectedMap
    call CopyMapConnectionHeader
.checkEast
    bit EAST_F, b
    jr z, .getObjectDataPointer
    ld de, wEastConnectedMap
    call CopyMapConnectionHeader

.getObjectDataPointer
    ld a, [hli]
    ld [wObjectDataPointerTemp], a
    ld a, [hli]
    ld [wObjectDataPointerTemp + 1], a
    push hl
    ld a, [wObjectDataPointerTemp]
    ld l, a
    ld a, [wObjectDataPointerTemp + 1]
    ld h, a

    ld de, wMapBackgroundTile
    ld a, [hli]
    ld [de], a

    ld a, [hli]
    ld [wNumberOfWarps], a
    and a
    jr z, .loadSignData
    ld c, a
    ld de, wWarpEntries
.warpLoop
    ld b, 4
.warpInnerLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .warpInnerLoop
    dec c
    jr nz, .warpLoop

.loadSignData
    ld a, [hli]
    ld [wNumSigns], a
    and a
    jr z, .loadSpriteData
    ld c, a
    ld de, wSignTextIDs
    ld a, d
    ldh [hSignCoordPointer], a
    ld a, e
    ldh [hSignCoordPointer + 1], a
    ld de, wSignCoords
.signLoop
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    push de
    ldh a, [hSignCoordPointer]
    ld d, a
    ldh a, [hSignCoordPointer + 1]
    ld e, a
    ld a, [hli]
    ld [de], a
    inc de
    ld a, d
    ldh [hSignCoordPointer], a
    ld a, e
    ldh [hSignCoordPointer + 1], a
    pop de
    dec c
    jr nz, .signLoop

.loadSpriteData
    ld a, [wStatusFlags4]
    bit BIT_BATTLE_OVER_OR_BLACKOUT, a
    jp nz, .finishUp

    ld a, [hli]
    ld [wNumSprites], a
    push hl

    ld hl, wSprite01StateData1
    ld de, wSprite01StateData2
    xor a
    ld b, $F0
.zeroSpriteDataLoop
    ld [hli], a
    ld [de], a
    inc e
    dec b
    jr nz, .zeroSpriteDataLoop

    ld hl, wSprite01StateData1ImageIndex
    ld de, SPRITESTATEDATA1_LENGTH
    ld c, NUM_SPRITESTATEDATA_STRUCTS - 1
.disableSpriteEntriesLoop
    ld [hl], $FF
    add hl, de
    dec c
    jr nz, .disableSpriteEntriesLoop

    pop hl
    ld de, wSprite01StateData1
    ld a, [wNumSprites]
    and a
    jp z, .finishUp
    ld b, a
    ld c, $00

.loadSpriteLoop
    ld a, [hli]
    ld [de], a
    inc d
    ld a, $04
    add e
    ld e, a
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ldh [hLoadSpriteTemp1], a
    ld a, [hli]
    ldh [hLoadSpriteTemp2], a

    push bc
    push hl
    ld b, $00
    ld hl, wMapSpriteData
    add hl, bc
    ldh a, [hLoadSpriteTemp1]
    ld [hli], a
    ldh a, [hLoadSpriteTemp2]
    ld [hl], a
    ldh a, [hLoadSpriteTemp2]
    ldh [hLoadSpriteTemp1], a
    and $3F
    ld [hl], a
    pop hl

    ldh a, [hLoadSpriteTemp1]
    bit BIT_TRAINER, a
    jr nz, .trainerSprite
    bit BIT_ITEM, a
    jr nz, .itemBallSprite
    jr .regularSprite

.trainerSprite
    ld a, [hli]
    ldh [hLoadSpriteTemp1], a
    ld a, [hli]
    ldh [hLoadSpriteTemp2], a
    push hl
    ld hl, wMapSpriteExtraData
    add hl, bc
    ldh a, [hLoadSpriteTemp1]
    ld [hli], a
    ldh a, [hLoadSpriteTemp2]
    ld [hl], a
    pop hl
    jr .nextSprite

.itemBallSprite
    ld a, [hli]
    ldh [hLoadSpriteTemp1], a
    push hl
    ld hl, wMapSpriteExtraData
    add hl, bc
    ldh a, [hLoadSpriteTemp1]
    ld [hli], a
    xor a
    ld [hl], a
    pop hl
    jr .nextSprite

.regularSprite
    push hl
    ld hl, wMapSpriteExtraData
    add hl, bc
    xor a
    ld [hli], a
    ld [hl], a
    pop hl

.nextSprite
    pop bc
    dec d
    ld a, $0A
    add e
    ld e, a
    inc c
    inc c
    dec b
    jp nz, .loadSpriteLoop

.finishUp
    ld a, PREDEF_LOAD_TILESET_HEADER
    call BANK00_PREDEF_ADDR

    ld hl, BANK03_LOAD_WILD_DATA_ADDR
    ld b, $03
    call BANK00_FARCALL_ADDR

    pop hl
    ld a, [wCurMapHeight]
    add a
    ld [wCurrentMapHeight2], a
    ld a, [wCurMapWidth]
    add a
    ld [wCurrentMapWidth2], a

    ld a, [wCurMap]
    ld c, a
    ld b, $00
    ldh a, [hLoadedROMBank]
    push af
    ld a, MAP_SONGS_BANK
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ld hl, BANK03_MAP_SONGS_ADDR
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld [wMapMusicSoundID], a
    ld a, [hl]
    ld [wMapMusicROMBank], a
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

CopyMapConnectionHeader::
    ld c, $0B
.loop
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ret

IF DEF(_REV0)
    ASSERT @ == $2C52
ELIF DEF(_REVA)
    ASSERT @ == $2C40
ENDC
