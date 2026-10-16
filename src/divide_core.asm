_Divide::
    xor a
    ldh [hDivideBuffer], a
    ldh [hDivideBuffer + 1], a
    ldh [hDivideBuffer + 2], a
    ldh [hDivideBuffer + 3], a
    ldh [hDivideBuffer + 4], a
    ld a, 9
    ld e, a
.loop
    ldh a, [hDivideBuffer]
    ld c, a
    ldh a, [hDividend + 1]
    sub c
    ld d, a
    ldh a, [hDivisor]
    ld c, a
    ldh a, [hDividend]
    sbc c
    jr c, .next
    ldh [hDividend], a
    ld a, d
    ldh [hDividend + 1], a
    ldh a, [hDivideBuffer + 4]
    inc a
    ldh [hDivideBuffer + 4], a
    jr .loop
.next
    ld a, b
    cp 1
    jr z, .done
    ldh a, [hDivideBuffer + 4]
    sla a
    ldh [hDivideBuffer + 4], a
    ldh a, [hDivideBuffer + 3]
    rl a
    ldh [hDivideBuffer + 3], a
    ldh a, [hDivideBuffer + 2]
    rl a
    ldh [hDivideBuffer + 2], a
    ldh a, [hDivideBuffer + 1]
    rl a
    ldh [hDivideBuffer + 1], a
    dec e
    jr nz, .next2
    ld a, 8
    ld e, a
    ldh a, [hDivideBuffer]
    ldh [hDivisor], a
    xor a
    ldh [hDivideBuffer], a
    ldh a, [hDividend + 1]
    ldh [hDividend], a
    ldh a, [hDividend + 2]
    ldh [hDividend + 1], a
    ldh a, [hDividend + 3]
    ldh [hDividend + 2], a
.next2
    ld a, e
    cp 1
    jr nz, .okay
    dec b
.okay
    ldh a, [hDivisor]
    srl a
    ldh [hDivisor], a
    ldh a, [hDivideBuffer]
    rr a
    ldh [hDivideBuffer], a
    jr .loop
.done
    ldh a, [hDividend + 1]
    ldh [hRemainder], a
    ldh a, [hDivideBuffer + 4]
    ldh [hQuotient + 3], a
    ldh a, [hDivideBuffer + 3]
    ldh [hQuotient + 2], a
    ldh a, [hDivideBuffer + 2]
    ldh [hQuotient + 1], a
    ldh a, [hDivideBuffer + 1]
    ldh [hQuotient], a
    ret
