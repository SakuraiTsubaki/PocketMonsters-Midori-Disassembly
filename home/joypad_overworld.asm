; Update overworld input, apply Cycling Road's forced movement, and service
; scripted joypad sequences.

JoypadOverworld::
    xor a
    ld [wSpritePlayerStateData1YStepVector], a
    ld [wSpritePlayerStateData1XStepVector], a
    call BANK00_RUN_MAP_SCRIPT_ADDR
    call Joypad
    ld a, [wStatusFlags7]
    bit 3, a
    jr nz, .notForcedDownwards
    ld a, [wCurMap]
    cp ROUTE_17
    jr nz, .notForcedDownwards
    ldh a, [hJoyHeld]
    and PAD_CTRL_PAD | PAD_B | PAD_A
    jr nz, .notForcedDownwards
    ld a, PAD_DOWN
    ldh [hJoyHeld], a

.notForcedDownwards
    ld a, [wFlags_D6AF]
    bit 7, a
    ret z

    ldh a, [hJoyHeld]
    ld b, a
    ld a, [wOverrideSimulatedJoypadStatesMask]
    and b
    ret nz

    ld hl, wSimulatedJoypadStatesIndex
    dec [hl]
    ld a, [hl]
    cp $FF
    jr z, .doneSimulating
    ld hl, wSimulatedJoypadStatesEnd
    add l
    ld l, a
    jr nc, .noCarry
    inc h
.noCarry
    ld a, [hl]
    ldh [hJoyHeld], a
    and a
    ret nz
    ldh [hJoyPressed], a
    ldh [hJoyReleased], a
    ret

.doneSimulating
    xor a
    ld [wWastedByteCD3A], a
    ld [wSimulatedJoypadStatesIndex], a
    ld [wSimulatedJoypadStatesEnd], a
    ld [wJoyIgnore], a
    ldh [hJoyHeld], a
    ld hl, wMovementFlags
    ld a, [hl]
    and $F8
    ld [hl], a
    ld hl, wFlags_D6AF
    res 7, [hl]
    ret

IF DEF(_REV0)
    ASSERT @ == $29C8
ELIF DEF(_REVA)
    ASSERT @ == $29B6
ENDC
