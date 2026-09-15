; Generic list-menu initialization, selection loop, and quantity selector.

DisplayListMenuID::
    xor a
    ldh [hAutoBGTransferEnabled], a
    ld a, 1
    ld [hJoy7], a

    ld a, [wBattleType]
    and a
    jr nz, .specialBattleType
    ld a, $01
    jr .bankswitch
.specialBattleType
    ld a, BANK_DISPLAY_BATTLE_MENU
.bankswitch
    call BANK00_BANKSWITCH_HOME_ADDR

    ld hl, wStatusFlags5
    set BIT_NO_TEXT_DELAY, [hl]
    xor a
    ld [wMenuItemToSwap], a
    ld [wListCount], a

    ld a, [wListPointer]
    ld l, a
    ld a, [wListPointer + 1]
    ld h, a
    ld a, [hl]
    ld [wListCount], a

    ld a, LIST_MENU_BOX
    ld [wTextBoxID], a
    call BANK00_DISPLAY_TEXT_BOX_ID_ADDR
    call UpdateSprites

    ld hl, wTileMap + (2 * SCREEN_WIDTH) + 4
    ld de, $090E
    ld a, [wListMenuID]
    and a
    jr nz, .skipMovingSprites
    call UpdateSprites
.skipMovingSprites

    ld a, 1
    ld [wMenuWatchMovingOutOfBounds], a
    ld a, [wListCount]
    cp 2
    jr c, .setMenuVariables
    ld a, 2
.setMenuVariables
    ld [wMaxMenuItem], a
    ld a, 4
    ld [wTopMenuItemY], a
    ld a, 5
    ld [wTopMenuItemX], a
    ld a, PAD_A | PAD_B | PAD_SELECT
    ld [wMenuWatchedKeys], a
    ld c, 10
    call BANK00_DELAY_FRAMES_ADDR

DisplayListMenuIDLoop::
    xor a
    ldh [hAutoBGTransferEnabled], a
    call BANK00_PRINT_LIST_MENU_ENTRIES_ADDR
    ld a, 1
    ldh [hAutoBGTransferEnabled], a
    call BANK00_DELAY3_ADDR

    ld a, [wBattleType]
    and a
    jr z, .notOldManBattle

    ld a, "▶"
    ld [wTileMap + (4 * SCREEN_WIDTH) + 5], a
    ld c, 80
    call BANK00_DELAY_FRAMES_ADDR
    xor a
    ld [wCurrentMenuItem], a
    ld hl, wTileMap + (4 * SCREEN_WIDTH) + 5
    ld a, l
    ld [wMenuCursorLocation], a
    ld a, h
    ld [wMenuCursorLocation + 1], a
    jr .buttonAPressed

.notOldManBattle
    call LoadGBPal
    call BANK00_HANDLE_MENU_INPUT_ADDR
    push af
    call BANK00_PLACE_MENU_CURSOR_ADDR
    pop af
    bit 0, a
    jp z, .checkOtherKeys

.buttonAPressed
    ld a, [wCurrentMenuItem]
    call BANK00_PLACE_UNFILLED_ARROW_MENU_CURSOR_ADDR

    ld a, $01
    ld [wMenuExitMethod], a
    ld [wChosenMenuItem], a

    xor a
    ld [wMenuWatchMovingOutOfBounds], a
    ld a, [wCurrentMenuItem]
    ld c, a
    ld a, [wListScrollOffset]
    add c
    ld c, a
    ld a, [wListCount]
    and a
    jp z, BANK00_EXIT_LIST_MENU_ADDR
    dec a
    cp c
    jp c, BANK00_EXIT_LIST_MENU_ADDR

    ld a, c
    ld [wWhichPokemon], a
    ld a, [wListMenuID]
    cp ITEMLISTMENU
    jr nz, .skipMultiplying
    sla c
.skipMultiplying
    ld a, [wListPointer]
    ld l, a
    ld a, [wListPointer + 1]
    ld h, a
    inc hl
    ld b, 0
    add hl, bc
    ld a, [hl]
    ld [wCurListMenuItem], a

    ld a, [wListMenuID]
    and a
    jr z, .pokemonList

    push hl
    call BANK00_GET_ITEM_PRICE_ADDR
    pop hl
    ld a, [wListMenuID]
    cp ITEMLISTMENU
    jr nz, .skipGettingQuantity
    inc hl
    ld a, [hl]
    ld [wMaxItemQuantity], a
.skipGettingQuantity
    ld a, [wCurItem]
    ld [wNameListIndex], a
    ld a, ITEM_NAMES_BANK
    ld [wPredefBank], a
    call BANK00_GET_NAME_ADDR
    jr .storeChosenEntry

.pokemonList
    ld hl, wPartyCount
    ld a, [wListPointer]
    cp l
    ld hl, wPartyMonNicks
    jr z, .getPokemonName
    ld hl, wBoxMonNicks
.getPokemonName
    ld a, [wWhichPokemon]
    call BANK00_GET_PARTY_MON_NAME_ADDR

.storeChosenEntry
    ld de, wNameBuffer
    call BANK00_COPY_TO_STRING_BUFFER_ADDR
    ld a, CHOSE_MENU_ITEM
    ld [wMenuExitMethod], a
    ld a, [wCurrentMenuItem]
    ld [wChosenMenuItem], a
    xor a
    ld [hJoy7], a
    ld hl, wStatusFlags5
    res BIT_NO_TEXT_DELAY, [hl]
    jp BANK00_BANKSWITCH_BACK_ADDR

