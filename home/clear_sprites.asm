; $0188-$01A2

ClearSprites::
    xor a
    ld hl, wShadowOAM
    ld b, wShadowOAMSize
.loop
    ld [hli], a
    dec b
    jr nz, .loop
    ret

HideSprites::
    ld a, HIDDEN_SPRITE_Y
    ld hl, wShadowOAM
    ld de, SHADOW_OAM_ENTRY_SIZE
    ld b, SHADOW_OAM_COUNT
.loop
    ld [hl], a
    add hl, de
    dec b
    jr nz, .loop
    ret
