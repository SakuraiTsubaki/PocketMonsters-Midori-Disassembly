; Generation I hardware-divider RNG in Japanese Green rev0/rev1.
; Both releases locate it at bank $04:$7fea.

Random_::
    ldh a, [rDIV]
    ld b, a
    ldh a, [hRandomAdd]
    adc b
    ldh [hRandomAdd], a
    ldh a, [rDIV]
    ld b, a
    ldh a, [hRandomSub]
    sbc b
    ldh [hRandomSub], a
    ret
