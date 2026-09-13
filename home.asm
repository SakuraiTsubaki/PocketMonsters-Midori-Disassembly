INCLUDE "constants/bank00_addresses.asm"
INCLUDE "constants/hardware.asm"
INCLUDE "constants/ram.asm"
INCLUDE "constants/display.asm"
INCLUDE "constants/input.asm"
INCLUDE "constants/text_tiles.asm"
INCLUDE "constants/text_control.asm"
INCLUDE "constants/text_commands.asm"
INCLUDE "constants/audio_ids.asm"
INCLUDE "constants/link.asm"
INCLUDE "constants/charmap.asm"

INCLUDE "home/header.asm"
INCLUDE "home/start.asm"

SECTION "Home Core", ROM0[$0153]

INCLUDE "home/joypad.asm"
ASSERT @ == $0167
INCLUDE "home/lcd.asm"
ASSERT @ == $0188
INCLUDE "home/clear_sprites.asm"
ASSERT @ == $01A3
INCLUDE "home/copy.asm"
ASSERT @ == $01C4
INCLUDE "data/tilesets/collision_tile_ids.asm"
ASSERT @ == $028C
INCLUDE "home/copy2.asm"
ASSERT @ == $03D2
INCLUDE "home/text_box.asm"
ASSERT @ == $0405
INCLUDE "home/place_string.asm"
ASSERT @ == $04C9
INCLUDE "home/text_names.asm"
ASSERT @ == $0555
INCLUDE "home/text_flow.asm"
ASSERT @ == $05F1
INCLUDE "home/text_commands.asm"
ASSERT @ == $0774
