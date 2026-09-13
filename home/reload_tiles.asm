; Reload current map graphics after menus and select a Fly destination.

ReloadMapData::
    ldh a, [hLoadedROMBank]
    push af
    ld a, [wCurMap]
    call BANK00_SWITCH_TO_MAP_ROM_BANK_ADDR
    call DisableLCD
    call BANK00_LOAD_TEXT_BOX_TILE_PATTERNS_ADDR
    call BANK00_LOAD_CURRENT_MAP_VIEW_ADDR
    call BANK00_LOAD_TILESET_TILE_PATTERN_DATA_ADDR
    call EnableLCD
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

ReloadTilesetTilePatterns::
    ldh a, [hLoadedROMBank]
    push af
    ld a, [wCurMap]
    call BANK00_SWITCH_TO_MAP_ROM_BANK_ADDR
    call DisableLCD
    call BANK00_LOAD_TILESET_TILE_PATTERN_DATA_ADDR
    call EnableLCD
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

ChooseFlyDestination::
    ld hl, wStatusFlags4
    res BIT_NO_BATTLES, [hl]
    ld b, BANK_TOWN_MAP_FLY
    ld hl, TOWN_MAP_FLY_ADDR
    jp BANK00_FARCALL_ADDR

IF DEF(_REV0)
    ASSERT @ == $1BCB
ELIF DEF(_REVA)
    ASSERT @ == $1BB9
ENDC
