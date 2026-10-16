_Multiply::
    ld a, 8
    ld b, a
    xor a
    ldh [hProduct], a
    ldh [hMultiplyBuffer], a
    ldh [hMultiplyBuffer + 1], a
    ldh [hMultiplyBuffer + 2], a
    ldh [hMultiplyBuffer + 3], a
.loop
    ldh a, [hMultiplier]
    srl a
    ldh [hMultiplier], a
    jr nc, .smallMultiplier
    ldh a, [hMultiplyBuffer + 3]
    ld c, a
    ldh a, [hMultiplicand + 2]
    add c
    ldh [hMultiplyBuffer + 3], a
    ldh a, [hMultiplyBuffer + 2]
    ld c, a
    ldh a, [hMultiplicand + 1]
    adc c
    ldh [hMultiplyBuffer + 2], a
    ldh a, [hMultiplyBuffer + 1]
    ld c, a
    ldh a, [hMultiplicand]
    adc c
    ldh [hMultiplyBuffer + 1], a
    ldh a, [hMultiplyBuffer]
    ld c, a
    ldh a, [hProduct]
    adc c
    ldh [hMultiplyBuffer], a
.smallMultiplier
    dec b
    jr z, .done
    ldh a, [hMultiplicand + 2]
    sla a
    ldh [hMultiplicand + 2], a
    ldh a, [hMultiplicand + 1]
    rl a
    ldh [hMultiplicand + 1], a
    ldh a, [hMultiplicand]
    rl a
    ldh [hMultiplicand], a
    ldh a, [hProduct]
    rl a
    ldh [hProduct], a
    jr .loop
.done
    ldh a, [hMultiplyBuffer + 3]
    ldh [hProduct + 3], a
    ldh a, [hMultiplyBuffer + 2]
    ldh [hProduct + 2], a
    ldh a, [hMultiplyBuffer + 1]
    ldh [hProduct + 1], a
    ldh a, [hMultiplyBuffer]
    ldh [hProduct], a
    ret
