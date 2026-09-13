; $0774-$09CE
; Background-map addressing, VBlank copy helpers, and overworld tile animation.
; This range is byte-identical in Midori Rev 0 and Rev A.

ASSERT @ == $0774
GetRowColAddressBgMap::
    xor a
    srl h
    rr a
    srl h
    rr a
    srl h
    rr a
    or l
    ld l, a
    ld a, b
    or h
    ld h, a
    ret

ASSERT @ == $0787
ClearBgMap::
    ld a, JAPANESE_BLANK_TILE
    jr FillBgMapCommon

ASSERT @ == $078B
FillBgMap::
    ld a, l

FillBgMapCommon::
    ld de, TILEMAP_AREA
    ld l, e
.loop
    ld [hli], a
    dec e
    jr nz, .loop
    dec d
    jr nz, .loop
    ret

ASSERT @ == $0798
RedrawRowOrColumn::
    ldh a, [hRedrawRowOrColumnMode]
    and a
    ret z
    ld b, a
    xor a
    ldh [hRedrawRowOrColumnMode], a
    dec b
    jr nz, .redrawRow

.redrawColumn
    ld hl, wRedrawRowOrColumnSrcTiles
    ldh a, [hRedrawRowOrColumnDest]
    ld e, a
    ldh a, [hRedrawRowOrColumnDest + 1]
    ld d, a
    ld c, SCREEN_HEIGHT
.loop1
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ld a, TILEMAP_WIDTH - 1
    add e
    ld e, a
    jr nc, .noCarry
    inc d
.noCarry
    ld a, d
    and HIGH(TILEMAP_AREA - 1)
    or HIGH(vBGMap0)
    ld d, a
    dec c
    jr nz, .loop1
    xor a
    ldh [hRedrawRowOrColumnMode], a
    ret

.redrawRow
    ld hl, wRedrawRowOrColumnSrcTiles
    ldh a, [hRedrawRowOrColumnDest]
    ld e, a
    ldh a, [hRedrawRowOrColumnDest + 1]
    ld d, a
    push de
    call .DrawHalf
    pop de
    ld a, TILEMAP_WIDTH
    add e
    ld e, a

.DrawHalf
    ld c, SCREEN_WIDTH / 2
.loop2
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ld a, e
    inc a
    and %11111
    ld b, a
    ld a, e
    and %11100000
    or b
    ld e, a
    dec c
    jr nz, .loop2
    ret

ASSERT @ == $07EE
AutoBgMapTransfer::
    ldh a, [hAutoBGTransferEnabled]
    and a
    ret z
    ld hl, sp + 0
    ld a, h
    ldh [hSPTemp], a
    ld a, l
    ldh [hSPTemp + 1], a
    ldh a, [hAutoBGTransferPortion]
    and a
    jr z, .transferTopThird
    dec a
    jr z, .transferMiddleThird

.transferBottomThird
    ld hl, wTileMap + ((2 * SCREEN_HEIGHT / 3) * SCREEN_WIDTH)
    ld sp, hl
    ld a, [hAutoBGTransferDest + 1]
    ld h, a
    ld a, [hAutoBGTransferDest]
    ld l, a
    ld de, 12 * TILEMAP_WIDTH
    add hl, de
    xor a
    jr .doTransfer

.transferTopThird
    ld hl, wTileMap
    ld sp, hl
    ld a, [hAutoBGTransferDest + 1]
    ld h, a
    ld a, [hAutoBGTransferDest]
    ld l, a
    ld a, TRANSFER_MIDDLE
    jr .doTransfer

.transferMiddleThird
    ld hl, wTileMap + ((SCREEN_HEIGHT / 3) * SCREEN_WIDTH)
    ld sp, hl
    ld a, [hAutoBGTransferDest + 1]
    ld h, a
    ld a, [hAutoBGTransferDest]
    ld l, a
    ld de, 6 * TILEMAP_WIDTH
    add hl, de
    ld a, TRANSFER_BOTTOM

.doTransfer
    ldh [hAutoBGTransferPortion], a
    ld b, SCREEN_HEIGHT / 3

ASSERT @ == $083B
TransferBgRows::
REPT SCREEN_WIDTH / 2 - 1
    pop de
    ld [hl], e
    inc l
    ld [hl], d
    inc l
ENDR
    pop de
    ld [hl], e
    inc l
    ld [hl], d
    ld a, TILEMAP_WIDTH - (SCREEN_WIDTH - 1)
    add l
    ld l, a
    jr nc, .ok
    inc h
.ok
    dec b
    jr nz, TransferBgRows
    ldh a, [hSPTemp]
    ld h, a
    ldh a, [hSPTemp + 1]
    ld l, a
    ld sp, hl
    ret

ASSERT @ == $087E
VBlankCopyBgMap::
    ldh a, [hVBlankCopyBGSource]
    and a
    ret z
    ld hl, sp + 0
    ld a, h
    ldh [hSPTemp], a
    ld a, l
    ldh [hSPTemp + 1], a
    ldh a, [hVBlankCopyBGSource]
    ld l, a
    ldh a, [hVBlankCopyBGSource + 1]
    ld h, a
    ld sp, hl
    ldh a, [hVBlankCopyBGDest]
    ld l, a
    ldh a, [hVBlankCopyBGDest + 1]
    ld h, a
    ldh a, [hVBlankCopyBGNumRows]
    ld b, a
    xor a
    ldh [hVBlankCopyBGSource], a
    jr TransferBgRows

