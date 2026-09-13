; Initial non-sprite helpers from home/pokemon.asm.

DrawHPBar::
    push hl
    push de
    push bc

    ld a, $71
    ld [hli], a
    ld a, $62
    ld [hli], a

    push hl
    ld a, $63
.draw
    ld [hli], a
    dec d
    jr nz, .draw

    ld a, [wHPBarType]
    dec a
    ld a, $6D
    jr z, .rightEnd
    dec a
.rightEnd
    ld [hl], a

    pop hl
    ld a, e
    and a
    jr nz, .fill
    ld a, c
    and a
    jr z, .done
    ld e, $01

.fill
    ld a, e
    sub $08
    jr c, .partial
    ld e, a
    ld a, $6B
    ld [hli], a
    ld a, e
    and a
    jr z, .done
    jr .fill

.partial
    ld a, $63
    add e
    ld [hl], a
.done
    pop bc
    pop de
    pop hl
    ret

LoadMonData::
    ld hl, BANK01_LOAD_MON_DATA_ADDR
    ld b, PARTY_MON_DATA_BANK
    jp BANK00_FARCALL_ADDR

OverwritewMoves::
    ld hl, wMoves
    ld e, b
    ld d, $00
    add hl, de
    ld a, c
    ld [hl], a
    ret

IF DEF(_REV0)
    ASSERT @ == $2D7A
ELIF DEF(_REVA)
    ASSERT @ == $2D68
ENDC
