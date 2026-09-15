; $03D2-$0404
; Draw a C-by-B text box at HL using the original Japanese UI tiles.

TextBoxBorder::
    ; Top row.
    push hl
    ld a, TEXTBOX_TOP_LEFT
    ld [hli], a
    inc a
    call .PlaceChars
    inc a
    ld [hl], a
    pop hl

    ld de, SCREEN_WIDTH
    add hl, de

    ; Middle rows.
.next
    push hl
    ld a, TEXTBOX_VERTICAL
    ld [hli], a
    ld a, TEXT_BLANK
    call .PlaceChars
    ld [hl], TEXTBOX_VERTICAL
    pop hl

    ld de, SCREEN_WIDTH
    add hl, de
    dec b
    jr nz, .next

    ; Bottom row.
    ld a, TEXTBOX_BOTTOM_LEFT
    ld [hli], a
    ld a, TEXTBOX_HORIZONTAL
    call .PlaceChars
    ld [hl], TEXTBOX_BOTTOM_RIGHT
    ret

.PlaceChars
    ld d, c
.loop
    ld [hli], a
    dec d
    jr nz, .loop
    ret
