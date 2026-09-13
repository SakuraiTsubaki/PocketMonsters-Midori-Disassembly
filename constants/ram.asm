; RAM/HRAM addresses verified from restored Bank 00 instructions.

DEF wShadowOAM EQU $C300
DEF wShadowOAMSize EQU $A0
DEF wTileMap EQU $C3A0
DEF wTextDest EQU $CC3A
DEF wRedrawRowOrColumnSrcTiles EQU $CBFC
DEF wBuffer EQU $CEE4
DEF wAudioFadeOutControl EQU $CFAE
DEF wUpdateSpritesEnabled EQU $CFB2
DEF wLastMusicSoundID EQU $CFB1
DEF wEnemyMonNick EQU $CFC1
DEF wBattleMonNick EQU $CFF0
DEF wNewSoundID EQU $C0EE
DEF wAudioROMBank EQU $C0EF
DEF wAudioSavedROMBank EQU $C0F0
DEF wMovingBGTilesCounter2 EQU $D062
DEF wDisableVBlankWYUpdate EQU $D07D
DEF wVBlankSavedROMBank EQU $D0E7
DEF wLinkState EQU $D0F0
DEF wPlayerName EQU $D11D
DEF wRivalName EQU $D2CE
DEF wLetterPrintingDelayFlags EQU $D2D7
DEF wMapPalOffset EQU $D2DC
DEF wStack EQU $DFFF

DEF hDMARoutine EQU $FF80
DEF hSoftReset EQU $FF8A
DEF hROMBankTemp EQU $FF8B
DEF hTextID EQU $FF8C
DEF hSerialReceivedNewData EQU $FFA9
DEF hSerialConnectionStatus EQU $FFAA
DEF hSerialIgnoringInitialData EQU $FFAB
DEF hSerialSendData EQU $FFAC
DEF hSerialReceiveData EQU $FFAD
DEF hSCX EQU $FFAE
DEF hSCY EQU $FFAF
DEF hWY EQU $FFB0
DEF hJoyHeld EQU $FFB4
DEF hJoy5 EQU $FFB5
DEF hLoadedROMBank EQU $FFB8
DEF hAutoBGTransferEnabled EQU $FFBA
DEF hAutoBGTransferPortion EQU $FFBB
DEF hAutoBGTransferDest EQU $FFBC
DEF hSPTemp EQU $FFBF

DEF hVBlankCopyBGSource EQU $FFC1
DEF hVBlankCopyBGDest EQU $FFC3
DEF hVBlankCopyBGNumRows EQU $FFC5
DEF hVBlankCopySize EQU $FFC6
DEF hVBlankCopySource EQU $FFC7
DEF hVBlankCopyDest EQU $FFC9
DEF hVBlankCopyDoubleSize EQU $FFCB
DEF hVBlankCopyDoubleSource EQU $FFCC
DEF hVBlankCopyDoubleDest EQU $FFCE

DEF hRedrawRowOrColumnMode EQU $FFD0
DEF hRedrawRowOrColumnDest EQU $FFD1
DEF hFrameCounter EQU $FFD5
DEF hVBlankOccurred EQU $FFD6
DEF hTileAnimations EQU $FFD7
DEF hMovingBGTilesCounter1 EQU $FFD8
DEF hWhoseTurn EQU $FFF3

DEF SHADOW_OAM_ENTRY_SIZE EQU 4
DEF SHADOW_OAM_COUNT EQU 40
DEF HIDDEN_SPRITE_Y EQU $A0
