; Print packed BCD values to the tilemap.

PrintBCDNumber::
    ld b, c
    res BIT_BCD_LEADING_ZEROES, c
    res BIT_BCD_LEFT_ALIGN, c
.loop
    ld a, [de]
    swap a
    call PrintBCDDigit
    ld a, [de]
    call PrintBCDDigit
    inc de
    dec c
    jr nz, .loop
    bit BIT_BCD_LEADING_ZEROES, b
    jr z, .done
    bit BIT_BCD_LEFT_ALIGN, b
    jr nz, .skipRightAlignmentAdjustment
    dec hl
.skipRightAlignmentAdjustment
    ld [hl], BCD_ZERO_TILE
    call BANK00_PRINT_LETTER_DELAY_ADDR
    inc hl
.done
    ret

PrintBCDDigit::
    and $0F
    and a
    jr z, .zeroDigit
    res BIT_BCD_LEADING_ZEROES, b
.outputDigit
    add BCD_ZERO_TILE
    ld [hli], a
    jp BANK00_PRINT_LETTER_DELAY_ADDR
.zeroDigit
    bit BIT_BCD_LEADING_ZEROES, b
    jr z, .outputDigit
    bit BIT_BCD_LEFT_ALIGN, b
    ret nz
    inc hl
    ret

IF DEF(_REV0)
    ASSERT @ == $2FFD
ELIF DEF(_REVA)
    ASSERT @ == $2FEB
ENDC
