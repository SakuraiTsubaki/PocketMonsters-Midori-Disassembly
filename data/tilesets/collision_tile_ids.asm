; $01C4-$028B
; Walkable/collision tile IDs for the Generation I tilesets.

MACRO coll_tiles
IF _NARG
    db \#
ENDC
    db $FF
ENDM

Underground_Coll::
    coll_tiles $0B, $0C, $13, $15, $18

Overworld_Coll::
    coll_tiles $00, $10, $1B, $20, $21, $23, $2C, $2D, $2E, $30, $31, $33, $39, $3C, $3E, $52, $54, $58, $5B

RedsHouse1_Coll::
RedsHouse2_Coll::
    coll_tiles $01, $02, $03, $11, $12, $13, $14, $1C, $1A

Mart_Coll::
Pokecenter_Coll::
    coll_tiles $11, $1A, $1C, $3C, $5E

Dojo_Coll::
Gym_Coll::
    coll_tiles $11, $16, $19, $2B, $3C, $3D, $3F, $4A, $4C, $4D, $03

Forest_Coll::
    coll_tiles $1E, $20, $2E, $30, $34, $37, $39, $3A, $40, $51, $52, $5A, $5C, $5E, $5F

House_Coll::
    coll_tiles $01, $12, $14, $28, $32, $37, $44, $54, $5C

ForestGate_Coll::
Museum_Coll::
Gate_Coll::
    coll_tiles $01, $12, $14, $1A, $1C, $37, $38, $3B, $3C, $5E

Ship_Coll::
    coll_tiles $04, $0D, $17, $1D, $1E, $23, $34, $37, $39, $4A

ShipPort_Coll::
    coll_tiles $0A, $1A, $32, $3B

Cemetery_Coll::
    coll_tiles $01, $10, $13, $1B, $22, $42, $52

Interior_Coll::
    coll_tiles $04, $0F, $15, $1F, $3B, $45, $47, $55, $56

Cavern_Coll::
    coll_tiles $05, $15, $18, $1A, $20, $21, $22, $2A, $2D, $30

UnusedCollisionList::
    coll_tiles

Lobby_Coll::
    coll_tiles $14, $17, $1A, $1C, $20, $38, $45

Mansion_Coll::
    coll_tiles $01, $05, $11, $12, $14, $1A, $1C, $2C, $53

Lab_Coll::
    coll_tiles $0C, $26, $16, $1E, $34, $37

Club_Coll::
    coll_tiles $0F, $1A, $1F, $26, $28, $29, $2C, $2D, $2E, $2F, $41

Facility_Coll::
    coll_tiles $01, $10, $11, $13, $1B, $20, $21, $22, $30, $31, $32, $42, $43, $48, $52, $55, $58, $5E

Plateau_Coll::
    coll_tiles $1B, $23, $2C, $2D, $3B, $45
