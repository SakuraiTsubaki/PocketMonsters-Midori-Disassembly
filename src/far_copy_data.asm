SECTION "FarCopyData Reconstruction", ROM0

FarCopyData::
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
