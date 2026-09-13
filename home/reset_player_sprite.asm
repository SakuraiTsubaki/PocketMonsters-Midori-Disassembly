; Player sprite-state initialization.

IF DEF(_REV0)
    ASSERT @ == $1377
ELIF DEF(_REVA)
    ASSERT @ == $1365
ENDC
ResetPlayerSpriteData::
    ld hl, wSpriteStateData1
    call ResetPlayerSpriteData_ClearSpriteData
    ld hl, wSpriteStateData2
    call ResetPlayerSpriteData_ClearSpriteData
    ld a, 1
    ld [wSpritePlayerStateData1PictureID], a
    ld [wSpritePlayerStateData2ImageBaseOffset], a
    ld hl, wSpritePlayerStateData1YPixels
    ld [hl], $3C
    inc hl
    inc hl
    ld [hl], $40
    ret

ResetPlayerSpriteData_ClearSpriteData::
    ld bc, SPRITE_STATE_DATA_LENGTH
    xor a
    jp BANK00_FILL_MEMORY_ADDR

IF DEF(_REV0)
    ASSERT @ == $139C
ELIF DEF(_REVA)
    ASSERT @ == $138A
ENDC
