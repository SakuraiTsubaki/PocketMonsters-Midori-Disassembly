; Post-battle map entry, blackout, music stop, and Fly/Dungeon warp flow.

MapEntryAfterBattle::
    ld b, $03
    ld hl, BANK03_IS_PLAYER_STANDING_ON_WARP_ADDR
    call BANK00_FARCALL_ADDR
    ld a, [wMapPalOffset]
    and a
    jp z, GBFadeInFromWhite
    jp LoadGBPal

HandleBlackOut::
    call GBFadeOutToBlack
    ld a, $08
    call StopMusic
    ld hl, wStatusFlags4
    res BIT_BATTLE_OVER_OR_BLACKOUT, [hl]
    ld a, $01
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call BANK01_RESET_STATUS_HALVE_MONEY_ADDR
    call BANK00_PREPARE_FOR_SPECIAL_WARP_ADDR
    call BANK00_PLAY_DEFAULT_MUSIC_FADE_ADDR
    jp BANK01_SPECIAL_ENTER_MAP_ADDR

StopMusic::
    ld [wAudioFadeOutControl], a
    ld a, SFX_STOP_ALL_MUSIC
    ld [wNewSoundID], a
    call BANK00_PLAY_SOUND_ADDR
.wait
    ld a, [wAudioFadeOutControl]
    and a
    jr nz, .wait
    jp StopAllSounds

HandleFlyWarpOrDungeonWarp::
    call UpdateSprites
    call BANK00_DELAY3_ADDR
    xor a
    ld [wBattleResult], a
    ld [wWalkBikeSurfState], a
    ld [wIsInBattle], a
    ld [wMapPalOffset], a
    ld hl, wStatusFlags6
    set BIT_FLY_OR_DUNGEON_WARP, [hl]
    res BIT_ALWAYS_ON_BIKE, [hl]
    call LeaveMapAnim
    ld a, $01
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call BANK00_PREPARE_FOR_SPECIAL_WARP_ADDR
    jp BANK01_SPECIAL_ENTER_MAP_ADDR

LeaveMapAnim::
    ld b, $1C
    ld hl, BANK1C_LEAVE_MAP_ANIM_ADDR
    jp BANK00_FARCALL_ADDR

IF DEF(_REV0)
    ASSERT @ == $23AE
ELIF DEF(_REVA)
    ASSERT @ == $239C
ENDC
