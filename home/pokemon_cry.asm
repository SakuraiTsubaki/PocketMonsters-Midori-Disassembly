; Pokemon cry helpers from home/pokemon.asm.

PlayCry::
    call GetCryData
    call BANK00_PLAY_SOUND_ADDR
    jp BANK00_WAIT_FOR_SOUND_ADDR

GetCryData::
    dec a
    ld c, a
    ld b, 0
    ld hl, CRY_DATA_ADDR
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, CRY_DATA_BANK
    call BANK00_BANKSWITCH_HOME_ADDR
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld [wFrequencyModifier], a
    ld a, [hl]
    ld [wTempoModifier], a
    call BANK00_BANKSWITCH_BACK_ADDR

    ld a, b
    ld c, CRY_SFX_START
    rlca
    add b
    add c
    ret

IF DEF(_REV0)
    ASSERT @ == $2DF3
ELIF DEF(_REVA)
    ASSERT @ == $2DE1
ENDC
