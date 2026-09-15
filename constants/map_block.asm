; Block-map buffer and connection-strip addresses verified from Bank 00.

DEF wOverworldMap EQU $C6E8
DEF OVERWORLD_MAP_SIZE EQU $0514

DEF wCurMapHeight EQU $D2E7
DEF wCurMapDataPtr EQU $D2E9

DEF wNorthConnectionStripSrc EQU $D2F1
DEF wNorthConnectionStripDest EQU $D2F3
DEF wNorthConnectionStripLength EQU $D2F5
DEF wNorthConnectedMapWidth EQU $D2F6

DEF wSouthConnectionStripSrc EQU $D2FC
DEF wSouthConnectionStripDest EQU $D2FE
DEF wSouthConnectionStripLength EQU $D300
DEF wSouthConnectedMapWidth EQU $D301

DEF wWestConnectionStripSrc EQU $D307
DEF wWestConnectionStripDest EQU $D309
DEF wWestConnectionStripLength EQU $D30B

DEF wEastConnectionStripSrc EQU $D312
DEF wEastConnectionStripDest EQU $D314
DEF wEastConnectionStripLength EQU $D316

DEF wMapBackgroundTile EQU $D32C

; These temporary HRAM locations are intentionally overlaid by unrelated
; routines elsewhere in Bank 00.
DEF hMapStride EQU $FF8B
DEF hMapWidth EQU $FF8C
DEF hNorthSouthConnectionStripWidth EQU $FF8B
DEF hNorthSouthConnectedMapWidth EQU $FF8C
DEF hEastWestConnectedMapWidth EQU $FF8B
