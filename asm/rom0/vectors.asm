; Pocket Monsters Midori ROM0 interrupt/reset vectors.
; Addresses are observed directly in both verified Japanese revisions unless noted.

SECTION "RST $00", ROM0[$0000]
RST00::
    rst $38
    ds 7, $00

SECTION "RST $08", ROM0[$0008]
RST08::
    rst $38
    ds 7, $00

SECTION "RST $10", ROM0[$0010]
RST10::
    rst $38
    ds 7, $00

SECTION "RST $18", ROM0[$0018]
RST18::
    rst $38
    ds 7, $00

SECTION "RST $20", ROM0[$0020]
RST20::
    rst $38
    ds 7, $00

SECTION "RST $28", ROM0[$0028]
RST28::
    rst $38
    ds 7, $00

SECTION "RST $30", ROM0[$0030]
RST30::
    rst $38
    ds 7, $00

SECTION "RST $38", ROM0[$0038]
RST38::
    jp $F080
    ds 5, $00

SECTION "VBlank vector", ROM0[$0040]
VBlankVector::
    jp $0AAC
    ds 5, $00

SECTION "LCD vector", ROM0[$0048]
LCDVector::
    rst $38
    ds 7, $00

SECTION "Timer vector", ROM0[$0050]
TimerVector::
IF DEF(REV_A)
    jp $0D88
ELSE
    jp $0D9A
ENDC
    ds 5, $00

SECTION "Serial vector", ROM0[$0058]
SerialVector::
    jp $0BA7
    ds 5, $00

SECTION "Joypad vector", ROM0[$0060]
JoypadVector::
    reti
    ds 7, $00
