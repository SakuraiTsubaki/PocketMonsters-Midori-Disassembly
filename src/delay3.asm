SECTION "Delay3 Reconstruction", ROM0

Delay3::
    ld c, 3
    jp DelayFrames

SECTION "ProtectedDelay3 Reconstruction", ROM0

ProtectedDelay3::
    push bc
    call Delay3
    pop bc
    ret
