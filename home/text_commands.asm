; $05F1-$0773
; Text command virtual machine and command dispatch table.

TextCommandProcessor::
    ld a, [wLetterPrintingDelayFlags]
    push af
    set BIT_TEXT_DELAY, a
    ld [wLetterPrintingDelayFlags], a
    ld a, c
    ld [wTextDest], a
    ld a, b
    ld [wTextDest + 1], a

NextTextCommand::
    ld a, [hli]
    cp TX_END
    jr nz, .TextCommand
    pop af
    ld [wLetterPrintingDelayFlags], a
    ret

.TextCommand
    push hl
    ld hl, TextCommandJumpTable
    push bc
    add a
    ld b, 0
    ld c, a
    add hl, bc
    pop bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    jp hl

TextCommand_BOX::
    pop hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld c, a
    push hl
    ld h, d
    ld l, e
    call TextBoxBorder
    pop hl
    jr NextTextCommand

TextCommand_START::
    pop hl
    ld d, h
    ld e, l
    ld h, b
    ld l, c
    call PlaceString
    ld h, d
    ld l, e
    inc hl
    jr NextTextCommand

TextCommand_RAM::
    pop hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    push hl
    ld h, b
    ld l, c
    call PlaceString
    pop hl
    jr NextTextCommand

TextCommand_BCD::
    pop hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    push hl
    ld h, b
    ld l, c
    ld c, a
    call BANK00_PRINT_BCD_NUMBER_ADDR
    ld b, h
    ld c, l
    pop hl
    jr NextTextCommand

TextCommand_MOVE::
    pop hl
    ld a, [hli]
    ld [wTextDest], a
    ld c, a
    ld a, [hli]
    ld [wTextDest + 1], a
    ld b, a
    jp NextTextCommand

TextCommand_LOW::
    pop hl
    ld bc, wTileMap + (16 * SCREEN_WIDTH) + 1
    jp NextTextCommand

TextCommand_PROMPT_BUTTON::
    ld a, [wLinkState]
    cp LINK_STATE_BATTLING
    jp z, TextCommand_WAIT_BUTTON
    ld a, TEXT_DOWN_ARROW
    ld [wTileMap + (16 * SCREEN_WIDTH) + 18], a
    push bc
    call BANK00_MANUAL_TEXT_SCROLL_ADDR
    pop bc
    ld a, TEXT_BLANK
    ld [wTileMap + (16 * SCREEN_WIDTH) + 18], a
    pop hl
    jp NextTextCommand

TextCommand_SCROLL::
    ld a, TEXT_BLANK
    ld [wTileMap + (16 * SCREEN_WIDTH) + 18], a
    call ScrollTextUpOneLine
    call ScrollTextUpOneLine
    pop hl
    ld bc, wTileMap + (16 * SCREEN_WIDTH) + 1
    jp NextTextCommand

TextCommand_START_ASM::
    pop hl
    ld de, NextTextCommand
    push de
    jp hl

TextCommand_NUM::
    pop hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    push hl
    ld h, b
    ld l, c
    ld b, a
    and $0F
    ld c, a
    ld a, b
    and $F0
    swap a
    set BIT_LEFT_ALIGN, a
    ld b, a
    call BANK00_PRINT_NUMBER_ADDR
    ld b, h
    ld c, l
    pop hl
    jp NextTextCommand

TextCommand_PAUSE::
    push bc
    call Joypad
    ldh a, [hJoyHeld]
    and PAD_A | PAD_B
    jr nz, .done
    ld c, 30
    call BANK00_DELAY_FRAMES_ADDR
.done
    pop bc
    pop hl
    jp NextTextCommand

TextCommand_SOUND::
    pop hl
    push bc
    dec hl
    ld a, [hli]
    ld b, a
    push hl
    ld hl, TextCommandSounds
.loop
    ld a, [hli]
    cp b
    jr z, .play
    inc hl
    jr .loop

.play
    cp TX_SOUND_CRY_NIDORINA
    jr z, .pokemonCry
    cp TX_SOUND_CRY_PIDGEOT
    jr z, .pokemonCry
    cp TX_SOUND_CRY_DEWGONG
    jr z, .pokemonCry
    ld a, [hl]
    call BANK00_PLAY_SOUND_ADDR
    call BANK00_WAIT_FOR_SOUND_ADDR
    pop hl
    pop bc
    jp NextTextCommand

.pokemonCry
    push de
    ld a, [hl]
    call BANK00_PLAY_CRY_ADDR
    pop de
    pop hl
    pop bc
    jp NextTextCommand

TextCommandSounds::
    db TX_SOUND_GET_ITEM_1,           SFX_GET_ITEM_1
    db TX_SOUND_CAUGHT_MON,           SFX_CAUGHT_MON
    db TX_SOUND_POKEDEX_RATING,       SFX_POKEDEX_RATING
    db TX_SOUND_GET_ITEM_1_DUPLICATE, SFX_GET_ITEM_1
    db TX_SOUND_GET_ITEM_2,           SFX_GET_ITEM_2
    db TX_SOUND_GET_KEY_ITEM,         SFX_GET_KEY_ITEM
    db TX_SOUND_DEX_PAGE_ADDED,       SFX_DEX_PAGE_ADDED
    db TX_SOUND_CRY_NIDORINA,         NIDORINA_INTERNAL_ID
    db TX_SOUND_CRY_PIDGEOT,          PIDGEOT_INTERNAL_ID
    db TX_SOUND_CRY_DEWGONG,          DEWGONG_INTERNAL_ID

TextCommand_DOTS::
    pop hl
    ld a, [hli]
    ld d, a
    push hl
    ld h, b
    ld l, c
.loop
    ld a, $75 ; Japanese ellipsis tile
    ld [hli], a
    push de
    call Joypad
    pop de
    ldh a, [hJoyHeld]
    and PAD_A | PAD_B
    jr nz, .next
    ld c, 10
    call BANK00_DELAY_FRAMES_ADDR
.next
    dec d
    jr nz, .loop
    ld b, h
    ld c, l
    pop hl
    jp NextTextCommand

TextCommand_WAIT_BUTTON::
    push bc
    call BANK00_MANUAL_TEXT_SCROLL_ADDR
    pop bc
    pop hl
    jp NextTextCommand

TextCommandJumpTable::
    dw TextCommand_START
    dw TextCommand_RAM
    dw TextCommand_BCD
    dw TextCommand_MOVE
    dw TextCommand_BOX
    dw TextCommand_LOW
    dw TextCommand_PROMPT_BUTTON
    dw TextCommand_SCROLL
    dw TextCommand_START_ASM
    dw TextCommand_NUM
    dw TextCommand_PAUSE
    dw TextCommand_SOUND
    dw TextCommand_DOTS
    dw TextCommand_WAIT_BUTTON
    dw TextCommand_SOUND
    dw TextCommand_SOUND
    dw TextCommand_SOUND
    dw TextCommand_SOUND
    dw TextCommand_SOUND
    dw TextCommand_SOUND
    dw TextCommand_SOUND
    dw TextCommand_SOUND
    dw TextCommand_SOUND

ASSERT @ == $0774
