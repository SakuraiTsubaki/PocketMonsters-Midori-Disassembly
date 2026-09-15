; Common overworld text immediately following the mart inventory data.

IF DEF(_REV0)
    ASSERT @ == $0F69
ELIF DEF(_REVA)
    ASSERT @ == $0F57
ENDC
TextScriptEndingText::
    db TX_END

TextScriptEnd::
    ld hl, TextScriptEndingText
    ret

ExclamationText::
    db TX_START, "！", TEXT_DONE

GroundRoseText::
    db TX_START, "どこかで　じめんがもりあがった！", TEXT_DONE

BoulderText::
    db TX_START, "「かいりき」　で　うごかせるかも", TEXT_SIX_DOTS, TEXT_DONE

MartSignText::
    db TX_START, "#　グッズが　いっぱい！"
    db TEXT_LINE, "フレンドリィショップ", TEXT_DONE

PokeCenterSignText::
    db TX_START, "#の　たいりょく　かいふく！"
    db TEXT_LINE, "#センター", TEXT_DONE

PickUpItemText::
    db TX_START_ASM
    ld a, $5C ; PickUpItem predef ID
    call BANK00_PREDEF_ADDR
    jp TextScriptEnd

IF DEF(_REV0)
    ASSERT @ == $0FCE
ELIF DEF(_REVA)
    ASSERT @ == $0FBC
ENDC
