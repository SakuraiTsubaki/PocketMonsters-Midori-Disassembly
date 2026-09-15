; $0153-$0166
; Poll input through the bank-3 joypad reader while preserving the active bank.

Joypad::
    ldh a, [hLoadedROMBank]
    push af
    ld a, $03
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call $4000
    pop af
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    ret
