; Generation I Pokemon picture-bank and sprite-buffer layout used by home/pics.asm.

DEF MON_FRONT_SPRITE_PTR_OFFSET EQU $0B
DEF MON_BACK_SPRITE_PTR_OFFSET EQU $0D

DEF PICS_BANK_MEW EQU $01
DEF PICS_BANK_1 EQU $09
DEF PICS_BANK_2 EQU $0A
DEF PICS_BANK_3 EQU $0B
DEF PICS_BANK_4 EQU $0C
DEF PICS_BANK_5 EQU $0D

; Exclusive internal-species boundaries for the five regular picture banks.
DEF PICS_1_END EQU $1F
DEF PICS_2_END EQU $4A
DEF PICS_3_END EQU $75
DEF PICS_4_END EQU $9A

DEF sSpriteBuffer0 EQU $A000
DEF TILE_1BPP_SIZE EQU 8
DEF PIC_SIZE EQU 7 * 7

; These HRAM temporaries intentionally overlap other unions.
DEF hSpriteInterlaceCounter EQU $FF8B
DEF hSpriteWidth EQU $FF8B
DEF hSpriteHeight EQU $FF8C
DEF hSpriteOffset EQU $FF8D
