; Select the picture bank for the current internal species and dispatch to
; the shared compressed-sprite decoder. HL is the sprite-pointer offset in
; wMonHeader ($0b front / $0d back).

UncompressMonSprite::
    ld bc, wMonHeader
    add hl, bc
    ld a, [hli]
    ld [wSpriteInputPtr], a
    ld a, [hl]
    ld [wSpriteInputPtr + 1], a

    ld a, [wCurPartySpecies]
    ld b, a
    cp MEW_INTERNAL_ID
    ld a, PICS_BANK_MEW
    jr z, .gotBank

    ld a, b
    cp PICS_1_END
    ld a, PICS_BANK_1
    jr c, .gotBank
    ld a, b
    cp PICS_2_END
    ld a, PICS_BANK_2
    jr c, .gotBank
    ld a, b
    cp PICS_3_END
    ld a, PICS_BANK_3
    jr c, .gotBank
    ld a, b
    cp PICS_4_END
    ld a, PICS_BANK_4
    jr c, .gotBank
    ld a, PICS_BANK_5

.gotBank
    jp UncompressSpriteData

IF DEF(_REV0)
    ASSERT @ == $3034
ELIF DEF(_REVA)
    ASSERT @ == $3022
ENDC
