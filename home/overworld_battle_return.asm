; Post-battle cleanup, battle eligibility and bicycle speed handling.

.battleOccurred
    ld hl, wStatusFlags3
    res BIT_TALKED_TO_TRAINER, [hl]
    ld hl, wStatusFlags7
    res BIT_TRAINER_BATTLE, [hl]
    ld hl, wCurrentMapScriptFlags
    set BIT_CUR_MAP_LOADED_1, [hl]
    set BIT_CUR_MAP_LOADED_2, [hl]
    xor a
    ldh [hJoyHeld], a

    ld a, [wCurMap]
    cp CINNABAR_GYM
    jr nz, .notCinnabarGym
    ld hl, wEventFlagsEvent2A7Byte
    set BIT_EVENT_2A7, [hl]
.notCinnabarGym

    ld hl, wStatusFlags4
    set BIT_BATTLE_OVER_OR_BLACKOUT, [hl]
    ld a, [wCurMap]
    cp OAKS_LAB
    jp z, .noFaintCheck

    ld hl, BANK0F_ANY_PARTY_ALIVE_ADDR
    ld b, $0F
    call BANK00_FARCALL_ADDR
    ld a, d
    and a
    jr z, .allPokemonFainted

.noFaintCheck
    ld c, 10
    call BANK00_DELAY_FRAMES_ADDR
    jp EnterMap

.allPokemonFainted
    ld a, $FF
    ld [wIsInBattle], a
    call BANK00_RUN_MAP_SCRIPT_ADDR
    jp BANK00_HANDLE_BLACK_OUT_ADDR

NewBattle::
    ld a, [wStatusFlags3]
    bit BIT_ON_DUNGEON_WARP, a
    jr nz, .noBattle
    call BANK00_IS_PLAYER_CONTROLLED_ADDR
    jr nz, .noBattle
    ld a, [wStatusFlags4]
    bit BIT_NO_BATTLES, a
    jr nz, .noBattle
    ld b, $0F
    ld hl, BANK0F_INIT_BATTLE_ADDR
    jp BANK00_FARCALL_ADDR
.noBattle
    and a
    ret

DoBikeSpeedup::
    ld a, [wNPCMovementScriptPointerTableNum]
    and a
    ret nz
    ld a, [wCurMap]
    cp ROUTE_17
    jr nz, .goFaster
    ldh a, [hJoyHeld]
    and PAD_UP | PAD_LEFT | PAD_RIGHT
    ret nz
.goFaster
    jp BANK00_ADVANCE_PLAYER_SPRITE_ADDR

IF DEF(_REV0)
    ASSERT @ == $20CB
ELIF DEF(_REVA)
    ASSERT @ == $20B9
ENDC
