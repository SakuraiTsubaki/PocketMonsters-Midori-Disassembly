; Overworld jump handoff and map-entry setup.

HandleMidJump::
    ld b, $1C
    ld hl, BANK1C_HANDLE_MID_JUMP_ADDR
    jp BANK00_FARCALL_ADDR

EnterMap::
    ld a, PAD_BUTTONS | PAD_CTRL_PAD
    ld [wJoyIgnore], a
    call BANK00_LOAD_MAP_DATA_ADDR

    ld b, $03
    ld hl, BANK03_CLEAR_VARIABLES_ON_ENTER_MAP_ADDR
    call BANK00_FARCALL_ADDR

    ld hl, wStatusFlags2
    bit BIT_WILD_ENCOUNTER_COOLDOWN, [hl]
    jr z, .skipGivingThreeStepsOfNoRandomBattles
    ld a, 3
    ld [wNumberOfNoRandomBattleStepsLeft], a
.skipGivingThreeStepsOfNoRandomBattles

    ld hl, wStatusFlags4
    bit BIT_BATTLE_OVER_OR_BLACKOUT, [hl]
    res BIT_BATTLE_OVER_OR_BLACKOUT, [hl]
    call z, BANK00_RESET_STRENGTH_BIT_ADDR
    call nz, BANK00_MAP_ENTRY_AFTER_BATTLE_ADDR

    ld hl, wStatusFlags6
    ld a, [hl]
    and (1 << BIT_FLY_WARP) | (1 << BIT_DUNGEON_WARP)
    jr z, .didNotEnterUsingFlyWarpOrDungeonWarp
    res BIT_FLY_WARP, [hl]
    ld b, $1C
    ld hl, BANK1C_ENTER_MAP_ANIM_ADDR
    call BANK00_FARCALL_ADDR
    call UpdateSprites
.didNotEnterUsingFlyWarpOrDungeonWarp

    ld b, $03
    ld hl, BANK03_CHECK_FORCE_BIKE_OR_SURF_ADDR
    call BANK00_FARCALL_ADDR

    ld hl, wStatusFlags3
    res BIT_NO_NPC_FACE_PLAYER, [hl]
    call UpdateSprites

    ld hl, wCurrentMapScriptFlags
    set BIT_CUR_MAP_LOADED_1, [hl]
    set BIT_CUR_MAP_LOADED_2, [hl]
    xor a
    ld [wJoyIgnore], a

IF DEF(_REV0)
    ASSERT @ == $1E1C
ELIF DEF(_REVA)
    ASSERT @ == $1E0A
ENDC
