; Home-bank Random wrapper reconstructed across both Green revisions.
Random::
    push hl
    push de
    push bc
    farcall Random_
    ldh a, [hRandomAdd]
    pop bc
    pop de
    pop hl
    ret
