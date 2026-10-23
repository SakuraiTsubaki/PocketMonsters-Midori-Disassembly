# Pokemon Green animated party icons

The Japanese release `midori-jp-rev0` is the origin reference. The complete 256-byte icon block is byte-identical in all 2 verified releases (Japanese). It contains two animation frames for Bug, Plant, Snake, and Quadruped party-menu icon types.

The source atlas preserves each stored 8-pixel-wide half. The composed atlas mirrors that half horizontally, matching the symmetric OAM form displayed by the game, and scales it by four without interpolation. Its JSON companion records named icon and frame rectangles. Per-release evidence retains ROM identities, offsets, and hashes without publishing raw ROM bytes. Ordering and names follow `pret/pokered` at `a53671100ec22e5394ff26ec028d0812a238dae2`, `engine/gfx/mon_icons.asm`.
