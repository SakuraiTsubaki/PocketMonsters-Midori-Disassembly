; Tileset, tile 1, tile 2. $FF terminates each list.

TilePairCollisionsLand::
    db TILESET_CAVERN, $20, $05
    db TILESET_CAVERN, $41, $05
    db TILESET_FOREST, $30, $2E
    db TILESET_CAVERN, $2A, $05
    db TILESET_CAVERN, $05, $21
    db TILESET_FOREST, $52, $2E
    db TILESET_FOREST, $55, $2E
    db TILESET_FOREST, $56, $2E
    db TILESET_FOREST, $20, $2E
    db TILESET_FOREST, $5E, $2E
    db TILESET_FOREST, $5F, $2E
    db $FF

TilePairCollisionsWater::
    db TILESET_FOREST, $14, $2E
    db TILESET_FOREST, $48, $2E
    db TILESET_CAVERN, $14, $05
    db $FF
