; Party-menu entry and initialization helpers from home/pokemon.asm.

DisplayPartyMenu::
    ldh a, [hTileAnimations]
    push af
    xor a
    ldh [hTileAnimations], a
    call BANK00_GB_PAL_WHITE_OUT_DELAY3_ADDR
    call ClearSprites
    call PartyMenuInit
    call BANK00_DRAW_PARTY_MENU_ADDR
    jp BANK00_HANDLE_PARTY_MENU_INPUT_ADDR

GoBackToPartyMenu::
    ldh a, [hTileAnimations]
    push af
    xor a
    ldh [hTileAnimations], a
    call PartyMenuInit
    call BANK00_REDRAW_PARTY_MENU_ADDR
    jp BANK00_HANDLE_PARTY_MENU_INPUT_ADDR

PartyMenuInit::
    ld a, 1
    call BANK00_BANKSWITCH_HOME_ADDR
    call BANK00_LOAD_HP_BAR_STATUS_TILES_ADDR
    ld hl, wStatusFlags5
    set BIT_NO_TEXT_DELAY, [hl]
    xor a
    ld [wMonDataLocation], a
    ld [wMenuWatchMovingOutOfBounds], a
    ld hl, wTopMenuItemY
    inc a
    ld [hli], a
    xor a
    ld [hli], a
    ld a, [wPartyAndBillsPCSavedMenuItem]
    push af
    ld [hli], a
    inc hl
    ld a, [wPartyCount]
    and a
    jr z, .storeMaxMenuItemID
    dec a
.storeMaxMenuItemID
    ld [hli], a
    ld a, [wForcePlayerToChooseMon]
    and a
    ld a, PAD_A | PAD_B
    jr z, .next
    xor a
    ld [wForcePlayerToChooseMon], a
    inc a
.next
    ld [hli], a
    pop af
    ld [hl], a
    ret

IF DEF(_REV0)
    ASSERT @ == $2E51
ELIF DEF(_REVA)
    ASSERT @ == $2E3F
ENDC
