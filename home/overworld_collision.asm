; Land collision, passability, ledge and tile-pair collision handling.

CollisionCheckOnLand::
    ld a, [wMovementFlags]
    bit BIT_LEDGE_OR_FISHING, a
    jr nz, .noCollision
    ld a, [wSimulatedJoypadStatesIndex]
    and a
    jr nz, .noCollision
    ld a, [wPlayerDirection]
    ld d, a
    ld a, [wSpritePlayerStateData1CollisionData]
    and d
    jr nz, .collision
    xor a
    ldh [hTextID], a
    call IsSpriteInFrontOfPlayer
    ldh a, [hTextID]
    and a
    jr nz, .collision
    ld hl, TilePairCollisionsLand
    call CheckForJumpingAndTilePairCollisions
    jr c, .collision
    call CheckTilePassable
    jr nc, .noCollision
.collision
    ld a, [wChannelSoundIDs + CHAN5]
    cp SFX_COLLISION
    jr z, .setCarry
    ld a, SFX_COLLISION
    call PlaySound
.setCarry
    scf
    ret
.noCollision
    and a
    ret

CheckTilePassable::
    ld a, PREDEF_GET_TILE_AND_COORDS_IN_FRONT
    call BANK00_PREDEF_ADDR
    ld a, [wTileInFrontOfPlayer]
    ld c, a
    ld hl, wTilesetCollisionPtr
    ld a, [hli]
    ld h, [hl]
    ld l, a
.loop
    ld a, [hli]
    cp $FF
    jr z, .tileNotPassable
    cp c
    ret z
    jr .loop
.tileNotPassable
    scf
    ret

CheckForJumpingAndTilePairCollisions::
    push hl
    ld a, PREDEF_GET_TILE_AND_COORDS_IN_FRONT
    call BANK00_PREDEF_ADDR
    push de
    push bc
    ld b, $06
    ld hl, BANK06_HANDLE_LEDGES_ADDR
    call BANK00_FARCALL_ADDR
    pop bc
    pop de
    pop hl
    and a
    ld a, [wMovementFlags]
    bit BIT_LEDGE_OR_FISHING, a
    ret nz

CheckForTilePairCollisions::
    ld a, [wTileInFrontOfPlayer]
    ld c, a
.tilePairCollisionLoop
    ld a, [wCurMapTileset]
    ld b, a
    ld a, [hli]
    cp $FF
    jr z, .noMatch
    cp b
    jr z, .tilesetMatches
    inc hl
.retry
    inc hl
    jr .tilePairCollisionLoop
.tilesetMatches
    ld a, [wTileMap + 9 * 20 + 8]
    ld b, a
    ld a, [hl]
    cp b
    jr z, .currentTileMatchesFirstInPair
    inc hl
    ld a, [hl]
    cp b
    jr z, .currentTileMatchesSecondInPair
    jr .retry
.currentTileMatchesFirstInPair
    inc hl
    ld a, [hl]
    cp c
    jr z, .foundMatch
    jr .tilePairCollisionLoop
.currentTileMatchesSecondInPair
    dec hl
    ld a, [hli]
    cp c
    inc hl
    jr nz, .tilePairCollisionLoop
.foundMatch
    scf
    ret
.noMatch
    and a
    ret

INCLUDE "data/tilesets/pair_collision_tile_ids.asm"

IF DEF(_REV0)
    ASSERT @ == $26BB
ELIF DEF(_REVA)
    ASSERT @ == $26A9
ENDC
