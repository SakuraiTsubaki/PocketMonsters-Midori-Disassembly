; A-button interaction and dialogue handling in the overworld loop.

    bit B_PAD_A, a
    jp z, BANK00_CHECK_IF_DOWN_BUTTON_ADDR

    ld a, [wStatusFlags5]
    bit BIT_UNKNOWN_5_2, a
    jp nz, .noDirectionButtonsPressed

    call BANK00_IS_PLAYER_CONTROLLED_ADDR
    jr nz, .checkForOpponent

    call BANK00_CHECK_HIDDEN_EVENT_ADDR
    ldh a, [hItemAlreadyFound]
    and a
    jp z, OverworldLoop

    call BANK00_IS_SPRITE_OR_SIGN_FRONT_ADDR
    ldh a, [hTextID]
    and a
    jp z, OverworldLoop

.displayDialogue
    ld a, PREDEF_GET_TILE_AND_COORDS_IN_FRONT
    call BANK00_PREDEF_ADDR
    call UpdateSprites

    ld a, [wMiscFlags]
    bit BIT_TURNING, a
    jr nz, .checkForOpponent
    bit BIT_SEEN_BY_TRAINER, a
    jr nz, .checkForOpponent

    call DisplayTextID
    ld a, [wEnteringCableClub]
    and a
    jr z, .checkForOpponent

    dec a
    ld a, 0
    ld [wEnteringCableClub], a
    jr z, .changeMap

    ld a, PREDEF_TRY_LOAD_SAVE_FILE
    call BANK00_PREDEF_ADDR
    ld a, [wCurMap]
    ld [wDestinationMap], a
    call BANK00_PREPARE_FOR_SPECIAL_WARP_ADDR
    ld a, [wCurMap]
    call BANK00_SWITCH_TO_MAP_ROM_BANK_ADDR
    ld hl, wCurMapTileset
    set BIT_NO_PREVIOUS_MAP, [hl]

.changeMap
    jp EnterMap

.checkForOpponent
    ld a, [wCurOpponent]
    and a
    jp nz, BANK00_OVERWORLD_NEW_BATTLE_ADDR
    jp OverworldLoop

.noDirectionButtonsPressed
    ld hl, wMiscFlags
    res BIT_TURNING, [hl]
    call UpdateSprites
    ld a, 1
    ld [wCheckFor180DegreeTurn], a
    ld a, [wPlayerMovingDirection]
    and a
    jp z, OverworldLoop
    ld [wPlayerLastStopDirection], a
    xor a
    ld [wPlayerMovingDirection], a
    jp OverworldLoop

IF DEF(_REV0)
    ASSERT @ == $1F02
ELIF DEF(_REVA)
    ASSERT @ == $1EF0
ENDC
