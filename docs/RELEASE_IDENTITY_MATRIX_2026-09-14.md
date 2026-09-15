# Release identity matrix — Pocket Monsters Midori

Verification date: **2026-09-14**

This matrix is rebuilt from public evidence only. No local retail ROM is currently available.

## Japanese Midori family

| ID | Release | SHA-1 | Public exact-source evidence | Status |
|---|---|---|---|---|
| `midori-jp-v1.0` | Pocket Monsters Green (Japan) V1.0 | `82c0eef40a5e2423699d9fd8ba15dfaa8b51d196` | `Narishma-gb/pokegreen` | verified source target |
| `midori-jp-v1.1` | Pocket Monsters Green (Japan) V1.1 / Rev A | `4b97cd44aa3f0dd290bfe7b3ac17b7bd8270897b` | `Narishma-gb/pokegreen` | verified source target |

Reference: https://github.com/Narishma-gb/pokegreen

## Localization boundary

For the original Generation I release family, this project currently has no verified retail **localized Green cartridge** corresponding to the western language releases. The western paired versions are represented by Red and Blue source families instead. Therefore Midori remains a Japanese-origin cartridge family plus later official Japanese re-release lineage unless contrary first-party/preservation evidence is found.

This statement is about the currently verified release matrix, not a blanket claim that no Green-branded product ever existed in every market/context.

## Official 3DS Virtual Console lineage

Japanese Green was re-released on Nintendo 3DS Virtual Console on **2016-02-27**, alongside Japanese Red, Blue, and Pikachu. Public source reconstruction in `Narishma-gb/pokegreen` includes VC patch-template material for Green Rev 1.

VC is tracked as an official derivative family rather than folded into the cartridge rows.

## Related comparison families

Midori must be compared directly with:

- Japanese Aka V1.0 / V1.1;
- Japanese Ao;
- Japanese Pikachu V1.0–V1.3;
- international Red/Blue language families only at the later comparison stage.

## Matrix rules

- Rev 0 and Rev A remain separate byte identities.
- Japanese Red/Green shared source does not erase version-specific encounter/data differences.
- VC patch outputs are separate from cartridge identities.
- western Red/Blue binaries are not renamed into “Green” for convenience.
- any additional Japanese manufacturing/revision variant requires an attributable public hash/source before addition.

## Next verification work

- inspect repository history for any additional retail Green hash/revision evidence;
- identify cartridge-header differences between V1.0 and V1.1;
- catalog all VC output/patch identities;
- cross-check hashes with independent preservation databases;
- map every Aka/Midori binary difference to semantic code/data categories rather than only byte offsets.
