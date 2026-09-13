; $028C-$03D1

FarCopyData2::
    ldh [hROMBankTemp], a
    ldh a, [hLoadedROMBank]
    push af
    ldh a, [hROMBankTemp]
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call CopyData
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

FarCopyData3::
    ; Copy BC bytes from bank A at DE to HL while preserving both pointers.
    ldh [hROMBankTemp], a
    ldh a, [hLoadedROMBank]
    push af
    ldh a, [hROMBankTemp]
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    push hl
    push de
    push de
    ld d, h
    ld e, l
    pop hl
    call CopyData
    pop de
    pop hl
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

FarCopyDataDouble::
    ; Expand BC bytes of 1bpp data to duplicated 2bpp bytes.
    ldh [hROMBankTemp], a
    ldh a, [hLoadedROMBank]
    push af
    ldh a, [hROMBankTemp]
    ldh [hLoadedROMBank], a
    ld [rROMB], a
.loop
    ld a, [hli]
    ld [de], a
    inc de
    ld [de], a
    inc de
    dec bc
    ld a, c
    or b
    jr nz, .loop
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

CopyVideoData::
    ; Copy C 2bpp tiles from bank B:DE to HL in chunks of eight tiles/frame.
    ldh a, [hAutoBGTransferEnabled]
    push af
    xor a
    ldh [hAutoBGTransferEnabled], a

    ldh a, [hLoadedROMBank]
    ldh [hROMBankTemp], a

    ld a, b
    ldh [hLoadedROMBank], a
    ld [rROMB], a

    ld a, e
    ldh [hVBlankCopySource], a
    ld a, d
    ldh [hVBlankCopySource + 1], a
    ld a, l
    ldh [hVBlankCopyDest], a
    ld a, h
    ldh [hVBlankCopyDest + 1], a

.loop
    ld a, c
    cp 8
    jr nc, .keepGoing

    ldh [hVBlankCopySize], a
    call BANK00_DELAY_FRAME_ADDR
    ldh a, [hROMBankTemp]
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    pop af
    ldh [hAutoBGTransferEnabled], a
    ret

.keepGoing
    ld a, 8
    ldh [hVBlankCopySize], a
    call BANK00_DELAY_FRAME_ADDR
    ld a, c
    sub 8
    ld c, a
    jr .loop

CopyVideoDataDouble::
    ; Copy C 1bpp tiles from bank B:DE to HL, expanding during VBlank.
    ldh a, [hAutoBGTransferEnabled]
    push af
    xor a
    ldh [hAutoBGTransferEnabled], a

    ldh a, [hLoadedROMBank]
    ldh [hROMBankTemp], a

    ld a, b
    ldh [hLoadedROMBank], a
    ld [rROMB], a

    ld a, e
    ldh [hVBlankCopyDoubleSource], a
    ld a, d
    ldh [hVBlankCopyDoubleSource + 1], a
    ld a, l
    ldh [hVBlankCopyDoubleDest], a
    ld a, h
    ldh [hVBlankCopyDoubleDest + 1], a

.loop
    ld a, c
    cp 8
    jr nc, .keepGoing

    ldh [hVBlankCopyDoubleSize], a
    call BANK00_DELAY_FRAME_ADDR
    ldh a, [hROMBankTemp]
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    pop af
    ldh [hAutoBGTransferEnabled], a
    ret

.keepGoing
    ld a, 8
    ldh [hVBlankCopyDoubleSize], a
    call BANK00_DELAY_FRAME_ADDR
    ld a, c
    sub 8
    ld c, a
    jr .loop

CheckForUserInterruption::
    call BANK00_DELAY_FRAME_ADDR
    push bc
    call BANK00_JOYPAD_LOW_SENSITIVITY_ADDR
    pop bc

    ldh a, [hJoyHeld]
    cp TITLE_INTERRUPT_COMBO
    jr z, .input

    ldh a, [hJoy5]
    and TITLE_ACCEPT_MASK
    jr nz, .input

    dec c
    jr nz, CheckForUserInterruption
    and a
    ret

.input
    scf
    ret

ClearScreenArea::
    ; Clear a C-by-B tile rectangle beginning at HL.
    ld a, JAPANESE_BLANK_TILE
    ld de, SCREEN_WIDTH
.loopRows
    push hl
    push bc
.loopTiles
    ld [hli], a
    dec c
    jr nz, .loopTiles
    pop bc
    pop hl
    add hl, de
    dec b
    jr nz, .loopRows
    ret

CopyScreenTileBufferToVRAM::
    ; Copy the 18-row tilemap in three six-row VBlank transfers.
    ld c, SCREEN_HEIGHT / 3

    ld hl, $0000
    ld de, wTileMap
    call .setup
    call BANK00_DELAY_FRAME_ADDR

    ld hl, $0600
    ld de, wTileMap + (SCREEN_WIDTH * 6)
    call .setup
    call BANK00_DELAY_FRAME_ADDR

    ld hl, $0C00
    ld de, wTileMap + (SCREEN_WIDTH * 12)
    call .setup
    jp BANK00_DELAY_FRAME_ADDR

.setup
    ld a, d
    ldh [hVBlankCopyBGSource + 1], a
    call BANK00_GET_ROWCOL_BG_ADDR
    ld a, l
    ldh [hVBlankCopyBGDest], a
    ld a, h
    ldh [hVBlankCopyBGDest + 1], a
    ld a, c
    ldh [hVBlankCopyBGNumRows], a
    ld a, e
    ldh [hVBlankCopyBGSource], a
    ret

ClearScreen::
    ld bc, SCREEN_AREA
    inc b
    ld hl, wTileMap
    ld a, JAPANESE_BLANK_TILE
.loop
    ld [hli], a
    dec c
    jr nz, .loop
    dec b
    jr nz, .loop
    jp BANK00_DELAY3_ADDR
