; $0167-$0187

DisableLCD::
    xor a
    ldh [rIF], a
    ldh a, [rIE]
    ld b, a
    res IE_VBLANK_BIT, a
    ldh [rIE], a

.waitForSafeScanline
    ldh a, [rLY]
    cp LY_FIRST_POST_VBLANK_SCANLINE
    jr nz, .waitForSafeScanline

    ldh a, [rLCDC]
    and ~LCDC_ENABLE_MASK
    ldh [rLCDC], a
    ld a, b
    ldh [rIE], a
    ret

EnableLCD::
    ldh a, [rLCDC]
    set LCDC_ENABLE_BIT, a
    ldh [rLCDC], a
    ret