ASSERT @ == $089F
VBlankCopyDouble::
    ldh a, [hVBlankCopyDoubleSize]
    and a
    ret z
    ld hl, sp + 0
    ld a, h
    ldh [hSPTemp], a
    ld a, l
    ldh [hSPTemp + 1], a
    ldh a, [hVBlankCopyDoubleSource]
    ld l, a
    ldh a, [hVBlankCopyDoubleSource + 1]
    ld h, a
    ld sp, hl
    ldh a, [hVBlankCopyDoubleDest]
    ld l, a
    ldh a, [hVBlankCopyDoubleDest + 1]
    ld h, a
    ldh a, [hVBlankCopyDoubleSize]
    ld b, a
    xor a
    ldh [hVBlankCopyDoubleSize], a
.loop
REPT TILE_SIZE / 4 - 1
    pop de
    ld [hl], e
    inc l
    ld [hl], e
    inc l
    ld [hl], d
    inc l
    ld [hl], d
    inc l
ENDR
    pop de
    ld [hl], e
    inc l
    ld [hl], e
    inc l
    ld [hl], d
    inc l
    ld [hl], d
    inc hl
    dec b
    jr nz, .loop
    ld a, l
    ldh [hVBlankCopyDoubleDest], a
    ld a, h
    ldh [hVBlankCopyDoubleDest + 1], a
    ld hl, sp + 0
    ld a, l
    ldh [hVBlankCopyDoubleSource], a
    ld a, h
    ldh [hVBlankCopyDoubleSource + 1], a
    ldh a, [hSPTemp]
    ld h, a
    ldh a, [hSPTemp + 1]
    ld l, a
    ld sp, hl
    ret

ASSERT @ == $08FB
VBlankCopy::
    ldh a, [hVBlankCopySize]
    and a
    ret z
    ld hl, sp + 0
    ld a, h
    ldh [hSPTemp], a
    ld a, l
    ldh [hSPTemp + 1], a
    ldh a, [hVBlankCopySource]
    ld l, a
    ldh a, [hVBlankCopySource + 1]
    ld h, a
    ld sp, hl
    ldh a, [hVBlankCopyDest]
    ld l, a
    ldh a, [hVBlankCopyDest + 1]
    ld h, a
    ldh a, [hVBlankCopySize]
    ld b, a
    xor a
    ldh [hVBlankCopySize], a
.loop
REPT TILE_SIZE / 2 - 1
    pop de
    ld [hl], e
    inc l
    ld [hl], d
    inc l
ENDR
    pop de
    ld [hl], e
    inc l
    ld [hl], d
    inc hl
    dec b
    jr nz, .loop
    ld a, l
    ldh [hVBlankCopyDest], a
    ld a, h
    ldh [hVBlankCopyDest + 1], a
    ld hl, sp + 0
    ld a, l
    ldh [hVBlankCopySource], a
    ld a, h
    ldh [hVBlankCopySource + 1], a
    ldh a, [hSPTemp]
    ld h, a
    ldh a, [hSPTemp + 1]
    ld l, a
    ld sp, hl
    ret

ASSERT @ == $095B
UpdateMovingBgTiles::
    ldh a, [hTileAnimations]
    and a
    ret z
    ldh a, [hMovingBGTilesCounter1]
    inc a
    ldh [hMovingBGTilesCounter1], a
    cp 20
    ret c
    cp 21
    jr z, .flower

    ld hl, vTileset + ($14 * TILE_SIZE)
    ld c, TILE_SIZE
    ld a, [wMovingBGTilesCounter2]
    inc a
    and 7
    ld [wMovingBGTilesCounter2], a
    and 4
    jr nz, .left
.right
    ld a, [hl]
    rrca
    ld [hli], a
    dec c
    jr nz, .right
    jr .done
.left
    ld a, [hl]
    rlca
    ld [hli], a
    dec c
    jr nz, .left
.done
    ldh a, [hTileAnimations]
    rrca
    ret nc
    xor a
    ldh [hMovingBGTilesCounter1], a
    ret

.flower
    xor a
    ldh [hMovingBGTilesCounter1], a
    ld a, [wMovingBGTilesCounter2]
    and 1
    ld hl, FlowerTile1
    jr z, .copy
    ld hl, FlowerTile2
.copy
    ld de, vTileset + ($03 * TILE_SIZE)
    ld c, TILE_SIZE
.loop
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ret

ASSERT @ == $09AF
FlowerTile1::
    db $BA, $18, $65, $64, $9A, $82, $9B, $82
    db $E6, $64, $9B, $FE, $F6, $7C, $5D, $18

ASSERT @ == $09BF
FlowerTile2::
    db $AE, $0C, $73, $32, $CD, $41, $4D, $41
    db $B2, $F2, $4D, $7F, $AA, $3E, $5D, $1C

ASSERT @ == $09CF
