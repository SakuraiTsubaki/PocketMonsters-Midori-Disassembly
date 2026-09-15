; Party Pokemon nickname copy helpers from home/pokemon.asm.

GetPartyMonName2::
    ld a, [wWhichPokemon]
    ld hl, wPartyMonNicks

GetPartyMonName::
    push hl
    push bc
    call BANK00_SKIP_FIXED_LENGTH_TEXT_ENTRIES_ADDR
    ld de, wNameBuffer
    push de
    ld bc, NAME_LENGTH
    call CopyData
    pop de
    pop bc
    pop hl
    ret

IF DEF(_REV0)
    ASSERT @ == $2FC4
ELIF DEF(_REVA)
    ASSERT @ == $2FB2
ENDC
