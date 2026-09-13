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
| `0150-0152` | semantic source | startup trampoline to Init |
| `0153-0166` | semantic source | Joypad bank wrapper |
| `0167-0187` | semantic source | LCD disable/enable routines |
| `0188-01A2` | semantic source | shadow-OAM clear/hide routines |
| `01A3-01C3` | semantic source | far/local copy routines |
| `01C4-028B` | structured data | tileset collision ID lists |
| `028C-03D1` | semantic source | far-copy, video-transfer, title-input, tilemap clear/copy helpers |
| `03D2-0404` | semantic source | Japanese text-box border renderer |
| `0405-04C8` | semantic source | string parser, control codes, dakuten/handakuten kana handling |
| `04C9-0554` | semantic + readable Japanese data | name insertion handlers and fixed strings (`わざマシン`, `トレーナー`, `パソコン`, `ロケットだん`, `ポケモン`, `⋯⋯`, `てきの　`) |
| `0555-05F0` | semantic source | continuation, prompt, paragraph and text scrolling flow |

The continuous restored Home source now reaches `0x05F0`. From `0x0153` through `0x05F0`, 1,182 ROM bytes are represented by structured source rather than opaque bank data. Revision-specific call destinations are modeled with conditional symbols instead of duplicating whole routines.

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
- `0153-05F0` continuous restored region, Rev 0: `a22874d1a8c40a0734b4ff697ee7a32f2ca91103`
- `0153-05F0` continuous restored region, Rev A: `6b91f5eb2a215869033e915094139a342751e066`

Revision-specific pre-header assets:

- Rev 0 `0068-00FF`: `e825cf552841abf607fea09748fcae672cbe2b79`
- Rev A `0068-00FF`: `ab8bed6a4b09d119f383ca1f8b5c6050c0a83ee9`

## Japanese text representation

The recovered Japanese strings are stored as readable UTF-8 assembly strings using a project charmap. The charmap is expanded from ROM-verified byte mappings as additional text is recovered; raw hexadecimal string dumps are not the target representation.

## Assembly validation

GitHub Actions assembles the source twice with RGBDS 1.0.3, once with `_REV0` and once with `_REVA`. This catches syntax, section-size and relative-branch regressions while the full 32-bank linker layout is progressively restored.

## Cross-check reference

A public Japanese Red/Green disassembly, `Narishma-gb/pokegreen`, independently lists the exact full-ROM SHA-1 values targeted by this project for Green V1.0 and V1.1. Its checked reference commit is `953f41b34108621b2bf13c3b1e53abfc9c3e5aec`.

The uploaded Midori ROMs remain the byte-level source of truth for this repository; the public project is used to cross-check structure and symbol meaning.

## Next range

Continue at `0x05F1` with `TextCommandProcessor`, its command handlers and jump table, then proceed into background-map transfer routines.
