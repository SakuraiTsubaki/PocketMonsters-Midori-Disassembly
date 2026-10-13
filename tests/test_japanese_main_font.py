import hashlib
import json
import unittest
from pathlib import Path


ROOT = Path(__file__).parents[1]


class JapaneseMainFontTests(unittest.TestCase):
    def setUp(self):
        self.report = json.loads((ROOT / "analysis/midori-jp-main-font.json").read_text(encoding="utf-8"))
        self.manifest = json.loads((ROOT / "manifests/japanese-main-font.json").read_text(encoding="utf-8"))

    def test_verified_range_and_layout(self):
        self.assertEqual(self.report["source_offset"], 0x10B19)
        self.assertEqual(self.report["source_length"], 0x400)
        self.assertEqual(self.report["source_sha256"], "11bfba65ad8f3b4a93f3c9b400afb611fb4072b26e2c40c77aab67bd08c9bf15")
        self.assertEqual((self.report["tile_count"], self.report["tiles_per_row"]), (128, 16))

    def test_both_revisions_share_the_verified_font(self):
        self.assertEqual([item["id"] for item in self.manifest["releases"]], ["midori-jp-rev0", "midori-jp-rev1"])
        self.assertEqual({item["range_sha256"] for item in self.manifest["releases"]}, {self.report["source_sha256"]})

    def test_each_revision_has_one_proven_loader(self):
        expected = {
            "midori-jp-rev0": ("6576b4e0979e93d4a6fa02db893c294b7aeab3b841b1acc8658bc10b3554f33c", 0x36CA),
            "midori-jp-rev1": ("3f0dc460ca8d06be1c9ac96307c939c0ea7baa366b40c2f1f4ad63242b6c4816", 0x36B8),
        }
        for release_id, (rom_hash, loader_offset) in expected.items():
            loader = json.loads((ROOT / "analysis" / f"{release_id}-main-font-loader.json").read_text())
            self.assertEqual(loader["rom_sha256"], rom_hash)
            self.assertEqual(len(loader["candidates"]), 1)
            candidate = loader["candidates"][0]
            self.assertEqual(candidate["loader_offset"], loader_offset)
            self.assertEqual((candidate["bank"], candidate["cpu_address"]), (4, 0x4B19))
            self.assertEqual(candidate["source_offset"], self.report["source_offset"])
            self.assertEqual(candidate["source_sha256"], self.report["source_sha256"])
            self.assertTrue(candidate["raw_bytes_omitted"])
            self.assertFalse(loader["raw_rom_bytes_included"])

    def test_outputs_and_publication_boundary(self):
        self.assertFalse(self.manifest["raw_rom_bytes_included"])
        for output in self.manifest["outputs"]:
            self.assertEqual(hashlib.sha256((ROOT / output["path"]).read_bytes()).hexdigest(), output["sha256"])
        self.assertEqual(hashlib.sha256((ROOT / "graphics/font/main-font-jp.png").read_bytes()).hexdigest(), self.report["png_sha256"])


if __name__ == "__main__":
    unittest.main()
