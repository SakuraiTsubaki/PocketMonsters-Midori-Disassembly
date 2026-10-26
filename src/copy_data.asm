; Generation I byte-copy routine in both catalogued Green revisions.
; JP rev0/rev1 ROM0:$01bb.

CopyData::
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, c
    or b
    jr nz, CopyData
    ret
