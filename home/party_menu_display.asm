; Party-menu drawing, status display, level printing, and move access helpers.

DrawPartyMenu::
    ld hl, BANK04_DRAW_PARTY_MENU_ADDR
    jr DrawPartyMenuCommon

RedrawPartyMenu::
    ld hl, BANK04_REDRAW_PARTY_MENU_ADDR

DrawPartyMenuCommon::
    ld b, $04
    jp BANK00_FARCALL_ADDR

PrintStatusCondition::
    push de
    dec de
    dec de
    ld a, [de]
    ld b, a
    dec de
    ld a, [de]
    or b
    pop de
    jr nz, PrintStatusConditionNotFainted

    ; "ひんし"
    ld a, $CB
    ld [hli], a
    ld a, $DE
    ld [hli], a
    ld [hl], $BC
    and a
    ret

PrintStatusConditionNotFainted::
    ldh a, [hLoadedROMBank]
    push af
    ld a, BANK1E_PRINT_STATUS_AILMENT_BANK
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call BANK1E_PRINT_STATUS_AILMENT_ADDR
    pop bc
    ld a, b
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

PrintLevel::
    ld a, LV_TILE
    ld [hli], a
    ld c, 2
    ld a, [wLoadedMonLevel]
    cp 100
    jr c, PrintLevelCommon
    dec hl
    inc c
    jr PrintLevelCommon

PrintLevelFull::
    ld a, LV_TILE
    ld [hli], a
    ld c, 3
    ld a, [wLoadedMonLevel]

PrintLevelCommon::
    ld [wTempByteValue], a
    ld de, wTempByteValue
    ld b, LEFT_ALIGN | 1
    jp BANK00_PRINT_NUMBER_ADDR

GetwMoves::
    ld hl, wMoves
    ld c, a
    ld b, 0
    add hl, bc
    ld a, [hl]
    ret

IF DEF(_REV0)
    ASSERT @ == $2F2E
ELIF DEF(_REVA)
    ASSERT @ == $2F1C
ENDC