.checkOtherKeys
    bit 1, a
    jp nz, BANK00_EXIT_LIST_MENU_ADDR
    bit 2, a
    jp nz, BANK01_HANDLE_ITEM_LIST_SWAPPING_ADDR
    ld b, a
    bit 7, b
    ld hl, wListScrollOffset
    jr z, .upPressed

    ld a, [hl]
    add 3
    ld b, a
    ld a, [wListCount]
    cp b
    jp c, DisplayListMenuIDLoop
    inc [hl]
    jp DisplayListMenuIDLoop

.upPressed
    ld a, [hl]
    and a
    jp z, DisplayListMenuIDLoop
    dec [hl]
    jp DisplayListMenuIDLoop

IF DEF(_REV0)
    ASSERT @ == $186A
ELIF DEF(_REVA)
    ASSERT @ == $1858
ENDC

DisplayChooseQuantityMenu::
    ld hl, wTileMap + (9 * SCREEN_WIDTH) + 15
    ld b, 1
    ld c, 3
    ld a, [wListMenuID]
    cp PRICEDITEMLISTMENU
    jr nz, .drawTextBox
    ld hl, wTileMap + (9 * SCREEN_WIDTH) + 7
    ld b, 1
    ld c, 11
.drawTextBox
    call TextBoxBorder
    ld hl, wTileMap + (10 * SCREEN_WIDTH) + 16
    ld a, [wListMenuID]
    cp PRICEDITEMLISTMENU
    jr nz, .printInitialQuantity
    ld a, "円"
    ld [wTileMap + (10 * SCREEN_WIDTH) + 18], a
    ld hl, wTileMap + (10 * SCREEN_WIDTH) + 8
.printInitialQuantity
    ld de, InitialQuantityText
    call PlaceString
    xor a
    ld [wItemQuantity], a
    jp .incrementQuantity

.waitForKeyPressLoop
    call BANK00_JOYPAD_LOW_SENSITIVITY_ADDR
    ldh a, [hJoyPressed]
    bit 0, a
    jp nz, .buttonAPressed
    bit 1, a
    jp nz, .buttonBPressed
    bit 6, a
    jr nz, .incrementQuantity
    bit 7, a
    jr nz, .decrementQuantity
    jr .waitForKeyPressLoop

.incrementQuantity
    ld a, [wMaxItemQuantity]
    inc a
    ld b, a
    ld hl, wItemQuantity
    inc [hl]
    ld a, [hl]
    cp b
    jr nz, .handleNewQuantity
    ld a, 1
    ld [hl], a
    jr .handleNewQuantity

.decrementQuantity
    ld hl, wItemQuantity
    dec [hl]
    jr nz, .handleNewQuantity
    ld a, [wMaxItemQuantity]
    ld [hl], a

.handleNewQuantity
    ld hl, wTileMap + (10 * SCREEN_WIDTH) + 17
    ld a, [wListMenuID]
    cp PRICEDITEMLISTMENU
    jr nz, .printQuantity

.printPrice
    ld c, $03
    ld a, [wItemQuantity]
    ld b, a
    ld hl, hMoney
    xor a
    ld [hli], a
    ld [hli], a
    ld [hl], a

.addLoop
    ld de, hMoney + 2
    ld hl, hItemPrice + 2
    push bc
    ld a, PREDEF_ADD_BCD
    call BANK00_PREDEF_ADDR
    pop bc
    dec b
    jr nz, .addLoop

    ldh a, [hHalveItemPrices]
    and a
    jr z, .skipHalvingPrice
    xor a
    ldh [hDivideBCDDivisor], a
    ldh [hDivideBCDDivisor + 1], a
    ld a, $02
    ldh [hDivideBCDDivisor + 2], a
    ld a, PREDEF_DIVIDE_BCD_3
    call BANK00_PREDEF_ADDR
    ldh a, [hDivideBCDQuotient]
    ldh [hMoney], a
    ldh a, [hDivideBCDQuotient + 1]
    ldh [hMoney + 1], a
    ldh a, [hDivideBCDQuotient + 2]
    ldh [hMoney + 2], a

.skipHalvingPrice
    ld hl, wTileMap + (10 * SCREEN_WIDTH) + 12
    ld de, SpacesBetweenQuantityAndPriceText
    call PlaceString
    ld de, hMoney
    ld c, 3 | LEADING_ZEROES
    call BANK00_PRINT_BCD_NUMBER_ADDR
    ld hl, wTileMap + (10 * SCREEN_WIDTH) + 9

.printQuantity
    ld de, wItemQuantity
    ld bc, $8102
    call BANK00_PRINT_NUMBER_ADDR
    jp .waitForKeyPressLoop

.buttonAPressed
    xor a
    ret

.buttonBPressed
    ld a, $FF
    ret

InitialQuantityText::
    db "×０１@"

SpacesBetweenQuantityAndPriceText::
    db "　　　　　　@"

ExitListMenu::
    ld a, [wCurrentMenuItem]
    ld [wChosenMenuItem], a
    ld a, CANCELLED_MENU
    ld [wMenuExitMethod], a
    ld [wMenuWatchMovingOutOfBounds], a
    xor a
    ld [hJoy7], a
    ld hl, wStatusFlags5
    res BIT_NO_TEXT_DELAY, [hl]
    call BANK00_BANKSWITCH_BACK_ADDR
    scf
    ret

IF DEF(_REV0)
    ASSERT @ == $1968
ELIF DEF(_REVA)
    ASSERT @ == $1956
ENDC
