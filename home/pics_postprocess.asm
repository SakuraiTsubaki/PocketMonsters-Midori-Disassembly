; Center decompressed 1bpp Pokemon sprite planes in 7x7 buffers,
; interlace them into 2bpp, and transfer the result to VRAM.

LoadMonFrontSprite::
    push de
    ld hl, MON_FRONT_SPRITE_PTR_OFFSET
    call UncompressMonSprite
    ld hl, wMonHSpriteDim
    ld a, [hli]
    ld c, a
    pop de
    ; fall through

LoadUncompressedSpriteData::
    push de
    and $0F
    ldh [hSpriteWidth], a
    ld b, a
    ld a, 7
    sub b
    inc a
    srl a
    ld b, a
    add a
    add a
    add a
    sub b
    ldh [hSpriteOffset], a

    ld a, c
    swap a
    and $0F
    ld b, a
    add a
    add a
    add a
    ldh [hSpriteHeight], a
    ld a, 7
    sub b
    ld b, a
    ldh a, [hSpriteOffset]
    add b
    add a
    add a
    add a
    ldh [hSpriteOffset], a

    xor a
    ld [rRAMB], a
    ld hl, sSpriteBuffer0
    call ZeroSpriteBuffer
    ld de, sSpriteBuffer1
    ld hl, sSpriteBuffer0
    call AlignSpriteDataCentered
    ld hl, sSpriteBuffer1
    call ZeroSpriteBuffer
    ld de, sSpriteBuffer2
    ld hl, sSpriteBuffer1
    call AlignSpriteDataCentered
    pop de
    jp InterlaceMergeSpriteBuffers

AlignSpriteDataCentered::
    ldh a, [hSpriteOffset]
    ld b, 0
    ld c, a
    add hl, bc
    ldh a, [hSpriteWidth]
.columnLoop
    push af
    push hl
    ldh a, [hSpriteHeight]
    ld c, a
.columnInnerLoop
    ld a, [de]
    inc de
    ld [hli], a
    dec c
    jr nz, .columnInnerLoop
    pop hl
    ld bc, 7 * TILE_1BPP_SIZE
    add hl, bc
    pop af
    dec a
    jr nz, .columnLoop
    ret

ZeroSpriteBuffer::
    ld bc, SPRITE_BUFFER_SIZE
.nextByteLoop
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .nextByteLoop
    ret

InterlaceMergeSpriteBuffers::
    xor a
    ld [rRAMB], a
    push de
    ld hl, sSpriteBuffer2 + (SPRITE_BUFFER_SIZE - 1)
    ld de, sSpriteBuffer1 + (SPRITE_BUFFER_SIZE - 1)
    ld bc, sSpriteBuffer0 + (SPRITE_BUFFER_SIZE - 1)
    ld a, SPRITE_BUFFER_SIZE / 2
    ldh [hSpriteInterlaceCounter], a
.interlaceLoop
    ld a, [de]
    dec de
    ld [hld], a
    ld a, [bc]
    dec bc
    ld [hld], a
    ld a, [de]
    dec de
    ld [hld], a
    ld a, [bc]
    dec bc
    ld [hld], a
    ldh a, [hSpriteInterlaceCounter]
    dec a
    ldh [hSpriteInterlaceCounter], a
    jr nz, .interlaceLoop

    ld a, [wSpriteFlipped]
    and a
    jr z, .notFlipped
    ld bc, 2 * SPRITE_BUFFER_SIZE
    ld hl, sSpriteBuffer1
.swapLoop
    swap [hl]
    inc hl
    dec bc
    ld a, b
    or c
    jr nz, .swapLoop
.notFlipped
    pop hl
    ld de, sSpriteBuffer1
    ld c, PIC_SIZE
    ldh a, [hLoadedROMBank]
    ld b, a
    jp CopyVideoData

IF DEF(_REV0)
    ASSERT @ == $30FE
ELIF DEF(_REVA)
    ASSERT @ == $30EC
ENDC
