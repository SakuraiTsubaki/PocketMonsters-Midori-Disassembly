; Front-sprite loading helpers from home/pokemon.asm.

LoadFlippedFrontSpriteByMonIndex::
    ld a, 1
    ld [wSpriteFlipped], a

LoadFrontSpriteByMonIndex::
    push hl
    ld a, [wPokedexNum]
    push af
    ld a, [wCurPartySpecies]
    ld [wPokedexNum], a
    ld a, PREDEF_INDEX_TO_POKEDEX
    call BANK00_PREDEF_ADDR
    ld hl, wPokedexNum
    ld a, [hl]
    pop bc
    ld [hl], b
    and a
    pop hl
    jr z, .invalidDexNumber
    cp NUM_POKEMON + 1
    jr c, .validDexNumber

.invalidDexNumber
    ld a, RHYDON_INTERNAL_ID
    ld [wCurPartySpecies], a
    ret

.validDexNumber
    push hl
    ld de, vFrontPic
    call BANK00_LOAD_MON_FRONT_SPRITE_ADDR
    pop hl

    ldh a, [hLoadedROMBank]
    push af
    ld a, COPY_UNCOMPRESSED_PIC_BANK
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    xor a
    ld [hStartTileID], a
    call BANK0F_COPY_UNCOMPRESSED_PIC_ADDR
    xor a
    ld [wSpriteFlipped], a
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

IF DEF(_REV0)
    ASSERT @ == $2DC7
ELIF DEF(_REVA)
    ASSERT @ == $2DB5
ENDC
