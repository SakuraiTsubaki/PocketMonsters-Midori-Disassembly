; Initial home/pokemon.asm symbols verified against the uploaded Midori ROMs.

DEF wHPBarType EQU $CF7B
DEF wMoves EQU $D0B9

DEF PARTY_MON_DATA_BANK EQU $01

IF DEF(_REV0)
    DEF BANK01_LOAD_MON_DATA_ADDR EQU $75C2
ELIF DEF(_REVA)
    DEF BANK01_LOAD_MON_DATA_ADDR EQU $7562
ELSE
    FAIL "Define exactly one Midori revision: _REV0 or _REVA"
ENDC
