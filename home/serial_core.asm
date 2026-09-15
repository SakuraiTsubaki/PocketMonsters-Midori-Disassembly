; $0BF1 through the revision-specific Timer boundary.
; Rev 0 and Rev A contain the same major serial routines, but serial2.asm is
; physically located on opposite sides of Serial_ExchangeByte.

ASSERT @ == $0BF1
Serial_ExchangeBytes::
    ld a, 1
    ldh [hSerialIgnoringInitialData], a
.loop
    ld a, [hl]
    ldh [hSerialSendData], a
    call Serial_ExchangeByte
    push bc
    ld b, a
    inc hl
    ld a, 48
.waitLoop
    dec a
    jr nz, .waitLoop
    ldh a, [hSerialIgnoringInitialData]
    and a
    ld a, b
    pop bc
    jr z, .storeReceivedByte
    dec hl
    cp SERIAL_PREAMBLE_BYTE
    jr nz, .loop
    xor a
    ldh [hSerialIgnoringInitialData], a
    jr .loop

.storeReceivedByte
IF DEF(_REV0)
    push af
    ld a, [wLinkState]
    cp LINK_STATE_RESET
    jr nz, .next
    ldh a, [hSerialConnectionStatus]
    cp USING_INTERNAL_CLOCK
    jr nz, .next
    ld de, wNameBuffer
.next
    pop af
ENDC
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret

IF DEF(_REV0)
    ASSERT @ == $0C2E
    INCLUDE "home/serial2.asm"
    ASSERT @ == $0CAA
ELIF DEF(_REVA)
    ASSERT @ == $0C1C
ENDC

Serial_ExchangeByte::
    xor a
    ldh [hSerialReceivedNewData], a
    ldh a, [hSerialConnectionStatus]
    cp USING_INTERNAL_CLOCK
    jr nz, .loop
    ld a, SC_START | SC_INTERNAL
    ldh [rSC], a
.loop
    ldh a, [hSerialReceivedNewData]
    and a
    jr nz, .ok
    ldh a, [hSerialConnectionStatus]
    cp USING_EXTERNAL_CLOCK
    jr nz, .doNotIncrementUnknownCounter
    call IsUnknownCounterZero
    jr z, .doNotIncrementUnknownCounter
    call WaitLoop_15Iterations
    push hl
    ld hl, wUnknownSerialCounter + 1
    inc [hl]
    jr nz, .noCarry
    dec hl
    inc [hl]
.noCarry
    pop hl
    call IsUnknownCounterZero
    jr nz, .loop
    jp SetUnknownCounterToFFFF

.doNotIncrementUnknownCounter
    ldh a, [rIE]
    and IE_SERIAL | IE_TIMER | IE_STAT | IE_VBLANK
    cp IE_SERIAL
    jr nz, .loop
    ld a, [wUnknownSerialCounter2]
    dec a
    ld [wUnknownSerialCounter2], a
    jr nz, .loop
    ld a, [wUnknownSerialCounter2 + 1]
    dec a
    ld [wUnknownSerialCounter2 + 1], a
    jr nz, .loop
    ldh a, [hSerialConnectionStatus]
    cp USING_EXTERNAL_CLOCK
    jr z, .ok
    ld a, 255
.waitLoop
    dec a
    jr nz, .waitLoop

.ok
    xor a
    ldh [hSerialReceivedNewData], a
    ldh a, [rIE]
    and IE_SERIAL | IE_TIMER | IE_STAT | IE_VBLANK
    sub IE_SERIAL
    jr nz, .skipReloadingUnknownCounter2
    ld [wUnknownSerialCounter2], a
    ld a, $50
    ld [wUnknownSerialCounter2 + 1], a
.skipReloadingUnknownCounter2
    ldh a, [hSerialReceiveData]
    cp SERIAL_NO_DATA_BYTE
    ret nz
    call IsUnknownCounterZero
    jr z, .done
    push hl
    ld hl, wUnknownSerialCounter + 1
    ld a, [hl]
    dec a
    ld [hld], a
    inc a
    jr nz, .noBorrow
    dec [hl]
.noBorrow
    pop hl
    call IsUnknownCounterZero
    jr z, SetUnknownCounterToFFFF

.done
    ldh a, [rIE]
    and IE_SERIAL | IE_TIMER | IE_STAT | IE_VBLANK
    cp IE_SERIAL
    ld a, SERIAL_NO_DATA_BYTE
    ret z
    ld a, [hl]
    ldh [hSerialSendData], a
    call DelayFrame
    jp Serial_ExchangeByte

IF DEF(_REV0)
    ASSERT @ == $0D41
ELIF DEF(_REVA)
    ASSERT @ == $0CB3
ENDC
WaitLoop_15Iterations::
    ld a, 15
.waitLoop
    dec a
    jr nz, .waitLoop
    ret

IF DEF(_REV0)
    ASSERT @ == $0D47
ELIF DEF(_REVA)
    ASSERT @ == $0CB9
ENDC
IsUnknownCounterZero::
    push hl
    ld hl, wUnknownSerialCounter
    ld a, [hli]
    or [hl]
    pop hl
    ret

IF DEF(_REV0)
    ASSERT @ == $0D4F
ELIF DEF(_REVA)
    ASSERT @ == $0CC1
ENDC
SetUnknownCounterToFFFF::
    dec a
    ld [wUnknownSerialCounter], a
    ld [wUnknownSerialCounter + 1], a
    ret

IF DEF(_REVA)
    ASSERT @ == $0CC9
    INCLUDE "home/serial2.asm"
    ASSERT @ == $0D45
ENDC

IF DEF(_REV0)
    ASSERT @ == $0D57
ELIF DEF(_REVA)
    ASSERT @ == $0D45
ENDC
Serial_ExchangeNybble::
    call .doExchange
    ld a, [wSerialExchangeNybbleSendData]
    add $60
    ldh [hSerialSendData], a
    ldh a, [hSerialConnectionStatus]
    cp USING_INTERNAL_CLOCK
    jr nz, .doExchange
    ld a, SC_START | SC_INTERNAL
    ldh [rSC], a
.doExchange
    ldh a, [hSerialReceiveData]
    ld [wSerialExchangeNybbleTempReceiveData], a
    and $F0
    cp $60
    ret nz
    xor a
    ldh [hSerialReceiveData], a
    ld a, [wSerialExchangeNybbleTempReceiveData]
    and $0F
    ld [wSerialExchangeNybbleReceiveData], a
    ret

IF DEF(_REV0)
    ASSERT @ == $0D81
ELIF DEF(_REVA)
    ASSERT @ == $0D6F
ENDC
Serial_SendZeroByte::
    xor a
    ldh [hSerialSendData], a
    ldh a, [hSerialConnectionStatus]
    cp USING_INTERNAL_CLOCK
    ret nz
    ld a, SC_START | SC_INTERNAL
    ldh [rSC], a
    ret

IF DEF(_REV0)
    ASSERT @ == $0D8E
ELIF DEF(_REVA)
    ASSERT @ == $0D7C
ENDC
Serial_TryEstablishingExternallyClockedConnection::
    ld a, $02
    ldh [rSB], a
    xor a
    ldh [hSerialReceiveData], a
    ld a, SC_START | SC_EXTERNAL
    ldh [rSC], a
    ret

IF DEF(_REV0)
    ASSERT @ == $0D9A
ELIF DEF(_REVA)
    ASSERT @ == $0D88
ENDC
