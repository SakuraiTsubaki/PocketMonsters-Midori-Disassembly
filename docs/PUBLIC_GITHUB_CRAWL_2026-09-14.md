# Public GitHub crawl — 2026-09-14

Discovery ledger for the research restart. Entries are search hits to inspect, not automatically trusted sources.

## Query family: `pokegreen`

Primary upstream candidate:

- `Narishma-gb/pokegreen` — Japanese Red/Green byte-exact reconstruction anchor.

Additional repositories surfaced in the first crawl:

- `JcFerggy/pokegreen`
- `Mirepo/pokegreen`
- `MDTravisYT/pokegreen`
- `SeafarersWind/pokegreen`
- `pokegreen/pokegreen`
- `GB-Recomp/pokegreen`
- `SteppoBlazer/pokegreen-crysaudio`
- `msmrrenda/pokegreen_syms`
- `Remoraid/pokegreen_ultra`
- `funnymonke0/pokegreen`
- `Masaru2/pokegreen`
- `GoddessMaria15/pokegreen`
- `ChainSwordCS/pokegreen`
- `Rangi42/pokegreen`

Status: pending individual classification unless noted below.

## Primary repository branch census

`Narishma-gb/pokegreen` exposes:

- `master` — retail Japanese Red/Green reconstruction baseline.
- `symbols` — symbol/map cross-reference branch.
- `debug_mew` — **mock-up derivative**, explicitly headed by commit `Mock-up debug build (Green Rev.0)`; not evidence of an original debug ROM.
- `sgb_mon` — **WIP derivative**, dynamic SGB-border experiment; not retail data.

Derivative branches remain useful as research leads but cannot be mixed into original Midori data.

## Virtual Console evidence exposed by the reconstruction

The master README declares Japanese Red/Green V1.0/V1.1 targets and VC patch outputs, while `vc/` contains:

- `pokered11.patch.template`
- `pokegreen11.patch.template`
- `vc_constants.asm`

Published patch target relevant to Midori:

- `DMGAPBJ1.B91.patch` SHA-1 `d1ffec642f924ef1b8a7e05c05f1e5c5becf700d`

This creates a concrete cartridge-Rev-A -> 3DS VC comparison path and must be kept separate from original cartridge behavior.

## Direct technical-source paths in international comparison upstream

`pret/pokered` exposes executable-source anchors for later cross-version study:

- `constants/charmap.asm`
- `engine/menus/save.asm`
- `home/serial.asm`
- `engine/link/cable_club.asm`
- `home/random.asm`
- `engine/math/random.asm`
- `data/wild/probabilities.asm`

They are international evidence and must never be assumed byte-identical to Midori.

## External source families added to the queue

First-party:

- `https://www.pokemon.co.jp/game/other/gb-rg/`
- `https://www.gamefreak.co.jp/works/pokemon/page/2/`
- `https://www.nintendo.co.jp/n02/dmg/apajapbj/index.html`
- Nintendo 3DS VC product/feature pages.

Visual/map archives, secondary until data-checked:

- The Spriters Resource Red/Blue archive.
- VGMaps Game Boy/Game Boy Color atlas.

Technical/research leads:

- Bulbapedia Generation I character encoding.
- `Phasip/PokemonLinkHack` for serial/link behavior lead material.
- Helix Chamber Red/Green prototype/history coverage; primary citations must be followed separately.

## Classification policy

Each repository/source eventually receives `PRIMARY`, `CORROBORATING`, `DERIVATIVE`, `HISTORICAL`, `IRRELEVANT`, or `HOLD`. README citations, forks, branches, commit history, issues and PRs recursively become crawl targets.
