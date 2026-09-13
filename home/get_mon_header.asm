; Copy a species' base data into wMonHeader, including Gen I special IDs.

GetMonHeader::
    ldh a, [hLoadedROMBank]
    push af
    ld a, BASE_STATS_BANK
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    push bc
    push de
    push hl
    ld a, [wPokedexNum]
    push af
    ld a, [wCurSpecies]
    ld [wPokedexNum], a

    ld de, FOSSIL_KABUTOPS_PIC_ADDR
    ld b, $66
    cp FOSSIL_KABUTOPS_INTERNAL_ID
    jr z, .specialID
    ld de, GHOST_PIC_ADDR
    cp MON_GHOST_INTERNAL_ID
    jr z, .specialID
    ld de, FOSSIL_AERODACTYL_PIC_ADDR
    ld b, $77
    cp FOSSIL_AERODACTYL_INTERNAL_ID
    jr z, .specialID
    cp MEW_INTERNAL_ID
    jr z, .mew

    ld a, PREDEF_INDEX_TO_POKEDEX
    call BANK00_PREDEF_ADDR
    ld a, [wPokedexNum]
    dec a
    ld bc, BASE_DATA_SIZE
    ld hl, BASE_STATS_ADDR
    call BANK00_ADD_N_TIMES_ADDR
    ld de, wMonHeader
    ld bc, BASE_DATA_SIZE
    call CopyData
    jr .done

.specialID
    ld hl, wMonHSpriteDim
    ld [hl], b
    inc hl
    ld [hl], e
    inc hl
    ld [hl], d
    jr .done

.mew
    ld hl, MEW_BASE_STATS_ADDR
    ld de, wMonHeader
    ld bc, BASE_DATA_SIZE
    ld a, MEW_BASE_STATS_BANK
    call FarCopyData

.done
    ld a, [wCurSpecies]
    ld [wMonHIndex], a
    pop af
    ld [wPokedexNum], a
    pop hl
    pop de
    pop bc
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

IF DEF(_REV0)
    ASSERT @ == $2FAB
ELIF DEF(_REVA)
    ASSERT @ == $2F99
ENDC
