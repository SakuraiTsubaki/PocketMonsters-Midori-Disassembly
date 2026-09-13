INCLUDE "constants/bank00_addresses.asm"
INCLUDE "constants/hardware.asm"
INCLUDE "constants/ram.asm"
INCLUDE "constants/display.asm"
INCLUDE "constants/input.asm"
INCLUDE "constants/text_tiles.asm"
INCLUDE "constants/text_control.asm"
INCLUDE "constants/text_commands.asm"
INCLUDE "constants/text_scripts.asm"
INCLUDE "constants/start_menu.asm"
INCLUDE "constants/inventory.asm"
INCLUDE "constants/list_menu.asm"
INCLUDE "constants/names.asm"
INCLUDE "constants/map_reload.asm"
INCLUDE "constants/overworld.asm"
INCLUDE "constants/player_graphics.asm"
INCLUDE "constants/map_block.asm"
INCLUDE "constants/map_view.asm"
INCLUDE "constants/player_movement.asm"
INCLUDE "constants/overworld_objects.asm"
INCLUDE "constants/overworld_collision.asm"
INCLUDE "constants/audio_ids.asm"
INCLUDE "constants/item_ids.asm"
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
INCLUDE "home/vcopy.asm"
ASSERT @ == $09CF
INCLUDE "home/init.asm"
ASSERT @ == $0AAC
INCLUDE "home/vblank.asm"
ASSERT @ == $0B3C
INCLUDE "home/fade.asm"
ASSERT @ == $0BA7
INCLUDE "home/serial_interrupt.asm"
ASSERT @ == $0BF1
INCLUDE "home/serial_core.asm"
IF DEF(_REV0)
    ASSERT @ == $0D9A
ELIF DEF(_REVA)
    ASSERT @ == $0D88
ENDC
INCLUDE "home/audio.asm"
IF DEF(_REV0)
    ASSERT @ == $0EBD
ELIF DEF(_REVA)
    ASSERT @ == $0EAB
ENDC
INCLUDE "home/update_sprites.asm"
INCLUDE "data/items/marts.asm"
INCLUDE "home/overworld_text.asm"
IF DEF(_REV0)
    ASSERT @ == $0FCE
ELIF DEF(_REVA)
    ASSERT @ == $0FBC
ENDC
INCLUDE "home/uncompress.asm"
INCLUDE "home/reset_player_sprite.asm"
INCLUDE "home/fade_audio.asm"
IF DEF(_REV0)
    ASSERT @ == $13F1
ELIF DEF(_REVA)
    ASSERT @ == $13DF
ENDC
INCLUDE "home/text_script.asm"
INCLUDE "home/start_menu.asm"
INCLUDE "home/count_set_bits.asm"
INCLUDE "home/inventory.asm"
INCLUDE "home/list_menu.asm"
INCLUDE "home/list_menu_entries.asm"
INCLUDE "home/names.asm"
INCLUDE "home/reload_tiles.asm"
IF DEF(_REV0)
    ASSERT @ == $1BCB
ELIF DEF(_REVA)
    ASSERT @ == $1BB9
ENDC
INCLUDE "data/maps/map_header_pointers.asm"
IF DEF(_REV0)
    ASSERT @ == $1DBB
ELIF DEF(_REVA)
    ASSERT @ == $1DA9
ENDC
INCLUDE "home/overworld_entry.asm"
INCLUDE "home/overworld_loop.asm"
INCLUDE "home/overworld_interaction.asm"
INCLUDE "home/overworld_movement_input.asm"
INCLUDE "home/overworld_advancement.asm"
INCLUDE "home/overworld_battle_return.asm"
INCLUDE "home/overworld_warps.asm"
INCLUDE "home/map_connections.asm"
INCLUDE "home/map_change_helpers.asm"
INCLUDE "home/post_battle_warp.asm"
INCLUDE "home/player_graphics.asm"
INCLUDE "home/load_tile_block_map.asm"
INCLUDE "home/overworld_object_interaction.asm"
INCLUDE "home/overworld_collision.asm"
INCLUDE "home/load_current_map_view.asm"
INCLUDE "home/player_movement.asm"
INCLUDE "home/joypad_overworld.asm"
INCLUDE "home/collision_water.asm"
