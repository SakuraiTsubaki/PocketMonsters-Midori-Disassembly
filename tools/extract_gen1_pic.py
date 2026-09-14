#!/usr/bin/env python3
"""Decode a Generation I Pokémon compressed picture stream to PNG.

This tool operates on a local ROM supplied by the user. ROM binaries are never
stored in this repository. The decoder follows the Generation I two-plane
sprite compression format and writes a canonical four-shade grayscale PNG.

Usage:
    python tools/extract_gen1_pic.py ROM OFFSET OUTPUT.png

OFFSET accepts Python integer syntax (for example 0x33CFD).
"""

from pathlib import Path
import hashlib
import sys

from PIL import Image


def bitflip(value, count):
    result = 0
    while count:
        result = (result << 1) | (value & 1)
        value >>= 1
        count -= 1
    return result


def bitstream_bytes(data):
    for byte in data:
        for shift in range(7, -1, -1):
            yield (byte >> shift) & 1


def readint(bits, count):
    value = 0
    for _ in range(count):
        value = (value << 1) | next(bits)
    return value


def bitgroups_to_bytes(bits):
    output = bytearray()
    for index in range(0, len(bits) - 3, 4):
        output.append(
            (bits[index] << 6)
            | (bits[index + 1] << 4)
            | (bits[index + 2] << 2)
            | bits[index + 3]
        )
    return output


class Decompressor:
    length_offsets = [(2 << i) - 1 for i in range(16)]
    differential = [
        [0, 1, 3, 2, 7, 6, 4, 5, 0xF, 0xE, 0xC, 0xD, 8, 9, 0xB, 0xA],
        [0xF, 0xE, 0xC, 0xD, 8, 9, 0xB, 0xA, 0, 1, 3, 2, 7, 6, 4, 5],
    ]
    reversed_nybbles = [bitflip(i, 4) for i in range(16)]

    def __init__(self, data, mirror=False):
        self.bits = bitstream_bytes(data)
        self.width = readint(self.bits, 4) * 8
        self.height_tiles = readint(self.bits, 4)
        if self.width <= 0 or self.height_tiles <= 0 or self.width > 64 or self.height_tiles > 8:
            raise ValueError((self.width, self.height_tiles))
        self.chunk_size = self.width * self.height_tiles
        self.ram_order = next(self.bits)
        self.mirror = mirror

    def _read_bit(self):
        return next(self.bits)

    def _fill_ram(self, ram):
        mode = ["rle", "data"][self._read_bit()]
        expected = self.chunk_size * 4
        while len(ram) < expected:
            if mode == "rle":
                length_bits = 0
                while self._read_bit():
                    length_bits += 1
                if length_bits >= len(self.length_offsets):
                    raise ValueError("invalid RLE length")
                run = self.length_offsets[length_bits] + readint(self.bits, length_bits + 1)
                ram.extend([0] * run)
                mode = "data"
            else:
                while True:
                    pair = readint(self.bits, 2)
                    if pair == 0:
                        break
                    ram.append(pair)
                    if len(ram) >= expected:
                        break
                mode = "rle"
        if len(ram) != expected:
            raise ValueError(("ram-size", expected, len(ram)))

        deinterlaced = []
        for y in range(self.height_tiles):
            for x in range(self.width):
                index = 4 * y * self.width + x
                for _ in range(4):
                    deinterlaced.append(ram[index])
                    index += self.width
        ram[:] = deinterlaced

    def _differential_decode(self, ram, mirror=None):
        if mirror is None:
            mirror = self.mirror
        for x in range(self.width):
            state = 0
            for y in range(self.height_tiles):
                index = y * self.width + x
                high = (ram[index] >> 4) & 0xF
                low = ram[index] & 0xF
                high = self.differential[state][high]
                state = high & 1
                if mirror:
                    high = self.reversed_nybbles[high]
                low = self.differential[state][low]
                state = low & 1
                if mirror:
                    low = self.reversed_nybbles[low]
                ram[index] = (high << 4) | low

    def _xor_chunks(self, first, second, mirror=None):
        if mirror is None:
            mirror = self.mirror
        for index in range(len(second)):
            if mirror:
                high = self.reversed_nybbles[(second[index] >> 4) & 0xF]
                low = self.reversed_nybbles[second[index] & 0xF]
                second[index] = (high << 4) | low
            second[index] ^= first[index]

    def decompress(self):
        ram = [[], []]
        first = self.ram_order
        second = first ^ 1
        self._fill_ram(ram[first])
        unpack_mode = self._read_bit()
        if unpack_mode == 1:
            unpack_mode = 1 + self._read_bit()
        self._fill_ram(ram[second])
        ram = [bitgroups_to_bytes(chunk) for chunk in ram]

        if unpack_mode == 0:
            self._differential_decode(ram[0])
            self._differential_decode(ram[1])
        elif unpack_mode == 1:
            self._differential_decode(ram[first])
            self._xor_chunks(ram[first], ram[second])
        elif unpack_mode == 2:
            self._differential_decode(ram[second], mirror=False)
            self._differential_decode(ram[first])
            self._xor_chunks(ram[first], ram[second])
        else:
            raise ValueError(("unpack-mode", unpack_mode))

        groups = []
        for plane0, plane1 in zip(bitstream_bytes(ram[0]), bitstream_bytes(ram[1])):
            groups.append(plane0 | (plane1 << 1))
        packed = bitgroups_to_bytes(groups)

        planar = []
        pixel_height = self.height_tiles * 8
        tile_width = self.width // 8
        if not self.mirror:
            for y in range(pixel_height):
                for x in range(tile_width):
                    index = (y + pixel_height * x) * 2
                    planar.extend([packed[index], packed[index + 1]])
        else:
            for y in range(pixel_height):
                for x in reversed(range(tile_width)):
                    index = (y + pixel_height * x) * 2
                    planar.extend([packed[index + 1], packed[index]])

        bits = bitstream_bytes(planar)
        pixels = []
        try:
            while True:
                pixels.append(readint(bits, 2))
        except StopIteration:
            pass

        expected_pixels = self.width * pixel_height
        if len(pixels) != expected_pixels:
            raise ValueError(("pixel-count", len(pixels), expected_pixels))
        return self.width, pixel_height, pixels


def save_png(width, height, pixels, path):
    palette = [255, 170, 85, 0]
    image = Image.new("L", (width, height))
    image.putdata([palette[pixel] for pixel in pixels])
    image.save(path, optimize=True)


def main(argv):
    if len(argv) != 4:
        raise SystemExit("usage: extract_gen1_pic.py ROM OFFSET OUTPUT.png")
    rom = Path(argv[1]).read_bytes()
    offset = int(argv[2], 0)
    output = Path(argv[3])
    decoder = Decompressor(rom[offset:])
    width, height, pixels = decoder.decompress()
    output.parent.mkdir(parents=True, exist_ok=True)
    save_png(width, height, pixels, output)
    digest = hashlib.sha256(output.read_bytes()).hexdigest()
    print(f"{width}x{height} sha256={digest} {output}")


if __name__ == "__main__":
    main(sys.argv)
