; Generic list-menu initialization. The interactive loop follows this block.

DisplayListMenuID::
    xor a
    ldh [hAutoBGTransferEnabled], a
    ld a, 1
    ld [hJoy7], a

    ld a, [wBattleType]
    and a
    jr nz, .specialBattleType
    ld a, $01
    jr .bankswitch
.specialBattleType
    ld a, BANK_DISPLAY_BATTLE_MENU
.bankswitch
    call BANK00_BANKSWITCH_HOME_ADDR

    ld hl, wStatusFlags5
    set BIT_NO_TEXT_DELAY, [hl]
    xor a
    ld [wMenuItemToSwap], a
    ld [wListCount], a

    ld a, [wListPointer]
    ld l, a
    ld a, [wListPointer + 1]
    ld h, a
    ld a, [hl]
    ld [wListCount], a

    ld a, LIST_MENU_BOX
    ld [wTextBoxID], a
    call BANK00_DISPLAY_TEXT_BOX_ID_ADDR
    call UpdateSprites

    ld hl, wTileMap + (2 * SCREEN_WIDTH) + 4
    ld de, $090E
    ld a, [wListMenuID]
    and a
    jr nz, .skipMovingSprites
    call UpdateSprites
.skipMovingSprites

    ld a, 1
    ld [wMenuWatchMovingOutOfBounds], a
    ld a, [wListCount]
    cp 2
    jr c, .setMenuVariables
    ld a, 2
.setMenuVariables
    ld [wMaxMenuItem], a
    ld a, 4
    ld [wTopMenuItemY], a
    ld a, 5
    ld [wTopMenuItemX], a
    ld a, PAD_A | PAD_B | PAD_SELECT
    ld [wMenuWatchedKeys], a
    ld c, 10
    call BANK00_DELAY_FRAMES_ADDR

IF DEF(_REV0)
    ASSERT @ == $1765
ELIF DEF(_REVA)
    ASSERT @ == $1753
ENDC
