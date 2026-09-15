; Warp matching and map-transition handling.

CheckWarpsNoCollision::
    ld a, [wNumberOfWarps]
    and a
    jp z, BANK00_CHECK_MAP_CONNECTIONS_ADDR
    ld a, [wNumberOfWarps]
    ld b, 0
    ld c, a
    ld a, [wYCoord]
    ld d, a
    ld a, [wXCoord]
    ld e, a
    ld hl, wWarpEntries

CheckWarpsNoCollisionLoop::
    ld a, [hli]
    cp d
    jr nz, CheckWarpsNoCollisionRetry1
    ld a, [hli]
    cp e
    jr nz, CheckWarpsNoCollisionRetry2

    push hl
    push bc
    ld hl, wMovementFlags
    set BIT_STANDING_ON_WARP, [hl]
    ld b, $03
    ld hl, BANK03_IS_PLAYER_STANDING_ON_DOOR_WARP_ADDR
    call BANK00_FARCALL_ADDR
    pop bc
    pop hl
    jr c, WarpFound1

    push hl
    push bc
    call BANK00_EXTRA_WARP_CHECK_ADDR
    pop bc
    pop hl
    jr nc, CheckWarpsNoCollisionRetry2

    ld a, [wStatusFlags7]
    bit BIT_FORCED_WARP, a
    jr nz, WarpFound1
    push de
    push bc
    call Joypad
    pop bc
    pop de
    ldh a, [hJoyHeld]
    and PAD_CTRL_PAD
    jr z, CheckWarpsNoCollisionRetry2
    jr WarpFound1

CheckWarpsCollision::
    ld a, [wNumberOfWarps]
    ld c, a
    ld hl, wWarpEntries
.loop
    ld a, [hli]
    ld b, a
    ld a, [wYCoord]
    cp b
    jr nz, .retry1
    ld a, [hli]
    ld b, a
    ld a, [wXCoord]
    cp b
    jr nz, .retry2
    ld a, [hli]
    ld [wDestinationWarpID], a
    ld a, [hl]
    ldh [hWarpDestinationMap], a
    jr WarpFound2
.retry1
    inc hl
.retry2
    inc hl
    inc hl
    dec c
    jr nz, .loop
    jp OverworldLoop

CheckWarpsNoCollisionRetry1::
    inc hl
CheckWarpsNoCollisionRetry2::
    inc hl
    inc hl
    jp ContinueCheckWarpsNoCollisionLoop

WarpFound1::
    ld a, [hli]
    ld [wDestinationWarpID], a
    ld a, [hli]
    ldh [hWarpDestinationMap], a

WarpFound2::
    ld a, [wNumberOfWarps]
    sub c
    ld [wWarpedFromWhichWarp], a
    ld a, [wCurMap]
    ld [wWarpedFromWhichMap], a
    call BANK00_CHECK_IF_OUTSIDE_MAP_ADDR
    jr nz, .indoorMaps

    ld a, [wCurMap]
    ld [wLastMap], a
    ld a, [wCurMapWidth]
    ld [wUnusedLastMapWidth], a
    ldh a, [hWarpDestinationMap]
    ld [wCurMap], a
    cp ROCK_TUNNEL_1F
    jr nz, .notRockTunnel
    ld a, $06
    ld [wMapPalOffset], a
    call BANK00_GB_FADE_OUT_TO_BLACK_ADDR
.notRockTunnel
    call BANK00_PLAY_MAP_CHANGE_SOUND_ADDR
    jr .done

.indoorMaps
    ldh a, [hWarpDestinationMap]
    cp LAST_MAP
    jr z, .goBackOutside
    ld [wCurMap], a
    ld b, $1C
    ld hl, BANK1C_IS_PLAYER_STANDING_ON_WARP_PAD_OR_HOLE_ADDR
    call BANK00_FARCALL_ADDR
    ld a, [wStandingOnWarpPadOrHole]
    dec a
    jr nz, .notWarpPad
    ld hl, wStatusFlags6
    set BIT_FLY_WARP, [hl]
    call BANK00_LEAVE_MAP_ANIM_ADDR
    jr .skipMapChangeSound
.notWarpPad
    call BANK00_PLAY_MAP_CHANGE_SOUND_ADDR
.skipMapChangeSound
    ld hl, wMovementFlags
    res BIT_STANDING_ON_DOOR, [hl]
    res BIT_EXITING_DOOR, [hl]
    jr .done

.goBackOutside
    ld a, [wLastMap]
    ld [wCurMap], a
    call BANK00_PLAY_MAP_CHANGE_SOUND_ADDR
    xor a
    ld [wMapPalOffset], a

.done
    ld hl, wMovementFlags
    set BIT_STANDING_ON_DOOR, [hl]
    call BANK00_IGNORE_INPUT_HALF_SECOND_ADDR
    jp EnterMap

ContinueCheckWarpsNoCollisionLoop::
    inc b
    dec c
    jp nz, CheckWarpsNoCollisionLoop

IF DEF(_REV0)
    ASSERT @ == $21D1
ELIF DEF(_REVA)
    ASSERT @ == $21BF
ENDC
