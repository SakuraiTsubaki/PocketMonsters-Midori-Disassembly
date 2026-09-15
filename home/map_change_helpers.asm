; Shared helpers used by overworld map transitions.

PlayMapChangeSound::
    ld a, [wTileMap + 8 * 20 + 8]
    cp $0B
    jr nz, .didNotGoThroughDoor
    ld a, SFX_GO_INSIDE
    jr .playSound
.didNotGoThroughDoor
    ld a, SFX_GO_OUTSIDE
.playSound
    call BANK00_PLAY_SOUND_ADDR
    ld a, [wMapPalOffset]
    and a
    ret nz
    jp BANK00_GB_FADE_OUT_TO_BLACK_ADDR

CheckIfInOutsideMap::
    ld a, [wCurMapTileset]
    and a
    ret z
    cp TILESET_PLATEAU
    ret

ExtraWarpCheck::
    ld a, [wCurMap]
    cp SS_ANNE_3F
    jr z, .useFunction1
    cp ROCKET_HIDEOUT_B1F
    jr z, .useFunction2
    cp ROCKET_HIDEOUT_B2F
    jr z, .useFunction2
    cp ROCKET_HIDEOUT_B4F
    jr z, .useFunction2
    cp ROCK_TUNNEL_1F
    jr z, .useFunction2
    ld a, [wCurMapTileset]
    and a
    jr z, .useFunction2
    cp TILESET_SHIP
    jr z, .useFunction2
    cp TILESET_SHIP_PORT
    jr z, .useFunction2
    cp TILESET_PLATEAU
    jr z, .useFunction2
.useFunction1
    ld hl, BANK03_IS_PLAYER_FACING_EDGE_ADDR
    jr .doBankswitch
.useFunction2
    ld hl, BANK03_IS_WARP_TILE_IN_FRONT_ADDR
.doBankswitch
    ld b, $03
    jp BANK00_FARCALL_ADDR

IF DEF(_REV0)
    ASSERT @ == $2336
ELIF DEF(_REVA)
    ASSERT @ == $2324
ENDC
