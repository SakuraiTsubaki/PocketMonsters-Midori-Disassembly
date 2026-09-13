; Render up to four visible entries in a generic list menu.

PrintListMenuEntries::
    ld hl, wTileMap + (3 * SCREEN_WIDTH) + 5
    ld b, 9
    ld c, 14
    call ClearScreenArea

    ld a, [wListPointer]
    ld e, a
    ld a, [wListPointer + 1]
    ld d, a
    inc de
    ld a, [wListScrollOffset]
    ld c, a
    ld a, [wListMenuID]
    cp ITEMLISTMENU
    ld a, c
    jr nz, .skipMultiplying
    sla a
    sla c
.skipMultiplying
    add e
    ld e, a
    jr nc, .noCarry
    inc d
.noCarry

    ld hl, wTileMap + (4 * SCREEN_WIDTH) + 6
    ld b, 4
.loop
    ld a, b
    ld [wWhichPokemon], a
    ld a, [de]
    ld [wNamedObjectIndex], a
    cp $FF
    jp z, .printCancelMenuItem

    push bc
    push de
    push hl
    push hl
    push de
    ld a, [wListMenuID]
    and a
    jr z, .pokemonPCMenu
    cp MOVESLISTMENU
    jr z, .movesMenu

    call BANK00_GET_ITEM_NAME_ADDR
    jr .placeNameString

.pokemonPCMenu
    push hl
    ld hl, wPartyCount
    ld a, [wListPointer]
    cp l
    ld hl, wPartyMonNicks
    jr z, .getPokemonName
    ld hl, wBoxMonNicks
.getPokemonName
    ld a, [wWhichPokemon]
    ld b, a
    ld a, 4
    sub b
    ld b, a
    ld a, [wListScrollOffset]
    add b
    call BANK00_GET_PARTY_MON_NAME_ADDR
    pop hl
    jr .placeNameString

.movesMenu
    call BANK00_GET_MOVE_NAME_ADDR

.placeNameString
    call PlaceString
    pop de
    pop hl

    ld a, [wPrintItemPrices]
    and a
    jr z, .skipPrintingItemPrice
    push hl
    ld a, [de]
    ld de, ITEM_PRICES_ADDR
    ld [wCurItem], a
    call BANK00_GET_ITEM_PRICE_ADDR
    pop hl
    ld bc, 6
    add hl, bc
    ld c, 3 | LEADING_ZEROES
    call BANK00_PRINT_BCD_NUMBER_ADDR
    ld [hl], "円"
.skipPrintingItemPrice

    ld a, [wListMenuID]
    and a
    jr nz, .skipPrintingPokemonLevel
    ld a, [wNamedObjectIndex]
    push af
    push hl
    ld hl, wPartyCount
    ld a, [wListPointer]
    cp l
    ld a, PLAYER_PARTY_DATA
    jr z, .next
    ld a, BOX_DATA
.next
    ld [wMonDataLocation], a
    ld hl, wWhichPokemon
    ld a, [hl]
    ld b, a
    ld a, 4
    sub b
    ld b, a
    ld a, [wListScrollOffset]
    add b
    ld [hl], a
    call BANK00_LOAD_MON_DATA_ADDR
    ld a, [wMonDataLocation]
    and a
    jr z, .skipCopyingLevel
    ld a, [wLoadedMonBoxLevel]
    ld [wLoadedMonLevel], a
.skipCopyingLevel
    pop hl
    ld bc, 6
    add hl, bc
    call BANK00_PRINT_LEVEL_ADDR
    pop af
    ld [wNamedObjectIndex], a
.skipPrintingPokemonLevel

    pop hl
    pop de
    inc de
    ld a, [wListMenuID]
    cp ITEMLISTMENU
    jr nz, .nextListEntry

    ld a, [wNamedObjectIndex]
    ld [wCurItem], a
    call BANK00_IS_KEY_ITEM_ADDR
    ld a, [wIsKeyItem]
    and a
    jr nz, .skipPrintingItemQuantity
    push hl
    ld bc, 9
    add hl, bc
    ld a, "×"
    ld [hli], a
    ld a, [wNamedObjectIndex]
    push af
    ld a, [de]
    ld [wMaxItemQuantity], a
    push de
    ld de, wTempByteValue
    ld [de], a
    ld bc, $0102
    call BANK00_PRINT_NUMBER_ADDR
    pop de
    pop af
    ld [wNamedObjectIndex], a
    pop hl
.skipPrintingItemQuantity
    inc de

.nextListEntry
    pop bc
    inc c
    push bc
    inc c
    ld a, [wMenuItemToSwap]
    and a
    jr z, .notSwapMarker
    sla a
    cp c
    jr nz, .notSwapMarker
    dec hl
    ld a, "▷"
    ld [hli], a
.notSwapMarker
    ld bc, 2 * SCREEN_WIDTH
    add hl, bc
    pop bc
    inc c
    dec b
    jp nz, .loop

    ld bc, -8
    add hl, bc
    ld a, "▼"
    ld [hl], a
    ret

.printCancelMenuItem
    ld de, ListMenuCancelText
    jp PlaceString

ListMenuCancelText::
    db "やめる@"

IF DEF(_REV0)
    ASSERT @ == $1AAB
ELIF DEF(_REVA)
    ASSERT @ == $1A99
ENDC
