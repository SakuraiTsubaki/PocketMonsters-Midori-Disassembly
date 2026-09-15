; Check the tile ahead while surfing and decide whether the player keeps
; surfing, collides, or steps back onto land.
;
; The original sprite-collision path falls through to the passable-tile scan
; without refreshing c. This source preserves that behavior for byte-exact
; reconstruction; behavioral fixes belong in a separate modernization patch.

CollisionCheckOnWater::
    ld a, [wFlags_D6AF]
    bit 7, a
    jp nz, .noCollision

    ld a, [wPlayerDirection]
    ld d, a
    ld a, [wSpritePlayerStateData1CollisionData]
    and d
    jr nz, .checkIfNextTileIsPassable

    ld hl, TilePairCollisionsWater
    call CheckForJumpingAndTilePairCollisions
    jr c, .collision

    ld a, PREDEF_GET_TILE_AND_COORDS_IN_FRONT
    call BANK00_PREDEF_ADDR
    ld a, [wTileInFrontOfPlayer]
    cp $14
    jr z, .noCollision
    cp $32
    jr z, .checkIfVermilionDockTileset
    cp $48
    jr z, .noCollision

.checkIfNextTileIsPassable
    ld hl, wTilesetCollisionPtr
    ld a, [hli]
    ld h, [hl]
    ld l, a
.loop
    ld a, [hli]
    cp $FF
    jr z, .collision
    cp c
    jr z, .stopSurfing
    jr .loop

.collision
    ld a, [wChannelSoundIDs + CHAN5]
    cp SFX_COLLISION
    jr z, .setCarry
    ld a, SFX_COLLISION
    call PlaySound
.setCarry
    scf
    jr .done

.noCollision
    and a
.done
    ret

.stopSurfing
    xor a
    ld [wWalkBikeSurfState], a
    call LoadPlayerSpriteGraphics
    call PlayDefaultMusic
    jr .noCollision

.checkIfVermilionDockTileset
    ld a, [wCurMapTileset]
    cp TILESET_SHIP_PORT
    jr nz, .noCollision
    jr .stopSurfing

IF DEF(_REV0)
    ASSERT @ == $2A2C
ELIF DEF(_REVA)
    ASSERT @ == $2A1A
ENDC
