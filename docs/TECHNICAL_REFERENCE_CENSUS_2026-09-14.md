# External technical-reference census — Pocket Monsters Midori

Research restart date: **2026-09-14**

This file records public technical references useful for reconstruction but lower-priority than exact per-release source reconstructions for byte-level claims.

## Hardware baseline — Pan Docs

- https://gbdev.io/pandocs/
- https://gbdev.io/pandocs/Memory_Map.html
- https://gbdev.io/pandocs/Serial_Data_Transfer_%28Link_Cable%29.html
- https://gbdev.io/pandocs/MBC1.html
- https://gbdev.io/pandocs/MBC3.html
- https://gbdev.io/pandocs/MBC5.html
- https://gbdev.io/pandocs/SGB_Unlocking.html

Use Pan Docs for Game Boy hardware semantics: address space, serial transfer, MBC behavior, and SGB requirements. Do not use generic hardware documentation to identify a specific Midori revision without exact cartridge-header/source evidence.

## Data Crystal — Red/Blue family references

- Overview: https://datacrystal.tcrf.net/wiki/Pok%C3%A9mon_Red_and_Blue
- ROM map: https://datacrystal.tcrf.net/wiki/Pok%C3%A9mon_Red_and_Blue/ROM_map
- RAM map: https://datacrystal.tcrf.net/wiki/Pok%C3%A9mon_Red_and_Blue/RAM_map
- Map/data notes: https://datacrystal.tcrf.net/wiki/Pok%C3%A9mon_Red_and_Blue%3ANotes
- Text table: https://datacrystal.tcrf.net/wiki/Pok%C3%A9mon_Red_and_Blue%3ATBL

**Classification:** C — specialist community reference.

The RAM-map page itself warns that Japanese-version differences remain incomplete. Therefore any western address, structure, text table, mapper statement, or “unused” classification is a lead only until verified against the Japanese Red/Green source family.

## Glitch City Wiki

- https://glitchcity.wiki/List_of_natural_glitches_in_Generation_I

**Classification:** C — specialist discovery index.

The page explicitly says the list is incomplete. Use it to seed a versioned glitch matrix, then verify each claimed behavior against exact source code and independent reproduction evidence.

## Bulbapedia

Use only as a comparative secondary source and bibliography lead unless a page points directly to primary/official evidence.

## Midori-specific caution

Japanese Green is not just “English Red/Blue translated backward.” Community pages often center the later western engine/layout and then append Japanese notes. For this project:

1. `Narishma-gb/pokegreen` or equivalent exact Japanese source comes first.
2. Midori Rev 0 and Rev A are compared independently.
3. Data Crystal is used for hypothesis generation and terminology cross-checks.
4. Hardware facts come from Pan Docs where appropriate.
5. Community glitch lists never override per-revision source behavior.

## Immediate follow-up queues

- Midori Rev 0 vs Rev A save/SRAM structure.
- Midori map-header, block, connection, object, and collision structures versus western documentation.
- Japanese character/control-code map versus western text table.
- Serial/link protocol audit against Pan Docs.
- Full unused/debug reachability audit.
- Glitch matrix split by Midori revision, then compared against Aka/Ao/Pikachu and localized releases.
