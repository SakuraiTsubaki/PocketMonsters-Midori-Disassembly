# Artifact preservation policy

This repository preserves every lawful, storable non-ROM work product for
**Pocket Monsters Midori / Pokémon Green**.

## Only ROM binaries are excluded

Never commit original, modified, patched, rebuilt, renamed, compressed, or
archived ROM images. This includes `.gb`, `.gbc`, `.gba`, and `.rom`
files. Keep local ROMs in an ignored `roms/` directory and identify them in
research records by release metadata and hashes.

## Commit the actual non-ROM results

GitHub should contain the inspectable work itself whenever it can lawfully be
stored:

- analysis results, collected research, reports, documents, and README files;
- scripts, source code, tools, configuration files, logs, and checklists;
- manifests, comparisons, CSV, JSON, YAML, maps, symbols, and tables;
- graphics, sprites, images, palettes, fonts, icons, tiles, and converted data;
- patches, validation material, test fixtures, and reproducible non-ROM outputs.

Binary non-ROM files such as `.bin` are allowed with documented provenance and
purpose. Build, output, vendor, and analysis directories are not ignored merely
because they contain generated or collected work.

## PNG requirement for visual work

Every graphics or sprite task must commit actual reviewable PNG output together
with encoded graphics data and metadata. A hash, palette, manifest, or extraction
log alone does not satisfy this requirement. Keep the PNG near its corresponding
data and document the command that produced it.

Credentials, authentication material, editor metadata, caches, and local virtual
environments are not work products and remain ignored.
