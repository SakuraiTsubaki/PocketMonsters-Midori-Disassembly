; Direction input, 180-degree turn handling and initial collision checks.

    ldh a, [hJoyHeld]
    bit B_PAD_DOWN, a
    jr z, .checkIfUpButtonIsPressed
    ld a, 1
    ld [wSpritePlayerStateData1YStepVector], a
    ld a, PLAYER_DIR_DOWN
    jr .handleDirectionButtonPress

.checkIfUpButtonIsPressed
    bit B_PAD_UP, a
    jr z, .checkIfLeftButtonIsPressed
    ld a, -1
    ld [wSpritePlayerStateData1YStepVector], a
    ld a, PLAYER_DIR_UP
    jr .handleDirectionButtonPress

.checkIfLeftButtonIsPressed
    bit B_PAD_LEFT, a
    jr z, .checkIfRightButtonIsPressed
    ld a, -1
    ld [wSpritePlayerStateData1XStepVector], a
    ld a, PLAYER_DIR_LEFT
    jr .handleDirectionButtonPress

.checkIfRightButtonIsPressed
    bit B_PAD_RIGHT, a
    jr z, .noDirectionButtonsPressed
    ld a, 1
    ld [wSpritePlayerStateData1XStepVector], a

.handleDirectionButtonPress
    ld [wPlayerDirection], a
    ld a, [wStatusFlags5]
    bit BIT_SCRIPTED_MOVEMENT_STATE, a
    jr nz, .noDirectionChange
    ld a, [wCheckFor180DegreeTurn]
    and a
    jr z, .noDirectionChange

    ld a, [wPlayerDirection]
    ld b, a
    ld a, [wPlayerLastStopDirection]
    cp b
    jr z, .noDirectionChange

    swap a
    or b
    cp (PLAYER_DIR_DOWN << 4) | PLAYER_DIR_UP
    jr nz, .notDownToUp
    ld a, PLAYER_DIR_LEFT
    ld [wPlayerMovingDirection], a
    jr .holdIntermediateDirectionLoop
.notDownToUp
    cp (PLAYER_DIR_UP << 4) | PLAYER_DIR_DOWN
    jr nz, .notUpToDown
    ld a, PLAYER_DIR_RIGHT
    ld [wPlayerMovingDirection], a
    jr .holdIntermediateDirectionLoop
.notUpToDown
    cp (PLAYER_DIR_RIGHT << 4) | PLAYER_DIR_LEFT
    jr nz, .notRightToLeft
    ld a, PLAYER_DIR_DOWN
    ld [wPlayerMovingDirection], a
    jr .holdIntermediateDirectionLoop
.notRightToLeft
    cp (PLAYER_DIR_LEFT << 4) | PLAYER_DIR_RIGHT
    jr nz, .holdIntermediateDirectionLoop
    ld a, PLAYER_DIR_UP
    ld [wPlayerMovingDirection], a

.holdIntermediateDirectionLoop
    ld hl, wMiscFlags
    set BIT_TURNING, [hl]
    ld hl, wCheckFor180DegreeTurn
    dec [hl]
    jr nz, .holdIntermediateDirectionLoop
    ld a, [wPlayerDirection]
    ld [wPlayerMovingDirection], a
    call BANK00_NEW_BATTLE_ADDR
    jp c, BANK00_BATTLE_OCCURRED_ADDR
    jp OverworldLoop

.noDirectionChange
    ld a, [wPlayerDirection]
    ld [wPlayerMovingDirection], a
    call UpdateSprites
    ld a, [wWalkBikeSurfState]
    cp $02
    jr z, .surfing

    call BANK00_COLLISION_CHECK_LAND_ADDR
    jr nc, .noCollision
    push hl
    ld hl, wMovementFlags
    bit BIT_STANDING_ON_WARP, [hl]
    pop hl
    jp z, OverworldLoop
    push hl
    call BANK00_EXTRA_WARP_CHECK_ADDR
    pop hl
    jp c, BANK00_CHECK_WARPS_COLLISION_ADDR
    jp OverworldLoop

.surfing
    call BANK00_COLLISION_CHECK_WATER_ADDR
    jp c, OverworldLoop

.noCollision
    ld a, $08
    ld [wWalkCounter], a
    jr BANK00_OVERWORLD_MOVE_AHEAD2_ADDR

IF DEF(_REV0)
    ASSERT @ == $1FCD
ELIF DEF(_REVA)
    ASSERT @ == $1FBB
ENDC
