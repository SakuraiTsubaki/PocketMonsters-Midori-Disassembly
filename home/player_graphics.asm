; Select walking/biking/surfing player graphics and load current tileset graphics.

LoadPlayerSpriteGraphics::
    ld a, [wWalkBikeSurfState]
    dec a
    jr z, .ridingBike

    ldh a, [hTileAnimations]
    and a
    jr nz, .determineGraphics
    jr .startWalking

.ridingBike
    call IsBikeRidingAllowed
    jr c, .determineGraphics

.startWalking
    xor a
    ld [wWalkBikeSurfState], a
    ld [wWalkBikeSurfStateCopy], a
    jp BANK00_LOAD_WALKING_PLAYER_GFX_ADDR

.determineGraphics
    ld a, [wWalkBikeSurfState]
    and a
    jp z, BANK00_LOAD_WALKING_PLAYER_GFX_ADDR
    dec a
    jp z, BANK00_LOAD_BIKE_PLAYER_GFX_ADDR
    dec a
    jp z, BANK00_LOAD_SURFING_PLAYER_GFX_ADDR
    jp BANK00_LOAD_WALKING_PLAYER_GFX_ADDR

IsBikeRidingAllowed::
    ld a, [wCurMap]
    cp ROUTE_23
    jr z, .allowed
    cp INDIGO_PLATEAU
    jr z, .allowed

    ld a, [wCurMapTileset]
    ld b, a
    ld hl, BikeRidingTilesets
.loop
    ld a, [hli]
    cp b
    jr z, .allowed
    inc a
    jr nz, .loop
    and a
    ret
.allowed
    scf
    ret

INCLUDE "data/tilesets/bike_riding_tilesets.asm"

LoadTilesetTilePatternData::
    ld a, [wTilesetGfxPtr]
    ld l, a
    ld a, [wTilesetGfxPtr + 1]
    ld h, a
    ld de, VRAM_TILESET_BASE
    ld bc, MAP_TILESET_GFX_SIZE
    ld a, [wTilesetBank]
    jp FarCopyData2

IF DEF(_REV0)
    ASSERT @ == $2413
ELIF DEF(_REVA)
    ASSERT @ == $2401
ENDC
