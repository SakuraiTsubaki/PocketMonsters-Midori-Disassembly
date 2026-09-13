; Detect signs and sprites in front of the player and expose their text ID.

IsSpriteOrSignInFrontOfPlayer::
    xor a
    ldh [hTextID], a
    ld a, [wNumSigns]
    and a
    jr z, .extendRangeOverCounter

    ld a, PREDEF_GET_TILE_AND_COORDS_IN_FRONT
    call BANK00_PREDEF_ADDR
    ld hl, wSignCoords
    ld a, [wNumSigns]
    ld b, a
    ld c, 0
.signLoop
    inc c
    ld a, [hli]
    cp d
    jr z, .yCoordMatched
    inc hl
    jr .retry
.yCoordMatched
    ld a, [hli]
    cp e
    jr nz, .retry
    push hl
    push bc
    ld hl, wSignTextIDs
    ld b, 0
    dec c
    add hl, bc
    ld a, [hl]
    ldh [hTextID], a
    pop bc
    pop hl
    ret
.retry
    dec b
    jr nz, .signLoop

.extendRangeOverCounter
    ld a, PREDEF_GET_TILE_AND_COORDS_IN_FRONT
    call BANK00_PREDEF_ADDR
    ld hl, wTilesetTalkingOverTiles
    ld b, 3
    ld d, $20
.counterTilesLoop
    ld a, [hli]
    cp c
    jr z, IsSpriteInFrontOfPlayer2
    dec b
    jr nz, .counterTilesLoop

IsSpriteInFrontOfPlayer::
    ld d, $10

IsSpriteInFrontOfPlayer2::
    ld bc, $3C40
    ld a, [wSpritePlayerStateData1FacingDirection]
    cp SPRITE_FACING_UP
    jr nz, .checkIfPlayerFacingDown
    ld a, b
    sub d
    ld b, a
    ld a, PLAYER_DIR_UP
    jr .doneCheckingDirection

.checkIfPlayerFacingDown
    cp SPRITE_FACING_DOWN
    jr nz, .checkIfPlayerFacingRight
    ld a, b
    add d
    ld b, a
    ld a, PLAYER_DIR_DOWN
    jr .doneCheckingDirection

.checkIfPlayerFacingRight
    cp SPRITE_FACING_RIGHT
    jr nz, .playerFacingLeft
    ld a, c
    add d
    ld c, a
    ld a, PLAYER_DIR_RIGHT
    jr .doneCheckingDirection

.playerFacingLeft
    ld a, c
    sub d
    ld c, a
    ld a, PLAYER_DIR_LEFT

.doneCheckingDirection
    ld [wPlayerDirection], a
    ld a, [wNumSprites]
    and a
    ret z
    ld hl, wSprite01StateData1
    ld d, a
    ld e, $01
.spriteLoop
    push hl
    ld a, [hli]
    and a
    jr z, .nextSprite
    inc l
    ld a, [hli]
    inc a
    jr z, .nextSprite
    inc l
    ld a, [hli]
    cp b
    jr nz, .nextSprite
    inc l
    ld a, [hl]
    cp c
    jr z, .foundSpriteInFrontOfPlayer
.nextSprite
    pop hl
    ld a, l
    add SPRITESTATEDATA1_LENGTH
    ld l, a
    inc e
    dec d
    jr nz, .spriteLoop
    ret

.foundSpriteInFrontOfPlayer
    pop hl
    ld a, l
    and $F0
    inc a
    ld l, a
    set BIT_FACE_PLAYER, [hl]
    ld a, e
    ldh [hTextID], a
    ret

IF DEF(_REV0)
    ASSERT @ == $25E8
ELIF DEF(_REVA)
    ASSERT @ == $25D6
ENDC
