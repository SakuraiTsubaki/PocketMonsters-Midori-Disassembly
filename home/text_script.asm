; Map/NPC text dispatch and common dialogue handlers.

DisplayTextID::
    ldh a, [hLoadedROMBank]
    push af

    ; farcall DisplayTextIDInit
    ld b, $01
    ld hl, BANK01_DISPLAY_TEXT_ID_INIT_ADDR
    call BANK00_FARCALL_ADDR

    ld hl, wTextPredefFlag
    bit BIT_TEXT_PREDEF, [hl]
    res BIT_TEXT_PREDEF, [hl]
    jr nz, .skipSwitchToMapBank
    ld a, [wCurMap]
    call BANK00_SWITCH_TO_MAP_ROM_BANK_ADDR
.skipSwitchToMapBank
    ld a, 30
    ld [hFrameCounter], a
    ld hl, wCurMapTextPtr
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld d, $00
    ldh a, [hTextID]
    ld [wSpriteIndex], a

    ; Synthetic text IDs dispatched without consulting the map text table.
    and a
    jp z, BANK00_DISPLAY_START_MENU_ADDR
    cp TEXT_SAFARI_GAME_OVER
    jp z, DisplaySafariGameOverText
    cp TEXT_MON_FAINTED
    jp z, DisplayPokemonFaintedText
    cp TEXT_BLACKED_OUT
    jp z, DisplayPlayerBlackedOutText
    cp TEXT_REPEL_WORE_OFF
    jp z, DisplayRepelWoreOffText

    ld a, [wNumSprites]
    ld e, a
    ldh a, [hSpriteIndex]
    cp e
    jr z, .spriteHandling
    jr nc, .skipSpriteHandling

.spriteHandling
    push hl
    push de
    push bc
    ; farcall UpdateSpriteFacingOffsetAndDelayMovement
    ld b, $04
    ld hl, BANK04_UPDATE_SPRITE_FACING_ADDR
    call BANK00_FARCALL_ADDR
    pop bc
    pop de
    ld hl, wMapSpriteData
    ldh a, [hSpriteIndex]
    dec a
    add a
    add l
    ld l, a
    jr nc, .noCarry
    inc h
.noCarry
    inc hl
    ld a, [hl]
    pop hl

.skipSpriteHandling
    dec a
    ld e, a
    sla e
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, [hl]

    cp TX_SCRIPT_MART
    jp z, DisplayPokemartDialogue
    cp TX_SCRIPT_POKECENTER_NURSE
    jp z, DisplayPokemonCenterDialogue
    cp TX_SCRIPT_PLAYERS_PC
    jp z, BANK00_TEXTSCRIPT_ITEM_STORAGE_PC_ADDR
    cp TX_SCRIPT_BILLS_PC
    jp z, BANK00_TEXTSCRIPT_BILLS_PC_ADDR
    cp TX_SCRIPT_POKECENTER_PC
    jp z, BANK00_TEXTSCRIPT_POKECENTER_PC_ADDR

    cp TX_SCRIPT_VENDING_MACHINE
    jr nz, .notVendingMachine
    ld b, $1D
    ld hl, BANK1D_VENDING_MACHINE_MENU_ADDR
    call BANK00_FARCALL_ADDR
    jr AfterDisplayingTextID
.notVendingMachine

    cp TX_SCRIPT_PRIZE_VENDOR
    jp z, BANK00_TEXTSCRIPT_PRIZE_VENDOR_ADDR

    cp TX_SCRIPT_CABLE_CLUB_RECEPTIONIST
    jr nz, .notCableClub
    ; callfar CableClubNPC
    ld hl, BANK01_CABLE_CLUB_NPC_ADDR
    ld b, $01
    call BANK00_FARCALL_ADDR
    jr AfterDisplayingTextID
.notCableClub

    call BANK00_PRINT_TEXT_NO_BOX_ADDR
    ld a, [wDoNotWaitForButtonPressAfterDisplayingText]
    and a
    jr nz, HoldTextDisplayOpen

AfterDisplayingTextID::
    ld a, [wEnteringCableClub]
    and a
    jr nz, HoldTextDisplayOpen
    call BANK00_WAIT_FOR_TEXT_SCROLL_ADDR

