; $0B3C-$0BA6
; Game Boy palette loading and fade sequences.

ASSERT @ == $0B3C
LoadGBPal::
    ld a, [wMapPalOffset]
    ld b, a
    ld hl, FadePal4
    ld a, l
    sub b
    ld l, a
    jr nc, .ok
    dec h
.ok
    ld a, [hli]
    ldh [rBGP], a
    ld a, [hli]
    ldh [rOBP0], a
    ld a, [hli]
    ldh [rOBP1], a
    ret

ASSERT @ == $0B53
GBFadeInFromBlack::
    ld hl, FadePal1
    ld b, 4
    jr GBFadeIncCommon

GBFadeOutToWhite::
    ld hl, FadePal6
    ld b, 3

GBFadeIncCommon::
    ld a, [hli]
    ldh [rBGP], a
    ld a, [hli]
    ldh [rOBP0], a
    ld a, [hli]
    ldh [rOBP1], a
    ld c, 8
    call BANK00_DELAY_FRAMES_ADDR
    dec b
    jr nz, GBFadeIncCommon
    ret

ASSERT @ == $0B71
GBFadeOutToBlack::
    ld hl, FadePal4 + 2
    ld b, 4
    jr GBFadeDecCommon

GBFadeInFromWhite::
    ld hl, FadePal7 + 2
    ld b, 3

GBFadeDecCommon::
    ld a, [hld]
    ldh [rOBP1], a
    ld a, [hld]
    ldh [rOBP0], a
    ld a, [hld]
    ldh [rBGP], a
    ld c, 8
    call BANK00_DELAY_FRAMES_ADDR
    dec b
    jr nz, GBFadeDecCommon
    ret

ASSERT @ == $0B8F
FadePal1:: db $FF, $FF, $FF
FadePal2:: db $FE, $FE, $F8
FadePal3:: db $F9, $E4, $E4
FadePal4:: db $E4, $D0, $E0
FadePal5:: db $E4, $D0, $E0
FadePal6:: db $90, $80, $90
FadePal7:: db $40, $40, $40
FadePal8:: db $00, $00, $00

ASSERT @ == $0BA7
