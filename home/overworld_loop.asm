; First stage of the overworld input/event loop.

OverworldLoop::
    call DelayFrame
OverworldLoopLessDelay::
    call DelayFrame
    call LoadGBPal

    ld a, [wMovementFlags]
    bit BIT_LEDGE_OR_FISHING, a
    call nz, HandleMidJump

    ld a, [wWalkCounter]
    and a
    jp nz, BANK00_OVERWORLD_MOVE_AHEAD_ADDR

    call BANK00_JOYPAD_OVERWORLD_ADDR

    ld b, $07
    ld hl, BANK07_SAFARI_ZONE_CHECK_ADDR
    call BANK00_FARCALL_ADDR
    ld a, [wSafariZoneGameOver]
    and a
    jp nz, BANK00_WARP_FOUND_2_ADDR

    ld hl, wStatusFlags3
    bit BIT_WARP_FROM_CUR_SCRIPT, [hl]
    res BIT_WARP_FROM_CUR_SCRIPT, [hl]
    jp nz, BANK00_WARP_FOUND_2_ADDR

    ld a, [wStatusFlags6]
    and (1 << BIT_FLY_WARP) | (1 << BIT_DUNGEON_WARP)
    jp nz, BANK00_HANDLE_FLY_OR_DUNGEON_WARP_ADDR

    ld a, [wCurOpponent]
    and a
    jp nz, BANK00_OVERWORLD_NEW_BATTLE_ADDR

    ld a, [wStatusFlags5]
    bit BIT_SCRIPTED_MOVEMENT_STATE, a
    jr z, .notSimulating
    ldh a, [hJoyHeld]
    jr .checkIfStartIsPressed
.notSimulating
    ldh a, [hJoyPressed]
.checkIfStartIsPressed
    bit B_PAD_START, a
    jr z, .startButtonNotPressed

    xor a ; TEXT_START_MENU
    ldh [hTextID], a
    jp BANK00_OVERWORLD_DISPLAY_DIALOGUE_ADDR

.startButtonNotPressed

IF DEF(_REV0)
    ASSERT @ == $1E76
ELIF DEF(_REVA)
    ASSERT @ == $1E64
ENDC
