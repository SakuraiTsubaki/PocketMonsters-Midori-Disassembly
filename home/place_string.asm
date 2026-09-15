; $0405-$04C8
; Core Japanese text byte parser and kana diacritic handling.

MACRO text_control_jump
    IF \1 == 0
        and a
    ELSE
        cp \1
    ENDC
    jp z, \2
ENDM

PlaceString::
    push hl

PlaceNextChar::
    ld a, [de]
    cp TEXT_TERMINATOR
    jr nz, .NotTerminator
    ld b, h
    ld c, l
    pop hl
    ret

.NotTerminator
    cp TEXT_NEXT
    jr nz, .NotNext
    pop hl
    ld bc, 2 * SCREEN_WIDTH
    add hl, bc
    push hl
    jp NextChar

.NotNext
    cp TEXT_LINE
    jr nz, .NotLine
    pop hl
    ld hl, wTileMap + (16 * SCREEN_WIDTH) + 1
    push hl
    jp NextChar

.NotLine
    text_control_jump TEXT_NULL, BANK00_NULL_CHAR_ADDR
    text_control_jump TEXT_SCROLL, BANK00_CONT_TEXT_NO_PAUSE_ADDR
    text_control_jump TEXT_CONTINUE_INTERNAL, BANK00_CONT_TEXT_INTERNAL_ADDR
    text_control_jump TEXT_PARAGRAPH, BANK00_PARAGRAPH_ADDR
    text_control_jump TEXT_PLAYER, BANK00_PRINT_PLAYER_NAME_ADDR
    text_control_jump TEXT_RIVAL, BANK00_PRINT_RIVAL_NAME_ADDR
    text_control_jump TEXT_POKE, BANK00_PLACE_POKE_ADDR
    text_control_jump TEXT_PC, BANK00_PC_CHAR_ADDR
    text_control_jump TEXT_ROCKET, BANK00_ROCKET_CHAR_ADDR
    text_control_jump TEXT_TM, BANK00_TM_CHAR_ADDR
    text_control_jump TEXT_TRAINER, BANK00_TRAINER_CHAR_ADDR
    text_control_jump TEXT_CONTINUE, BANK00_CONT_TEXT_ADDR
    text_control_jump TEXT_SIX_DOTS, BANK00_SIX_DOTS_CHAR_ADDR
    text_control_jump TEXT_DONE, BANK00_DONE_TEXT_ADDR
    text_control_jump TEXT_PROMPT, BANK00_PROMPT_TEXT_ADDR
    text_control_jump TEXT_TARGET, BANK00_PLACE_MOVE_TARGET_ADDR
    text_control_jump TEXT_USER, BANK00_PLACE_MOVE_USER_ADDR

    ; Japanese dakuten / handakuten handling.
    cp TEXT_HANDAKUTEN
    jr z, .PlaceDiacriticSymbol
    cp TEXT_DAKUTEN
    jr nz, .KanaCharacter

.PlaceDiacriticSymbol
    push hl
    ld bc, -SCREEN_WIDTH
    add hl, bc
    ld [hl], a
    pop hl
    jr NextChar

.KanaCharacter
    cp FIRST_REGULAR_TEXT_CHAR
    jr nc, .RegularKana
    cp FIRST_KATAKANA_HANDAKUTEN_CHAR
    jr nc, .Handakuten
    cp FIRST_HIRAGANA_DAKUTEN_CHAR
    jr nc, .HiraganaDakuten

    ; Katakana dakuten form -> base kana.
    add $80
    jr .PlaceDakuten

.HiraganaDakuten
    add $90

.PlaceDakuten
    push af
    ld a, TEXT_DAKUTEN
    push hl
    ld bc, -SCREEN_WIDTH
    add hl, bc
    ld [hl], a
    pop hl
    pop af
    jr .RegularKana

.Handakuten
    cp FIRST_HIRAGANA_HANDAKUTEN_CHAR
    jr nc, .HiraganaHandakuten

    ; Katakana handakuten form -> base kana.
    add $59
    jr .PlaceHandakuten

.HiraganaHandakuten
    add $86

.PlaceHandakuten
    push af
    ld a, TEXT_HANDAKUTEN
    push hl
    ld bc, -SCREEN_WIDTH
    add hl, bc
    ld [hl], a
    pop hl
    pop af

.RegularKana
    ld [hli], a
    call BANK00_PRINT_LETTER_DELAY_ADDR

NextChar::
    inc de
    jp PlaceNextChar
