# Public source census — research restart

Date started: 2026-09-14

## Research rule

This document restarts the Pocket Monsters Midori research from public evidence. No local retail ROM is assumed to be available. Existing repository material remains useful evidence, but it is not automatically trusted merely because it is already committed.

The governing scope is **Japanese releases as the historical origin point, followed by an exhaustive survey of all publicly documented regional, language, revision, and official re-release material that can clarify the Generation I lineage**.

Midori itself is a Japanese retail title, but the international Red/Blue family is still relevant comparative evidence because localization inherited and modified data from the Japanese lineage. International material must never be back-projected into Midori without direct verification.

This is a living census, not a declaration of completeness. Search continues recursively through repositories, forks, branches, tags, commit histories, issues, pull requests, wikis, archives, manuals, technical databases, asset archives, glitch research, mirrors, and first-party material until new source families stop materially changing the evidence map.

## Evidence classes

- **A1** — byte-exact/public reconstruction or first-party official material.
- **A2** — independent technical database/documentation corroborated by A1 evidence.
- **B** — specialist secondary research useful for revisions, glitches, unused content, or historical context.
- **C** — derivative projects, old forks, hacks, translations, or uncertain material; useful for leads only.
- **Rejected/hold** — misleading, contradictory, ROM-distribution-focused, or insufficiently attributable material.

## A1 — Japanese Red/Green reconstruction anchor

- Narishma-gb/pokegreen — https://github.com/Narishma-gb/pokegreen
  - Public disassembly of Japanese Red/Green retail revisions.
  - Green V1.0 SHA-1 `82c0eef40a5e2423699d9fd8ba15dfaa8b51d196`
  - Green V1.1 SHA-1 `4b97cd44aa3f0dd290bfe7b3ac17b7bd8270897b`
  - Red V1.0 SHA-1 `0623ad12f48c259447980d68bd85ddbf8204b2cd`
  - Red V1.1 SHA-1 `ef74c79cded14204ac79e77f4964d9cb25003120`
  - Primary public reconstruction anchor for Midori revision comparison and Red/Green common-source analysis.

## A1 — official Nintendo material

- Pocket Monsters Red/Green original Nintendo page — https://www.nintendo.co.jp/n02/dmg/apajapbj/index.html
  - Contemporary first-party evidence for the 1996-02-27 launch, two-version design, communication features, and overseas incompatibility warning.
- Pocket Monsters Blue original Nintendo page — https://www.nintendo.co.jp/n02/dmg/apej/index.html
  - First-party evidence for later Blue changes and lineage comparison.
- Pocket Monsters Pikachu original Nintendo page — https://www.nintendo.co.jp/n02/dmg/apsj/index.html
  - First-party evidence for the subsequent Generation I branch.
- Nintendo 3DS Generation I feature page — https://www.nintendo.co.jp/kids/sp/160224/pokemon/index.html
  - Official re-release context; any VC behavioral/code differences must be verified separately.

## A1/A2 — international comparison anchors

These are not Midori sources. They are lineage-comparison sources and must remain labeled as such.

- pret/pokered — https://github.com/pret/pokered
  - English USA/Europe Red/Blue reconstruction.
- einstein95/pokered-de — https://github.com/einstein95/pokered-de
  - German Red/Blue reconstruction family.
- einstein95/pokered-fr — https://github.com/einstein95/pokered-fr
  - French Red/Blue reconstruction family.
- einstein95/pokered-es — https://github.com/einstein95/pokered-es
  - Spanish Red/Blue reconstruction family.
- einstein95/pokered-it — https://github.com/einstein95/pokered-it
  - **HOLD.** Repository name suggests Italian, but the currently inspected default-branch README and `roms.md5` describe German Rote/Blaue builds. Investigate commit history before using it as Italian evidence.

## A2 — technical maps / identity corroboration

- Data Crystal: Pokémon Red and Blue — https://datacrystal.tcrf.net/wiki/Pok%C3%A9mon_Red_and_Blue
- ROM map — https://datacrystal.tcrf.net/wiki/Pok%C3%A9mon_Red_and_Blue/ROM_map
- RAM map — https://datacrystal.tcrf.net/wiki/Pok%C3%A9mon_Red_and_Blue/RAM_map
- Notes / map-object formats — https://datacrystal.tcrf.net/wiki/Pok%C3%A9mon_Red_and_Blue%3ANotes
  - Address tables are version-sensitive. Japanese and international addresses are never assumed identical.
- BizHawk Game Boy game database — independent retail identity/hash corroboration.
- No-Intro metadata mirrors — identity cross-check only; ROM downloads are outside project scope.

## B — specialist research

- Bulbapedia: Pokémon Red and Green Versions — https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_Red_%28Japanese%29
  - Revision-history lead; verify technical claims against disassembly/code.
- Glitch City Wiki: natural Generation I glitches — https://glitchcity.wiki/List_of_natural_glitches_in_Generation_I
- Glitch City Laboratories archive: unused-content research — https://archives.glitchcity.info/forums/board-107/thread-6347/page-0.html
- Helix Chamber / Capsule Monsters source index — https://helixchamber.com/media/capsule-monsters/
  - Historical lead index; follow primary citations individually.

## C — derivative / historical leads

- luckytyphlosion/pokered-jp — https://github.com/luckytyphlosion/pokered-jp
- digita-LUNA/pokejp — https://github.com/digita-LUNA/pokejp
- Masaru2/pokejp — https://github.com/Masaru2/pokejp

These may expose old Japanese-vs-international differences or source archaeology, but are not retail baselines by default.

## First-pass findings

1. Midori has at least two separately reconstructed Japanese retail revisions, so Rev 0 and Rev A must remain independent verification targets.
2. Red/Green commonality can be studied through the Japanese reconstruction, but Midori-specific data must never be inferred solely from Aka.
3. International Red/Blue projects are comparison evidence only; localization changes cannot be projected backward into Midori.
4. Repository names are insufficient evidence of target identity; files, hashes, and history must be inspected.

## Mandatory next waves

- Audit all forks, branches, tags, commit histories, issues, PRs, and symbol branches for `pokegreen` and relevant comparison repositories.
- Inventory all known release/hash/header databases and revision catalogs.
- Find original Japanese manuals, package/back-cover material, guidebooks, magazine material, official archived pages, and developer interviews.
- Exhaustively inventory Pokémon/trainer/overworld sprites, tilesets, blocksets, maps, UI, fonts, title assets, and SGB material with provenance.
- Inventory music, SFX, cries, audio-engine research, and sequence data references.
- Inventory Japanese text dumps, charmaps, control codes, name-length rules, menu layout, and localization-comparison studies.
- Inventory save/SRAM, link protocol, battle-engine, field-engine, RNG, encounter, and trainer-AI research.
- Inventory unused/debug/garbage/padding data, beta remnants, known glitches, and revision-specific fixes.
- Investigate official Virtual Console modifications without treating them as original cartridge behavior.

Every source must ultimately carry URL, target build(s), region/language/revision, evidence class, coverage, conflicts, and verification status.
