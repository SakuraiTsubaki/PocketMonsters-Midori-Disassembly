; Start Menu dispatcher and selection loop.

DisplayStartMenu::
    ld a, $04
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ld a, [wWalkBikeSurfState]
    ld [wWalkBikeSurfStateCopy], a
    ld a, SFX_START_MENU
    call BANK00_PLAY_SOUND_ADDR

RedisplayStartMenu::
    ; farcall DrawStartMenu
    ld b, $01
    ld hl, BANK01_DRAW_START_MENU_ADDR
    call BANK00_FARCALL_ADDR

    ; farcall PrintSafariZoneSteps
    ld b, $03
    ld hl, BANK03_PRINT_SAFARI_ZONE_STEPS_ADDR
    call BANK00_FARCALL_ADDR

    call UpdateSprites

.loop
    call BANK00_HANDLE_MENU_INPUT_ADDR
    ld b, a

    bit 6, a
    jr z, .checkIfDownPressed
    ld a, [wCurrentMenuItem]
    and a
    jr nz, .loop
    ld a, [wLastMenuItem]
    and a
    jr nz, .loop

    ld a, [wEventFlagsGotPokedexByte]
    bit EVENT_GOT_POKEDEX_BIT, a
    ld a, 6
    jr nz, .wrapMenuItemId
    dec a
.wrapMenuItemId
    ld [wCurrentMenuItem], a
    call BANK00_ERASE_MENU_CURSOR_ADDR
    jr .loop

.checkIfDownPressed
    bit 7, a
    jr z, .buttonPressed

    ld a, [wEventFlagsGotPokedexByte]
    bit EVENT_GOT_POKEDEX_BIT, a
    ld a, [wCurrentMenuItem]
    ld c, 7
    jr nz, .checkIfPastBottom
    dec c
.checkIfPastBottom
    cp c
    jr nz, .loop
    xor a
    ld [wCurrentMenuItem], a
    call BANK00_ERASE_MENU_CURSOR_ADDR
    jr .loop

.buttonPressed
    call BANK00_PLACE_UNFILLED_ARROW_MENU_CURSOR_ADDR
    ld a, [wCurrentMenuItem]
    ld [wBattleAndStartSavedMenuItem], a
    ld a, b
    and PAD_B | PAD_START
    jp nz, CloseStartMenu

    call BANK00_SAVE_SCREEN_TILES_2_ADDR
    ld a, [wEventFlagsGotPokedexByte]
    bit EVENT_GOT_POKEDEX_BIT, a
    ld a, [wCurrentMenuItem]
    jr nz, .displayMenuItem
    inc a
.displayMenuItem
    cp 0
    jp z, BANK04_START_MENU_POKEDEX_ADDR
    cp 1
    jp z, BANK04_START_MENU_POKEMON_ADDR
    cp 2
    jp z, BANK04_START_MENU_ITEM_ADDR
    cp 3
    jp z, BANK04_START_MENU_TRAINER_INFO_ADDR
    cp 4
    jp z, BANK04_START_MENU_SAVE_RESET_ADDR
    cp 5
    jp z, BANK04_START_MENU_OPTION_ADDR

CloseStartMenu::
    call Joypad
    ldh a, [hJoyPressed]
    bit 0, a
    jr nz, CloseStartMenu
    call BANK00_LOAD_TEXT_BOX_TILE_PATTERNS_ADDR
    jp CloseTextDisplay

IF DEF(_REV0)
    ASSERT @ == $1690
ELIF DEF(_REVA)
    ASSERT @ == $167E
ENDC
