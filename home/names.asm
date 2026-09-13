; Pokémon, item/TM/HM, and move name helpers.

GetMonName::
    push hl
    ldh a, [hLoadedROMBank]
    push af
    ld a, MONSTER_NAMES_BANK
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ld a, [wNamedObjectIndex]
    dec a
    ld hl, MONSTER_NAMES_ADDR
    ld e, a
    ld d, 0
    add hl, de
    add hl, de
    add hl, de
    add hl, de
    add hl, de
    ld de, wNameBuffer
    push de
    ld bc, NAME_LENGTH - 1
    call CopyData
    ld hl, wNameBuffer + NAME_LENGTH - 1
    ld [hl], "@"
    pop de
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    pop hl
    ret

GetItemName::
    push hl
    push bc
    ld a, [wNamedObjectIndex]
    cp HM01
    jr nc, .Machine

    ld [wNameListIndex], a
    ld a, ITEM_NAME
    ld [wNameListType], a
    ld a, ITEM_NAMES_BANK
    ld [wPredefBank], a
    call BANK00_GET_NAME_ADDR
    jr .Finish

.Machine
    call GetMachineName
.Finish
    ld de, wNameBuffer
    pop bc
    pop hl
    ret

GetMachineName::
    push hl
    push de
    push bc
    ld a, [wNamedObjectIndex]
    push af
    cp TM01
    jr nc, .WriteTM

    add NUM_HMS
    ld [wNamedObjectIndex], a
    ld hl, HiddenPrefix
    ld bc, 6
    jr .WriteMachinePrefix

.WriteTM
    ld hl, TechnicalPrefix
    ld bc, 5

.WriteMachinePrefix
    ld de, wNameBuffer
    call CopyData

    ld a, [wNamedObjectIndex]
    sub TM01 - 1
    ld b, "０"
.FirstDigit
    sub 10
    jr c, .SecondDigit
    inc b
    jr .FirstDigit
.SecondDigit
    add 10
    push af
    ld a, b
    ld [de], a
    inc de
    pop af
    ld b, "０"
    add b
    ld [de], a
    inc de
    ld a, "@"
    ld [de], a
    pop af
    ld [wNamedObjectIndex], a
    pop bc
    pop de
    pop hl
    ret

TechnicalPrefix::
    db "わざマシン"
HiddenPrefix::
    db "ひでんマシン"

IsItemHM::
    cp HM01
    jr c, .notHM
    cp TM01
    ret
.notHM
    and a
    ret

IsMoveHM::
    ld hl, HMMoves
    ld de, 1
    jp BANK00_IS_IN_ARRAY_ADDR

HMMoves::
    db MOVE_CUT, MOVE_FLY, MOVE_SURF, MOVE_STRENGTH, MOVE_FLASH, $FF

GetMoveName::
    push hl
    ld a, MOVE_NAME
    ld [wNameListType], a
    ld a, [wNamedObjectIndex]
    ld [wNameListIndex], a
    ld a, MOVE_NAMES_BANK
    ld [wPredefBank], a
    call BANK00_GET_NAME_ADDR
    ld de, wNameBuffer
    pop hl
    ret

IF DEF(_REV0)
    ASSERT @ == $1B86
ELIF DEF(_REVA)
    ASSERT @ == $1B74
ENDC
