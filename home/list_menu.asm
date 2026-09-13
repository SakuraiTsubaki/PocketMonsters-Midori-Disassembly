; Generic list-menu initialization and interactive selection loop.

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
