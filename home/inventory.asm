; Money and inventory wrappers.

SubtractAmountPaidFromMoney::
    ; farjp SubtractAmountPaidFromMoney_
    ld b, $01
    ld hl, BANK01_SUBTRACT_AMOUNT_PAID_ADDR
    jp BANK00_FARCALL_ADDR

AddAmountSoldToMoney::
    ld de, wPlayerMoney + 2
    ld hl, hMoney + 2
    ld c, 3
    ld a, PREDEF_ADD_BCD
    call BANK00_PREDEF_ADDR
    ld a, MONEY_BOX
    ld [wTextBoxID], a
    call BANK00_DISPLAY_TEXT_BOX_ID_ADDR
    ld a, SFX_PURCHASE
    call BANK00_PLAY_SOUND_WAIT_CURRENT_ADDR
    jp BANK00_WAIT_FOR_SOUND_ADDR

RemoveItemFromInventory::
    ; homecall RemoveItemFromInventory_
    ldh a, [hLoadedROMBank]
    push af
    ld a, $03
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call BANK03_REMOVE_ITEM_FROM_INVENTORY_ADDR
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

AddItemToInventory::
    push bc
    ; homecall_sf AddItemToInventory_
    ldh a, [hLoadedROMBank]
    push af
    ld a, $03
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call BANK03_ADD_ITEM_TO_INVENTORY_ADDR
    pop bc
    ld a, b
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    pop bc
    ret

IF DEF(_REV0)
    ASSERT @ == $16F7
ELIF DEF(_REVA)
    ASSERT @ == $16E5
ENDC
