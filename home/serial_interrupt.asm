; $0BA7-$0BF0
; Serial interrupt handler. Byte-identical in Midori Rev 0 and Rev A.

ASSERT @ == $0BA7
Serial::
    push af
    push bc
    push de
    push hl

    ldh a, [hSerialConnectionStatus]
    inc a
    jr z, .connectionNotYetEstablished

    ldh a, [rSB]
    ldh [hSerialReceiveData], a
    ldh a, [hSerialSendData]
    ldh [rSB], a
    ldh a, [hSerialConnectionStatus]
    cp USING_INTERNAL_CLOCK
    jr z, .done

    ld a, SC_START | SC_EXTERNAL
    ldh [rSC], a
    jr .done

.connectionNotYetEstablished
    ldh a, [rSB]
    ldh [hSerialReceiveData], a
    ldh [hSerialConnectionStatus], a
    cp USING_INTERNAL_CLOCK
    jr z, .usingInternalClock

    xor a
    ldh [rSB], a
    ld a, $03
    ldh [rDIV], a
.waitLoop
    ldh a, [rDIV]
    bit 7, a
    jr nz, .waitLoop
    ld a, SC_START | SC_EXTERNAL
    ldh [rSC], a
    jr .done

.usingInternalClock
    xor a
    ldh [rSB], a

.done
    ld a, 1
    ldh [hSerialReceivedNewData], a
    ld a, SERIAL_NO_DATA_BYTE
    ldh [hSerialSendData], a
    pop hl
    pop de
    pop bc
    pop af
    reti

ASSERT @ == $0BF1
