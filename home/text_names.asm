; $04C9-$0554
; Text command handlers for names and the fixed Japanese command strings.

NullChar::
    ld b, h
    ld c, l
    pop hl
    ld de, TextIDErrorText
    dec de
    ret

TextIDErrorText::
    ; "[hTextID] エラー"
    db TEXT_COMMAND_DECIMAL
    dw hTextID
    db TEXT_DECIMAL_1BYTE_2DIGITS
    db TEXT_COMMAND_START
    db "エラー"
    db TEXT_DONE

MACRO print_name
    push de
    ld de, \1
    jr PlaceCommandCharacter
ENDM

PrintPlayerName::
    print_name wPlayerName

PrintRivalName::
    print_name wRivalName

TrainerChar::
    print_name TrainerCharText

TMChar::
    print_name TMCharText

PCChar::
    print_name PCCharText

RocketChar::
    print_name RocketCharText

PlacePOKe::
    print_name PlacePOKeText

SixDotsChar::
    print_name SixDotsCharText

PlaceMoveTargetsName::
    ldh a, [hWhoseTurn]
    xor 1
    jr PlaceMoveUsersName.place

PlaceMoveUsersName::
    ldh a, [hWhoseTurn]

.place
    push de
    and a
    jr nz, .enemy

    ld de, wBattleMonNick
    jr PlaceCommandCharacter

.enemy
    ld de, EnemyText
    call PlaceString
    ld h, b
    ld l, c
    ld de, wEnemyMonNick
    ; fall through

PlaceCommandCharacter::
    call PlaceString
    ld h, b
    ld l, c
    pop de
    inc de
    jp PlaceNextChar

TMCharText::
    db "わざマシン@"
TrainerCharText::
    db "トレーナー@"
PCCharText::
    db "パソコン@"
RocketCharText::
    db "ロケットだん@"
PlacePOKeText::
    db "ポケモン@"
SixDotsCharText::
    db "⋯⋯@"
EnemyText::
    db "てきの　@"
