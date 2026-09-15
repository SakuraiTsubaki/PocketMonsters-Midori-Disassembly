; Player advancement, step counting and battle/warp handoff.

.moveAhead
    ld a, [wMovementFlags]
    bit BIT_SPINNING, a
    jr z, .noSpinning
    ld b, $11
    ld hl, BANK11_LOAD_SPINNER_ARROW_TILES_ADDR
    call BANK00_FARCALL_ADDR
.noSpinning
    call UpdateSprites

.moveAhead2
    ld hl, wMiscFlags
    res BIT_TURNING, [hl]
    ld a, [wWalkBikeSurfState]
    dec a
    jr nz, .normalPlayerSpriteAdvancement
    ld a, [wMovementFlags]
    bit BIT_LEDGE_OR_FISHING, a
    jr nz, .normalPlayerSpriteAdvancement
    call BANK00_DO_BIKE_SPEEDUP_ADDR
.normalPlayerSpriteAdvancement
    call BANK00_ADVANCE_PLAYER_SPRITE_ADDR
    ld a, [wWalkCounter]
    and a
    jp nz, BANK00_CHECK_MAP_CONNECTIONS_ADDR

    ld a, [wStatusFlags5]
    bit BIT_SCRIPTED_MOVEMENT_STATE, a
    jr nz, .doneStepCounting

    ld hl, wStepCounter
    dec [hl]
    ld a, [wStatusFlags2]
    bit BIT_WILD_ENCOUNTER_COOLDOWN, a
    jr z, .doneStepCounting
    ld hl, wNumberOfNoRandomBattleStepsLeft
    dec [hl]
    jr nz, .doneStepCounting
    ld hl, wStatusFlags2
    res BIT_WILD_ENCOUNTER_COOLDOWN, [hl]

.doneStepCounting
    ld a, [wEventFlagsSafariZoneByte]
    bit BIT_EVENT_IN_SAFARI_ZONE, a
    jr z, .notSafariZone
    ld b, $07
    ld hl, BANK07_SAFARI_ZONE_CHECK_STEPS_ADDR
    call BANK00_FARCALL_ADDR
    ld a, [wSafariZoneGameOver]
    and a
    jp nz, BANK00_WARP_FOUND_2_ADDR
.notSafariZone

    ld a, [wIsInBattle]
    and a
    jp nz, BANK00_CHECK_WARPS_NO_COLLISION_ADDR

    ld a, PREDEF_APPLY_OUT_OF_BATTLE_POISON_DAMAGE
    call BANK00_PREDEF_ADDR
    ld a, [wOutOfBattleBlackout]
    and a
    jp nz, BANK00_HANDLE_BLACK_OUT_ADDR

.newBattle
    call BANK00_NEW_BATTLE_ADDR
    ld hl, wMovementFlags
    res BIT_STANDING_ON_WARP, [hl]
    jp nc, BANK00_CHECK_WARPS_NO_COLLISION_ADDR

IF DEF(_REV0)
    ASSERT @ == $204E
ELIF DEF(_REVA)
    ASSERT @ == $203C
ENDC
