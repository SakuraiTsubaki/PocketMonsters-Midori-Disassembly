; RAM/HRAM addresses verified from the restored Bank 00 code.

DEF wShadowOAM EQU $C300
DEF wShadowOAMSize EQU $A0
DEF wTileMap EQU $C3A0
DEF wBuffer EQU $CEE4

DEF hROMBankTemp EQU $FF8B
DEF hJoyHeld EQU $FFB4
DEF hJoy5 EQU $FFB5
DEF hLoadedROMBank EQU $FFB8
DEF hAutoBGTransferEnabled EQU $FFBA

DEF hVBlankCopyBGSource EQU $FFC1
DEF hVBlankCopyBGDest EQU $FFC3
DEF hVBlankCopyBGNumRows EQU $FFC5
DEF hVBlankCopySize EQU $FFC6
DEF hVBlankCopySource EQU $FFC7
DEF hVBlankCopyDest EQU $FFC9
DEF hVBlankCopyDoubleSize EQU $FFCB
DEF hVBlankCopyDoubleSource EQU $FFCC
DEF hVBlankCopyDoubleDest EQU $FFCE

DEF SHADOW_OAM_ENTRY_SIZE EQU 4
DEF SHADOW_OAM_COUNT EQU 40
DEF HIDDEN_SPRITE_Y EQU $A0
