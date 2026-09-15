#!/usr/bin/env python3
"""Generate a local ROM identity and bank inventory without redistributing ROM bytes."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path

BANK_SIZE = 0x4000
HEADER_END = 0x0150


def digest(data: bytes, name: str) -> str:
    h = hashlib.new(name)
    h.update(data)
    return h.hexdigest()


def header_checksum(data: bytes) -> int:
    x = 0
    for b in data[0x0134:0x014D]:
        x = (x - b - 1) & 0xFF
    return x


def global_checksum(data: bytes) -> int:
    total = 0
    for i, b in enumerate(data):
        if i in (0x014E, 0x014F):
            continue
        total = (total + b) & 0xFFFF
    return total


def clean_title(raw: bytes) -> str:
    raw = raw.split(b"\x00", 1)[0].rstrip(b"\x00 ")
    try:
        return raw.decode("ascii")
    except UnicodeDecodeError:
        return raw.hex().upper()


def build_inventory(path: Path) -> dict:
    data = path.read_bytes()
    if len(data) < HEADER_END:
        raise ValueError(f"ROM is too small to contain a complete Game Boy header: {len(data)} bytes")

    bank_count = (len(data) + BANK_SIZE - 1) // BANK_SIZE
    banks = []
    for bank in range(bank_count):
        start = bank * BANK_SIZE
        chunk = data[start : start + BANK_SIZE]
        banks.append({
            "bank": bank,
            "bank_hex": f"0x{bank:02X}",
            "offset_start": start,
            "offset_start_hex": f"0x{start:06X}",
            "offset_end_exclusive": start + len(chunk),
            "offset_end_exclusive_hex": f"0x{start + len(chunk):06X}",
            "size": len(chunk),
            "sha1": digest(chunk, "sha1"),
            "sha256": digest(chunk, "sha256"),
        })

    stored_header = data[0x014D]
    computed_header = header_checksum(data)
    stored_global = int.from_bytes(data[0x014E:0x0150], "big")
    computed_global = global_checksum(data)

    return {
        "source": {
            "filename": path.name,
            "size": len(data),
            "size_hex": f"0x{len(data):X}",
            "multiple_of_16k_bank": len(data) % BANK_SIZE == 0,
            "bank_count_from_file_size": bank_count,
            "md5": digest(data, "md5"),
            "sha1": digest(data, "sha1"),
            "sha256": digest(data, "sha256"),
        },
        "header": {
            "entry_point_hex": data[0x0100:0x0104].hex().upper(),
            "title": clean_title(data[0x0134:0x0144]),
            "cgb_flag": data[0x0143],
            "sgb_flag": data[0x0146],
            "cartridge_type": data[0x0147],
            "rom_size_code": data[0x0148],
            "ram_size_code": data[0x0149],
            "destination_code": data[0x014A],
            "old_licensee_code": data[0x014B],
            "mask_rom_version": data[0x014C],
            "header_checksum_stored": stored_header,
            "header_checksum_computed": computed_header,
            "header_checksum_match": stored_header == computed_header,
            "global_checksum_stored": stored_global,
            "global_checksum_computed": computed_global,
            "global_checksum_match": stored_global == computed_global,
        },
        "banks": banks,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description="Generate a ROM/header/bank inventory from a local Game Boy ROM without copying ROM bytes into the repository.")
    parser.add_argument("rom", type=Path, help="Path to the local .gb ROM")
    parser.add_argument("-o", "--output", type=Path, default=None, help="Output JSON path")
    args = parser.parse_args()

    inventory = build_inventory(args.rom)
    output = args.output or Path(f"{args.rom.stem}.inventory.json")
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(inventory, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
