; Party-menu input and party selection helpers from home/pokemon.asm.

HandlePartyMenuInput::
    ld a, 1
    ld [wMenuWrappingEnabled], a
    ld a, $40
    ld [wPartyMenuAnimMonEnabled], a
    call BANK00_HANDLE_MENU_INPUT_UNDERSCORE_ADDR
    call BANK00_PLACE_UNFILLED_ARROW_CURSOR_ADDR
    ld b, a
    xor a
    ld [wPartyMenuAnimMonEnabled], a
    ld a, [wCurrentMenuItem]
    ld [wPartyAndBillsPCSavedMenuItem], a
    ld hl, wStatusFlags5
    res BIT_NO_TEXT_DELAY, [hl]
    ld a, [wMenuItemToSwap]
    and a
    jp nz, .swappingPokemon

    pop af
    ldh [hTileAnimations], a
    bit B_PAD_B, b
    jr nz, .noPokemonChosen
    ld a, [wPartyCount]
    and a
    jr z, .noPokemonChosen
    ld a, [wCurrentMenuItem]
    ld [wWhichPokemon], a
    ld hl, wPartySpecies
    ld b, 0
    ld c, a
    add hl, bc
    ld a, [hl]
    ld [wCurPartySpecies], a
    ld [wBattleMonSpecies2], a
    call BANK00_BANKSWITCH_BACK_ADDR
    and a
    ret

.noPokemonChosen
    call BANK00_BANKSWITCH_BACK_ADDR
    scf
    ret

.swappingPokemon
    bit B_PAD_B, b
    jr z, .handleSwap
    ld b, $04
    ld hl, BANK04_ERASE_PARTY_MENU_CURSORS_ADDR
    call BANK00_FARCALL_ADDR
    xor a
    ld [wMenuItemToSwap], a
    ld [wPartyMenuTypeOrMessageID], a
    call BANK00_REDRAW_PARTY_MENU_ADDR
    jr HandlePartyMenuInput

.handleSwap
    ld a, [wCurrentMenuItem]
    ld [wWhichPokemon], a
    ld b, $04
    ld hl, BANK04_SWITCH_PARTY_MON_ADDR
    call BANK00_FARCALL_ADDR
    jr HandlePartyMenuInput

IF DEF(_REV0)
    ASSERT @ == $2ECB
ELIF DEF(_REVA)
    ASSERT @ == $2EB9
ENDC
