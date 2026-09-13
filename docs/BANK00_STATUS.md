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
| `0068-00FF` | exact revision asset | 152-byte non-code/pre-header region preserved separately for Rev 0 and Rev A |
| `0100-014F` | semantic/header source | entry point plus cartridge header reservation; final header fields are produced by `rgbfix` |
| `0150-0152` | semantic source | startup trampoline to Init |
| `0153-0166` | semantic source | Joypad bank wrapper |
| `0167-0187` | semantic source | LCD disable/enable routines |
| `0188-01A2` | semantic source | shadow-OAM clear/hide routines |
| `01A3-01C3` | semantic source | far/local copy routines |
| `01C4-028B` | structured data | tileset collision ID lists |
| `028C-03D1` | semantic source | far-copy, video-transfer, title-input, tilemap clear/copy helpers |

The range `0x0153-0x028B` is byte-identical in Rev 0 and Rev A. The `0x028C-0x03D1` helper block is shared source with revision-specific call targets: Rev A changes the `JoypadLowSensitivity` and `Delay3` destinations without requiring duplicated routines.

## Verified segment SHA-1 values

- `0153-0166` Joypad: `8e5eca4fe568f7d63a300a805c92bc082cfed62e`
- `0167-0187` LCD: `51f6a040dc9bd7bbcba252daf56de1fd2eb98586`
- `0188-01A2` sprites: `cfb0771eb848456f6a860b282b510b8cff928ed0`
- `01A3-01C3` copy: `43b352dcee74c283aabafcee72f01d6cba4e8dc2`
- `01C4-028B` collision tables: `af69e30d0ddd85bf0f2be3fe6182073a5acc8099`
- `028C-03D1` copy/video helpers, Rev 0: `ac68c2254ff9032531569da38ef57ba7f4c0f1cc`
- `028C-03D1` copy/video helpers, Rev A: `5a8a4fc9b6d60818cf29a169fc7dddc2f1d06b9d`

Revision-specific pre-header assets:

- Rev 0 `0068-00FF`: `e825cf552841abf607fea09748fcae672cbe2b79`
- Rev A `0068-00FF`: `ab8bed6a4b09d119f383ca1f8b5c6050c0a83ee9`

## Assembly validation

GitHub Actions assembles the current source twice with RGBDS 1.0.3, once with `_REV0` and once with `_REVA`. The first CI run completed successfully; subsequent source changes continue under the same validation target.

## Cross-check reference

A public Japanese Red/Green disassembly, `Narishma-gb/pokegreen`, independently lists the exact full-ROM SHA-1 values targeted by this project for Green V1.0 and V1.1. Its checked reference commit is `953f41b34108621b2bf13c3b1e53abfc9c3e5aec`.

The uploaded Midori ROMs remain the byte-level source of truth for this repository; the public project is used to cross-check structure and symbol meaning.

## Next range

Continue at `0x03D2` with the ROM0 text-box and Japanese text rendering engine, preserving character/control-code semantics while tracking Rev 0 / Rev A call-target differences explicitly.
