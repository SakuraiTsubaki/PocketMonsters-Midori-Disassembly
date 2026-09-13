; Bank 00 item wrappers from home/item.asm.

DisableWaitingAfterTextDisplay::
    ld a, $01
    ld [wDoNotWaitForButtonPressAfterDisplayingText], a
    ret

UseItem::
    ld b, ITEM_ENGINE_BANK
    ld hl, BANK03_USE_ITEM_ADDR
    jp BANK00_FARCALL_ADDR

TossItem::
    ldh a, [hLoadedROMBank]
    push af
    ld a, ITEM_ENGINE_BANK
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call BANK03_TOSS_ITEM_ADDR
    pop de
    ld a, d
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

IsKeyItem::
    push hl
    push de
    push bc
    ld b, ITEM_ENGINE_BANK
    ld hl, BANK03_IS_KEY_ITEM_ADDR
    call BANK00_FARCALL_ADDR
    pop bc
    pop de
    pop hl
    ret

IF DEF(_REV0)
    ASSERT @ == $3130
ELIF DEF(_REVA)
    ASSERT @ == $311E
ENDC
