; List-menu RAM symbols and verified targets used by restored Bank 00 code.

DEF wBattleType EQU $D037
DEF wListPointer EQU $CF72
DEF wListCount EQU $D0EF
DEF wMenuItemToSwap EQU $CC35
DEF wMenuWatchMovingOutOfBounds EQU $CC37
DEF wMaxMenuItem EQU $CC28
DEF wTopMenuItemY EQU $CC24
DEF wTopMenuItemX EQU $CC25
DEF wMenuWatchedKeys EQU $CC29
DEF wStatusFlags5 EQU $D6AF
DEF hJoy7 EQU $FFB7

DEF BIT_NO_TEXT_DELAY EQU 6
DEF LIST_MENU_BOX EQU $0D
DEF BANK_DISPLAY_BATTLE_MENU EQU $0F

IF DEF(_REV0)
    DEF BANK00_BANKSWITCH_HOME_ADDR EQU $3606
ELIF DEF(_REVA)
    DEF BANK00_BANKSWITCH_HOME_ADDR EQU $35F4
ELSE
    FAIL "Define exactly one Midori revision: _REV0 or _REVA"
ENDC
