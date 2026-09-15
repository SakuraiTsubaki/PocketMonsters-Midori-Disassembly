# Disassembly plan

The end state is a source repository that reconstructs both Japanese Pocket Monsters Midori revisions without requiring an original ROM as a build input.

## Phase 0 — baselines

- Lock Rev 0 / Rev A hashes and header metadata.
- Record per-bank revision differences.
- Exclude generated ROM binaries and local build products from version control.

## Phase 1 — exact layout and code

- Recover the 32-bank ROM layout.
- Identify code, data, pointer tables, padding, vectors and fixed-address regions.
- Reconstruct Bank 00 and Bank 01 first, then continue bank-by-bank.
- Keep addresses and section ordering stable so every semantic replacement can be byte-checked.

## Phase 2 — structured game data

- Convert Pokémon, moves, items, trainers, encounters, maps, events, text pointers and other tables into labeled assembly data.
- Model Rev 0 / Rev A differences explicitly instead of duplicating the whole project.

## Phase 3 — original assets

- Recover graphics as editable source assets plus their tile/tilemap/pointer definitions.
- Recover Japanese text into readable assembly text using the correct character encoding and control codes.
- Recover music, SFX, wave data and audio engine structures as assembly source.
- Recover map block data and map/event definitions.

## Phase 4 — byte-exact reconstruction

- Build `pocketmonsters_midori.gb` and `pocketmonsters_midori_rev_a.gb` from repository contents only.
- Verify outputs against `roms.sha1`.
- Remove remaining temporary raw/opaque regions as they are understood and converted to semantic source.

## Intended source layout

```text
constants/
macros/
hardware/
home/
engine/
data/
maps/
text/
gfx/
audio/
ram/
revisions/
tools/
docs/
```

Temporary raw regions are acceptable only as an intermediate analysis step; the target is a maintainable, editable disassembly rather than a bank-by-bank binary dump.
