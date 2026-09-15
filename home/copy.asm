; $01A3-$01C3

FarCopyData::
    ; Copy BC bytes from bank A at HL to DE while restoring the active bank.
    ld [wBuffer], a
    ldh a, [hLoadedROMBank]
    push af
    ld a, [wBuffer]
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call CopyData
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret

CopyData::
    ; Copy BC bytes from HL to DE.
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, c
    or b
    jr nz, CopyData
    ret
