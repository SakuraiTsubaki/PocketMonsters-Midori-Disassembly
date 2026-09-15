; Pocket Monsters Midori cartridge entry and header.
; This fragment reconstructs ROM0:$0100-$014F for both verified revisions.

SECTION "Cartridge header", ROM0[$0100]
CartridgeEntry::
    nop
    jp BootstrapStub

NintendoLogo::
    db $CE, $ED, $66, $66, $CC, $0D, $00, $0B, $03, $73, $00, $83
    db $00, $0C, $00, $0D, $00, $08, $11, $1F, $88, $89, $00, $0E
    db $DC, $CC, $6E, $E6, $DD, $DD, $D9, $99, $BB, $BB, $67, $63
    db $6E, $0E, $EC, $CC, $DD, $DC, $99, $9F, $BB, $B9, $33, $3E

CartridgeTitle::
    db "POKEMON GREEN", $00, $00, $00

NewLicenseeCode::
    db "01"

SGBFlag::
    db $03
CartridgeType::
    db $03 ; MBC1 + RAM + Battery
ROMSizeCode::
    db $04 ; 512 KiB / 32 banks
RAMSizeCode::
    db $03 ; 32 KiB external RAM
DestinationCode::
    db $00 ; Japanese
OldLicenseeCode::
    db $33

MaskROMVersion::
IF DEF(REV_A)
    db $01
ELSE
    db $00
ENDC

HeaderChecksum::
IF DEF(REV_A)
    db $9B
ELSE
    db $9C
ENDC

GlobalChecksum::
IF DEF(REV_A)
    dw $47F5 ; stored big-endian bytes F5 47
ELSE
    dw $D5DD ; stored big-endian bytes DD D5
ENDC
