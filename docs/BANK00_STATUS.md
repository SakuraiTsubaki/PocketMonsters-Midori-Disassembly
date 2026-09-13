# Bank 00 disassembly status

Bank 00 covers ROM offsets `0x0000-0x3FFF`.

## Baseline hashes

| Revision | Bank 00 SHA-1 | Differing bytes vs other revision |
| --- | --- | ---: |
| Rev 0 | `5c50c205d61da12784a5aa0fa9014e0318517326` | 13,109 |
| Rev A | `ea4e846d437aeda413b99a9351058c4078e138e4` | 13,109 |

## Restored ranges

| Range | Status | Notes |
| --- | --- | --- |
| `0000-0067` | semantic source | RST vectors and Game Boy interrupt vectors |
| `0068-00FF` | exact revision asset | 152-byte pre-header region preserved separately for Rev 0 and Rev A |
| `0100-014F` | semantic/header source | entry point plus cartridge header reservation; final header fields are produced by `rgbfix` |
| `0150-0152` | semantic source | startup trampoline to `Init` |
| `0153-0166` | semantic source | Joypad bank wrapper |
| `0167-0187` | semantic source | LCD disable/enable routines |
| `0188-01A2` | semantic source | shadow-OAM clear/hide routines |
| `01A3-01C3` | semantic source | far/local copy routines |
| `01C4-028B` | structured data | tileset collision ID lists |
| `028C-03D1` | semantic source | far-copy, video-transfer, title-input, tilemap clear/copy helpers |
| `03D2-0404` | semantic source | Japanese text-box border renderer |
| `0405-04C8` | semantic source | string parser, control codes, dakuten/handakuten kana handling |
| `04C9-0554` | semantic + readable Japanese data | name insertion handlers and fixed Japanese command strings |
| `0555-05F0` | semantic source | continuation, prompt, paragraph and text scrolling flow |
| `05F1-0773` | semantic source | text-command VM, handlers, sound/cry dispatch, command jump table |
| `0774-09CE` | semantic + structured graphics data | BG-map addressing, VBlank tile transfers, moving-water/flower animation, two flower tiles |
| `09CF-0AAB` | semantic source | soft reset, program initialization, VRAM clear, audio reset |
| `0AAC-0B3B` | semantic source | VBlank interrupt and frame-delay helper |
| `0B3C-0BA6` | semantic + palette data | Game Boy palette loading and eight fade palettes |
| `0BA7-0BF0` | semantic source | serial interrupt handler; byte-identical in both revisions |
| `0BF1-0D99` Rev 0 / `0BF1-0D87` Rev A | semantic source with revision layout | serial transfer engine; helper block is physically relocated between revisions |
| `0D9A-0EBC` Rev 0 / `0D88-0EAA` Rev A | semantic source | Timer, default music selection, music/sound dispatch and fade control |
| `0EBD-0FCD` Rev 0 / `0EAB-0FBB` Rev A | semantic + structured data/text | sprite-update wrapper, 16 mart inventories and shared overworld Japanese text |
| `0FCE-1376` Rev 0 / `0FBC-1364` Rev A | semantic source | Generation I sprite RLE/bitstream decompressor, differential decode and chunk XOR |
| `1377-13F0` Rev 0 / `1365-13DE` Rev A | semantic source | player sprite-state reset and audio fade-out engine |
| `13F1-15DD` Rev 0 / `13DF-15CB` Rev A | semantic + readable Japanese text | `DisplayTextID`, NPC/map text dispatch, Pokémart/Pokémon Center handlers, faint/blackout/Repel messages |
| `15DE-168F` Rev 0 / `15CC-167D` Rev A | semantic source | Start Menu display, wraparound, selection dispatch and close path |
| `1690-16F6` Rev 0 / `167E-16E4` Rev A | semantic source | set-bit counter, BCD money update and inventory add/remove wrappers |
| `16F7-1AAA` Rev 0 / `16E5-1A98` Rev A | semantic + readable data | list-menu initialization/input, quantity/price selector, exit path and visible-entry renderer |
| `1AAB-1B85` Rev 0 / `1A99-1B73` Rev A | semantic + readable Japanese data | Pokémon/item/TM/HM/move name helpers and HM move table |
| `1B86-1BCA` Rev 0 / `1B74-1BB8` Rev A | semantic source | map/tile graphics reload helpers and Fly destination handoff |

The continuous restored Home source now reaches `MapHeaderPointers`: `0x1BCB` in Rev 0 and `0x1BB9` in Rev A. From `0x0153`, this represents 6,776 bytes of continuous Rev 0 Home source and 6,758 bytes of continuous Rev A Home source.

`MapHeaderPointers` itself is 496 bytes (248 pointers) and is byte-identical between the two uploaded revisions, so it can be represented once as shared structured data.