HoldTextDisplayOpen::
    call Joypad
    ldh a, [hJoyHeld]
    bit 0, a
    jr nz, HoldTextDisplayOpen

CloseTextDisplay::
    ld a, [wCurMap]
    call BANK00_SWITCH_TO_MAP_ROM_BANK_ADDR
    ld a, $90
    ldh [hWY], a
    call DelayFrame
    call LoadGBPal
    xor a
    ldh [hAutoBGTransferEnabled], a

    ld hl, wSprite01StateData2OrigFacingDirection
    ld c, NUM_SPRITESTATEDATA_STRUCTS - 1
    ld de, SPRITESTATEDATA1_LENGTH
.restoreSpriteFacingDirectionLoop
    ld a, [hl]
    dec h
    ld [hl], a
    inc h
    add hl, de
    dec c
    jr nz, .restoreSpriteFacingDirectionLoop

    ld a, $05
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call BANK05_INIT_MAP_SPRITES_ADDR

    ld hl, wFontLoaded
    res BIT_FONT_LOADED, [hl]
    ld a, [wStatusFlags6]
    bit BIT_FLY_WARP, a
    call z, BANK00_LOAD_PLAYER_SPRITE_GFX_ADDR
    call BANK00_LOAD_CURRENT_MAP_VIEW_ADDR

    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    jp UpdateSprites

DisplayPokemartDialogue::
    push hl
    ld hl, PokemartGreetingText
    call BANK00_PRINT_TEXT_ADDR
    pop hl
    inc hl
    call LoadItemList
    ld a, PRICEDITEMLISTMENU
    ld [wListMenuID], a

    ; homecall DisplayPokemartDialogue_
    ldh a, [hLoadedROMBank]
    push af
    ld a, $01
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call BANK01_POKEMART_DIALOGUE_ADDR
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    jp AfterDisplayingTextID

PokemartGreetingText::
    db TX_START, "ようこそ！"
    db TEXT_NEXT, "おさがしものですか？", TEXT_DONE

LoadItemList::
    ld a, 1
    ld [wUpdateSpritesEnabled], a
    ld a, h
    ld [wItemListPointer], a
    ld a, l
    ld [wItemListPointer + 1], a
    ld de, wItemList
.loop
    ld a, [hli]
    ld [de], a
    inc de
    cp $FF
    jr nz, .loop
    ret

DisplayPokemonCenterDialogue::
    xor a
    ldh [hItemPrice], a
    ldh [hItemPrice + 1], a
    ldh [hItemPrice + 2], a
    inc hl

    ; homecall DisplayPokemonCenterDialogue_
    ldh a, [hLoadedROMBank]
    push af
    ld a, $01
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call BANK01_POKECENTER_DIALOGUE_ADDR
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    jp AfterDisplayingTextID

DisplaySafariGameOverText::
    ; callfar PrintSafariGameOverText
    ld hl, BANK07_PRINT_SAFARI_GAME_OVER_TEXT_ADDR
    ld b, $07
    call BANK00_FARCALL_ADDR
    jp AfterDisplayingTextID

DisplayPokemonFaintedText::
    ld hl, PokemonFaintedText
    call BANK00_PRINT_TEXT_ADDR
    jp AfterDisplayingTextID

PokemonFaintedText::
    db TX_RAM
    dw wNameBuffer
    db TX_START, "は　ちからつきた", TEXT_DONE

DisplayPlayerBlackedOutText::
    ld hl, PlayerBlackedOutText
    call BANK00_PRINT_TEXT_ADDR
    jp HoldTextDisplayOpen

PlayerBlackedOutText::
    db TX_START, TEXT_PLAYER, "の　てもとには"
    db TEXT_LINE, "たたかえる#が　もういない！"
    db TEXT_PARAGRAPH, TEXT_PLAYER, "は"
    db TEXT_LINE, "めのまえが　まっくらに　なった！", TEXT_PROMPT

DisplayRepelWoreOffText::
    ld hl, RepelWoreOffText
    call BANK00_PRINT_TEXT_ADDR
    jp AfterDisplayingTextID

RepelWoreOffText::
    db TX_START, "スプレーの　こうかがきれた", TEXT_DONE

IF DEF(_REV0)
    ASSERT @ == $15DE
ELIF DEF(_REVA)
    ASSERT @ == $15CC
ENDC
