; 124-byte link helper block.
; Rev 0 places this block before Serial_ExchangeByte; Rev A places it after.

IF DEF(_REV0)
    ASSERT @ == $0C2E
ELIF DEF(_REVA)
    ASSERT @ == $0CC9
ENDC

Serial_ExchangeLinkMenuSelection::
    ld hl, wLinkMenuSelectionSendBuffer
    ld de, wLinkMenuSelectionReceiveBuffer
    ld c, 2
    ld a, 1
    ldh [hSerialIgnoringInitialData], a
.loop
    call DelayFrame
    ld a, [hl]
    ldh [hSerialSendData], a
    call Serial_ExchangeByte
    ld b, a
    inc hl
    ldh a, [hSerialIgnoringInitialData]
    and a
    ld a, 0
    ldh [hSerialIgnoringInitialData], a
    jr nz, .loop
    ld a, b
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ret

Serial_PrintWaitingTextAndSyncAndExchangeNybble::
    call BANK00_SAVE_SCREEN_TILES_ADDR
    ld hl, BANK00_PRINT_WAITING_TEXT_ADDR
    ld b, $01
    call BANK00_FARCALL_ADDR
    call Serial_SyncAndExchangeNybble
    jp BANK00_LOAD_SCREEN_TILES_ADDR

Serial_SyncAndExchangeNybble::
    ld a, $FF
    ld [wSerialExchangeNybbleReceiveData], a
.loop1
    call Serial_ExchangeNybble
    call DelayFrame
    call IsUnknownCounterZero
    jr z, .next1
    push hl
    ld hl, wUnknownSerialCounter + 1
    dec [hl]
    jr nz, .next2
    dec hl
    dec [hl]
    jr nz, .next2
    pop hl
    xor a
    jp SetUnknownCounterToFFFF
.next2
    pop hl
.next1
    ld a, [wSerialExchangeNybbleReceiveData]
    inc a
    jr z, .loop1

    ld b, 10
.loop2
    call DelayFrame
    call Serial_ExchangeNybble
    dec b
    jr nz, .loop2

    ld b, 10
.loop3
    call DelayFrame
    call Serial_SendZeroByte
    dec b
    jr nz, .loop3

    ld a, [wSerialExchangeNybbleReceiveData]
    ld [wSerialSyncAndExchangeNybbleReceiveData], a
    ret

IF DEF(_REV0)
    ASSERT @ == $0CAA
ELIF DEF(_REVA)
    ASSERT @ == $0D45
ENDC
