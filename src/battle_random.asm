; Link-synchronised battle RNG reconstructed across both Green revisions.
BattleRandom:
    ld a, [wLinkState]
    cp LINK_STATE_BATTLING
    jp nz, Random
    push hl
    push bc
    ld a, [wLinkBattleRandomNumberListIndex]
    ld c, a
    ld b, 0
    ld hl, wLinkBattleRandomNumberList
    add hl, bc
    inc a
    ld [wLinkBattleRandomNumberListIndex], a
    cp SERIAL_RNS_LENGTH - 1
    ld a, [hl]
    pop bc
    pop hl
    ret c
    push hl
    push bc
    push af
    xor a
    ld [wLinkBattleRandomNumberListIndex], a
    ld hl, wLinkBattleRandomNumberList
    ld b, SERIAL_RNS_LENGTH - 1
.loop
    ld a, [hl]
    ld c, a
    add a
    add a
    add c
    inc a
    ld [hli], a
    dec b
    jr nz, .loop
    pop af
    pop bc
    pop hl
    ret