## Verified segment SHA-1 values

- `0153-0166` Joypad: `8e5eca4fe568f7d63a300a805c92bc082cfed62e`
- `0167-0187` LCD: `51f6a040dc9bd7bbcba252daf56de1fd2eb98586`
- `0188-01A2` sprites: `cfb0771eb848456f6a860b282b510b8cff928ed0`
- `01A3-01C3` copy: `43b352dcee74c283aabafcee72f01d6cba4e8dc2`
- `01C4-028B` collision tables: `af69e30d0ddd85bf0f2be3fe6182073a5acc8099`
- `028C-03D1` copy/video helpers, Rev 0: `ac68c2254ff9032531569da38ef57ba7f4c0f1cc`
- `028C-03D1` copy/video helpers, Rev A: `5a8a4fc9b6d60818cf29a169fc7dddc2f1d06b9d`
- `03D2-0404` text-box border, both revisions: `302150cd0ca755333536ad790659b4680c89dd56`
- `0405-04C8` string parser, Rev 0: `34a4f9064b75e7a44536666c4ce01f94325fcf7c`
- `0405-04C8` string parser, Rev A: `2539dbbed7c58fd128da67807887f299a57f9a3b`
- `04C9-0554` names/fixed strings, both revisions: `643d38cd80b985ba40eff64b24dff997ec65c51e`
- `0555-05F0` text flow, Rev 0: `ef19c7b3583dde4572cd84d142b8c03a799a07d5`
- `0555-05F0` text flow, Rev A: `ecaa393c6c1fe67afa25c3211f6d431bf99e6683`
- `0774-09CE` BG/VRAM/VBlank-copy engine, both revisions: `1d0cd59c91308aa61fab1129c61bd11db2278603`
- `09CF-0AAB` init block, Rev 0: `fde1b2407c36991528438159c939a3e8fc1ee14c`
- `09CF-0AAB` init block, Rev A: `ab26c8b038ea981f93f8ca2bbad566bb0c408fc2`
- `0AAC-0B3B` VBlank/frame delay, Rev 0: `14b3ec2831c100b26ff44747c37516cb9de0167b`
- `0AAC-0B3B` VBlank/frame delay, Rev A: `da38c7fa2bf36bf07f30baa7fc114eac298db7d2`
- `0B3C-0BA6` palette/fade, Rev 0: `47c726b87c4a965e5a90cfa6800baf242be34251`
- `0B3C-0BA6` palette/fade, Rev A: `b50ead680f9e38ffe83d5904f46ff300a93f1bf8`
- `0BA7-0BF0` serial interrupt, both revisions: `225568e305f460263f40b7b06aee93e3e4b224d5`
- `0BF1-0D99` Rev 0 serial core: `abda2608dc9a1b9c9b0193d18b88b6a8ef053606`
- `0BF1-0D87` Rev A serial core: `a425133889bbf52c7cdb8bf330434f8f437511b2`

Revision-specific pre-header assets:

- Rev 0 `0068-00FF`: `e825cf552841abf607fea09748fcae672cbe2b79`
- Rev A `0068-00FF`: `ab8bed6a4b09d119f383ca1f8b5c6050c0a83ee9`

## Revision-aware layout

The two revisions are not modeled as duplicated source trees. Shared routines and data remain common, while revision-specific call destinations and the serial helper relocation are represented through conditional symbols/placement. This has already reproduced the distinct Rev 0 / Rev A address boundaries through `MapHeaderPointers`.

## Japanese text representation

Recovered Japanese strings are stored as readable UTF-8 assembly strings using the project charmap. The charmap is expanded from ROM-verified byte mappings as additional text is recovered; raw hexadecimal text dumps are not the target representation.

## Assembly validation

GitHub Actions assembles the source twice with RGBDS 1.0.3, once with `_REV0` and once with `_REVA`. Boundary `ASSERT`s validate the progressively restored layout for both revisions.

A successful CI run proves that the restored semantic source assembles and reaches the expected revision-specific boundaries. It does **not by itself** prove whole-ROM byte equality. Full byte-exact verification remains a separate milestone once the complete bank/link layout is reconstructed.

## Cross-check reference

The public Japanese Red/Green disassembly `Narishma-gb/pokegreen` is used to cross-check routine structure and symbol meaning. The checked reference commit is `953f41b34108621b2bf13c3b1e53abfc9c3e5aec`.

The uploaded Midori Rev 0 / Rev A ROMs remain the byte-level source of truth for this repository.

## Next range

Restore the shared 248-entry `MapHeaderPointers` table beginning at Rev 0 `0x1BCB` / Rev A `0x1BB9`, then continue into the map-header/map-loading code that follows it.
