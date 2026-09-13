; Run the current map script, including boulder interaction effects, then
; expose the three player-sprite graphics loaders used by the overworld.

RunMapScript::
    push hl
    push de
    push bc

    ld b, $03
    ld hl, BANK03_TRY_PUSHING_BOULDER_ADDR
    call BANK00_FARCALL_ADDR

    ld a, [wMiscFlags]
    bit 1, a
    jr z, .afterBoulderEffect
    ld b, $03
    ld hl, BANK03_DO_BOULDER_DUST_ANIMATION_ADDR
    call BANK00_FARCALL_ADDR

.afterBoulderEffect
    pop bc
    pop de
    pop hl
    call BANK00_RUN_NPC_MOVEMENT_SCRIPT_ADDR
    ld a, [wCurMap]
    call BANK00_SWITCH_TO_MAP_ROM_BANK_ADDR
    ld hl, wMapScriptPtr
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, .return
    push de
    jp hl
.return
    ret

LoadWalkingPlayerSpriteGraphics::
    ld de, WALKING_PLAYER_SPRITE_GFX_ADDR
    ld hl, VRAM_NPC_SPRITES
    jr LoadPlayerSpriteGraphicsCommon

LoadSurfingPlayerSpriteGraphics::
    ld de, SURFING_PLAYER_SPRITE_GFX_ADDR
    ld hl, VRAM_NPC_SPRITES
    jr LoadPlayerSpriteGraphicsCommon

LoadBikePlayerSpriteGraphics::
    ld de, BIKE_PLAYER_SPRITE_GFX_ADDR
    ld hl, VRAM_NPC_SPRITES

LoadPlayerSpriteGraphicsCommon::
    push de
    push hl
    ld bc, (PLAYER_SPRITE_GFX_BANK << 8) | PLAYER_SPRITE_GFX_TILE_COUNT
    call CopyVideoData
    pop hl
    pop de
    ld a, PLAYER_SPRITE_GFX_HALF_OFFSET
    add e
    ld e, a
    jr nc, .noCarry
    inc d
.noCarry
    set 3, h
    ld bc, (PLAYER_SPRITE_GFX_BANK << 8) | PLAYER_SPRITE_GFX_TILE_COUNT
    jp CopyVideoData

IF DEF(_REV0)
    ASSERT @ == $2A8D
ELIF DEF(_REVA)
    ASSERT @ == $2A7B
ENDC
