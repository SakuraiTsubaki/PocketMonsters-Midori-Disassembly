INCLUDE "constants/bank00_addresses.asm"
INCLUDE "constants/hardware.asm"
INCLUDE "constants/ram.asm"
INCLUDE "constants/display.asm"
INCLUDE "constants/input.asm"
INCLUDE "constants/text_tiles.asm"
INCLUDE "constants/text_control.asm"
INCLUDE "constants/charmap.asm"

INCLUDE "home/header.asm"
INCLUDE "home/start.asm"

SECTION "Home Core", ROM0[$0153]

INCLUDE "home/joypad.asm"
INCLUDE "home/lcd.asm"
INCLUDE "home/clear_sprites.asm"
INCLUDE "home/copy.asm"
INCLUDE "data/tilesets/collision_tile_ids.asm"
INCLUDE "home/copy2.asm"
INCLUDE "home/text_box.asm"
INCLUDE "home/place_string.asm"
INCLUDE "home/text_names.asm"
