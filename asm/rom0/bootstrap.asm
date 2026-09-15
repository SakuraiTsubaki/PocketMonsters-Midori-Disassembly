; Initial ROM0 reconstruction from verified local ROM bytes.
; Symbol names are intentionally conservative until callers/behavior are mapped.

SECTION "ROM0 bootstrap", ROM0[$0150]
BootstrapStub::
    jp $09DA

CallBank3At4000::
    ldh a, [$B8]
    push af
    ld a, $03
    ldh [$B8], a
    ld [$2000], a
    call $4000
    pop af
    ldh [$B8], a
    ld [$2000], a
    ret

DisableLCDAtVBlank::
    xor a
    ldh [$0F], a
    ldh a, [$FF]
    ld b, a
    res 0, a
    ldh [$FF], a
.wait_ly_91
    ldh a, [$44]
    cp $91
    jr nz, .wait_ly_91
    ldh a, [$40]
    and $7F
    ldh [$40], a
    ld a, b
    ldh [$FF], a
    ret

EnableLCD::
    ldh a, [$40]
    set 7, a
    ldh [$40], a
    ret

ClearC300Block::
    xor a
    ld hl, $C300
    ld b, $A0
.loop
    ld [hli], a
    dec b
    jr nz, .loop
    ret

InitC300Stride4ToA0::
    ld a, $A0
    ld hl, $C300
    ld de, $0004
    ld b, $28
.loop
    ld [hl], a
    add hl, de
    dec b
    jr nz, .loop
    ret

FarCopyData::
    ld [$CEE4], a
    ldh a, [$B8]
    push af
    ld a, [$CEE4]
    ldh [$B8], a
    ld [$2000], a
    call CopyBCBytes
    pop af
    ldh [$B8], a
    ld [$2000], a
    ret

CopyBCBytes::
.loop
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, c
    or b
    jr nz, .loop
    ret
