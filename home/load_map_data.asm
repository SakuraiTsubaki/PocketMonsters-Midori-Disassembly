; Load the current map's graphics, objects, tilemap, palette, and music, then
; provide the adjacent map-bank and overworld-state helper routines.

LoadMapData::
    ldh a, [hLoadedROMBank]
    push af
    call DisableLCD
    ld a, HIGH(vBGMap0)
    ld [wMapViewVRAMPointer + 1], a
    xor a
    ld [wMapViewVRAMPointer], a
    ldh [hSCY], a
    ldh [hSCX], a
    ld [wWalkCounter], a
    ld [wUnusedCurMapTilesetCopy], a
    ld [wWalkBikeSurfStateCopy], a
    ld [wSpriteSetID], a
    call BANK00_LOAD_TEXT_BOX_TILE_PATTERNS_ADDR
    call LoadMapHeader

    ld b, $05
    ld hl, BANK05_INIT_MAP_SPRITES_ADDR
    call BANK00_FARCALL_ADDR

    call LoadTileBlockMap
    call LoadTilesetTilePatternData
    call LoadCurrentMapView

    ld hl, wTileMap
    ld de, vBGMap0
    ld b, SCREEN_HEIGHT
.vramCopyLoop
    ld c, SCREEN_WIDTH
.vramCopyInnerLoop
    ld a, [hli]
    ld [de], a
    inc e
    dec c
    jr nz, .vramCopyInnerLoop
    ld a, TILEMAP_WIDTH - SCREEN_WIDTH
    add e
    ld e, a
    jr nc, .noCarry
    inc d
.noCarry
    dec b
    jr nz, .vramCopyLoop

    ld a, $01
    ld [wUpdateSpritesEnabled], a
    call EnableLCD
    ld b, SET_PAL_OVERWORLD
    call BANK00_RUN_PALETTE_COMMAND_ADDR
    call LoadPlayerSpriteGraphics

    ld a, [wStatusFlags6]
    and (1 << BIT_FLY_WARP) | (1 << BIT_DUNGEON_WARP)
    jr nz, .restoreRomBank
    ld a, [wStatusFlags7]
    bit BIT_NO_MAP_MUSIC, a
    jr nz, .restoreRomBank
    call UpdateMusic6Times
    call PlayDefaultMusicFadeOutCurrent

.restoreRomBank
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

SwitchToMapRomBank::
    push hl
    push bc
    ld c, a
    ld b, $00
    ld a, MAP_HEADER_BANKS_BANK
    call BANK00_BANKSWITCH_HOME_ADDR
    ld hl, BANK03_MAP_HEADER_BANKS_ADDR
    add hl, bc
    ld a, [hl]
    ldh [hMapROMBank], a
    call BANK00_BANKSWITCH_BACK_ADDR
    ldh a, [hMapROMBank]
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    pop bc
    pop hl
    ret

IgnoreInputForHalfSecond::
    ld a, 30
    ld [wIgnoreInputCounter], a
    ld hl, wFlags_D6AF
    ld a, [hl]
    or (1 << BIT_DISABLE_JOYPAD) | (1 << BIT_UNKNOWN_5_2) | (1 << BIT_UNKNOWN_5_1)
    ld [hl], a
    ret

ResetUsingStrengthOutOfBattleBit::
    ld hl, wStatusFlags1
    res BIT_STRENGTH_ACTIVE, [hl]
    ret

ForceBikeOrSurf::
    ld b, PLAYER_SPRITE_GFX_BANK
    ld hl, LoadPlayerSpriteGraphics
    call BANK00_FARCALL_ADDR
    jp PlayDefaultMusic

IF DEF(_REV0)
    ASSERT @ == $2D09
ELIF DEF(_REVA)
    ASSERT @ == $2CF7
ENDC
