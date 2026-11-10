# Pocket Monsters Midori CallFunctionInTable

The Japanese release `midori-jp-rev0` is the origin reference. All 2 cataloged releases (Japanese) contain exactly one ROM0 implementation. Each embedded return address equals function start + 16, proving the local return trampoline rather than matching only a wildcard byte pattern. Release identity, address, full routine hash and candidate status are retained without ROM bytes.
