; $0555-$05F0
; Dialogue continuation, prompt, paragraph and scrolling flow.

ContText::
    push de
    ld b, h
    ld c, l
    ld hl, ContCharText
    call BANK00_TEXT_COMMAND_PROCESSOR_ADDR
    ld h, b
    ld l, c
    pop de
    inc de
    jp PlaceNextChar

ContCharText::
    db TEXT_COMMAND_START, TEXT_CONTINUE_INTERNAL, TEXT_TERMINATOR
    db TEXT_TERMINATOR

PromptText::
    ld a, [wLinkState]
    cp LINK_STATE_BATTLING
    jp z, .ok
    ld a, TEXT_DOWN_ARROW
    ld [wTileMap + (16 * SCREEN_WIDTH) + 18], a
.ok
    call ProtectedDelay3
    call BANK00_MANUAL_TEXT_SCROLL_ADDR
    ld a, TEXT_BLANK
    ld [wTileMap + (16 * SCREEN_WIDTH) + 18], a

DoneText::
    pop hl
    ld de, .stop
    dec de
    ret

.stop
    db TEXT_TERMINATOR

Paragraph::
    push de
    ld a, TEXT_DOWN_ARROW
    ld [wTileMap + (16 * SCREEN_WIDTH) + 18], a
    call ProtectedDelay3
    call BANK00_MANUAL_TEXT_SCROLL_ADDR
    ld hl, wTileMap + (13 * SCREEN_WIDTH) + 1
    ld bc, $0412 ; 4 rows × 18 inner tiles
    call ClearScreenArea
    ld c, 20
    call BANK00_DELAY_FRAMES_ADDR
    pop de
    ld hl, wTileMap + (14 * SCREEN_WIDTH) + 1
    jp NextChar

_ContText::
    ld a, TEXT_DOWN_ARROW
    ld [wTileMap + (16 * SCREEN_WIDTH) + 18], a
    call ProtectedDelay3
    push de
    call BANK00_MANUAL_TEXT_SCROLL_ADDR
    pop de
    ld a, TEXT_BLANK
    ld [wTileMap + (16 * SCREEN_WIDTH) + 18], a

_ContTextNoPause::
    push de
    call ScrollTextUpOneLine
    call ScrollTextUpOneLine
    ld hl, wTileMap + (16 * SCREEN_WIDTH) + 1
    pop de
    jp NextChar

ScrollTextUpOneLine::
    ld hl, wTileMap + (14 * SCREEN_WIDTH)
    ld de, wTileMap + (13 * SCREEN_WIDTH)
    ld b, SCREEN_WIDTH * 3
.copyText
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .copyText

    ld hl, wTileMap + (16 * SCREEN_WIDTH) + 1
    ld a, TEXT_BLANK
    ld b, SCREEN_WIDTH - 2
.clearText
    ld [hli], a
    dec b
    jr nz, .clearText

    ld b, 5
.WaitFrame
    call BANK00_DELAY_FRAME_ADDR
    dec b
    jr nz, .WaitFrame
    ret

ProtectedDelay3::
    push bc
    call BANK00_DELAY3_ADDR
    pop bc
    ret
