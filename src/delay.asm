SECTION "DelayFrame Reconstruction", ROM0

DelayFrame::
    ld a, 1
    ldh [hVBlankOccurred], a
.halt
    halt
    ldh a, [hVBlankOccurred]
    and a
    jr nz, .halt
    ret

SECTION "DelayFrames Reconstruction", ROM0

DelayFrames::
    call DelayFrame
    dec c
    jr nz, DelayFrames
    ret
