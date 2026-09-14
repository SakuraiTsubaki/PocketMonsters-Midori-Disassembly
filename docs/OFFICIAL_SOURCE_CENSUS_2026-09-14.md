# Official-source census — Pocket Monsters Midori

Research restart date: **2026-09-14**

This ledger records first-party/public-publisher evidence separately from disassemblies and community technical references. The current research environment has no local retail ROM, so official material is used to establish release identity, documented behavior, peripherals, and official re-release changes before technical reconstruction claims are accepted.

## Evidence grades

- **A1** — Nintendo / The Pokémon Company first-party product page or official electronic manual.
- **A2** — other official Nintendo / Pokémon promotional or historical material.
- **B** — reproducible public disassembly/source reconstruction with release hashes.
- **C** — specialist technical reference/wiki; useful for discovery and cross-checking, but not accepted over A/B evidence when they conflict.

## Verified official sources

### Original Japanese Red / Green

**Source:** Pokémon official site, 「ポケットモンスター 赤・緑」  
https://www.pokemon.co.jp/game/other/gb-rg/

**Grade:** A1

Verified statements:

- Japanese `ポケットモンスター 赤・緑` release date: **1996-02-27**.
- Publisher: Nintendo.
- Platform: Game Boy, with the official page also listing later Game Boy-family compatibility.
- Officially documented Red/Green difference: species appearance and encounter-rate differences, including version-exclusive Pokémon.
- Link Cable is listed as a supported peripheral.

This page is the historical release anchor for Midori. Later international Red/Blue structure must not be projected backward onto Japanese Green.

### 3DS Virtual Console release family

**Sources:**

- Pokémon official VC site: https://www.pokemon.co.jp/ex/VCAMAP/
- Nintendo 3DS Red product page (same Japanese VC family documentation): https://www.nintendo.co.jp/titles/50010000038658
- Nintendo official electronic manual: https://www.nintendo.co.jp/data/software/manual/manual_CTRNRCPA.pdf

**Grade:** A1

Verified statements:

- Japanese 3DS Virtual Console distribution began **2016-02-27**.
- `赤・緑・青・ピカチュウ` were presented as one Generation I VC family.
- 3DS local wireless provides trade/battle communication in place of the original physical link setup.
- Nintendo warns that VC behavior/expression can differ from the original.
- Normal VC suspend-state and full-save-backup features are unavailable for this software family.
- The electronic manual documents a single save file and wireless Trade Center / Colosseum behavior.
- The manual states that the four versions share the same story while species and encounter rates differ.

The VC release is therefore an **official derivative revision family** and must be tracked independently from cartridge Rev 0 / Rev A.

## Research consequences

1. Japanese Green Rev 0 and Rev A remain independent cartridge targets.
2. Red/Green shared-origin data can be compared, but version-specific encounters and any true code/data differences remain separate.
3. VC patch behavior is recorded as later official modification, never silently folded into cartridge reconstruction.
4. Original Link Cable implementation and 3DS local-wireless behavior are separate communication layers.
5. Official prose is evidence for intended/supported behavior, not a substitute for implementation verification.

## Official-source search frontier

Still to locate and index where publicly accessible:

- Japanese 1996 Green cartridge manual and revision-identifiable inserts.
- Green package scans and official retail/press material for Rev 0 versus Rev A chronology.
- First-party strategy/guide material and any official errata.
- 3DS download-card special edition packaging, instruction-style sticker, and town map.
- Official Pokémon Bank / Poké Transporter documentation for Generation I VC transfer.
- First-party support material on cross-version trade/battle restrictions.

## Rule

If an official document conflicts with reconstructed code/data, preserve both claims and classify the mismatch. Do not rewrite implementation history to match promotional wording.
