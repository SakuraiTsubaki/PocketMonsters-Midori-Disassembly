# Architecture

The target executes on the Sharp SM83 and uses a banked Game Boy cartridge
address space. Record file offsets separately from CPU addresses.

- `0000–3FFF`: fixed ROM window (ROM0);
- `4000–7FFF`: switchable ROM window (ROMX);
- bank-controller behavior is not assumed until the verified cartridge header
  and runtime accesses support it;
- multi-byte values are recorded with explicit encoding and byte order.

Use `bank:address` only after defining the bank convention. Every range in
`analysis/banks.csv` is half-open: start inclusive, end exclusive.
