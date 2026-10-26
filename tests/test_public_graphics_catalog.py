import hashlib
import json
import unittest
from pathlib import Path

ROOT = Path(__file__).parents[1]
COUNT = 7
PNG_COUNT = 6


class PublicGraphicsCatalogTests(unittest.TestCase):
    def test_complete_inventory(self):
        catalog = json.loads((ROOT / "analysis/public-graphics-catalog.json").read_text())
        actual = {path.relative_to(ROOT).as_posix() for path in (ROOT / "graphics").rglob("*") if path.is_file() and path.suffix.lower() in (".png", ".json")}
        listed = {item["path"] for item in catalog["assets"]}
        self.assertEqual((catalog["asset_count"], catalog["png_count"], catalog["metadata_count"]), (COUNT, PNG_COUNT, COUNT - PNG_COUNT))
        self.assertEqual(listed, actual)
        self.assertTrue(all(item["provenance"] for item in catalog["assets"]))
        self.assertTrue(all(hashlib.sha256((ROOT / item["path"]).read_bytes()).hexdigest() == item["sha256"] for item in catalog["assets"]))
        self.assertFalse(catalog["raw_rom_bytes_included"])

    def test_preview_and_manifest(self):
        catalog = json.loads((ROOT / "analysis/public-graphics-catalog.json").read_text())
        preview = (ROOT / "ASSETS.md").read_text(encoding="utf-8")
        self.assertTrue(all(item["path"] in preview for item in catalog["assets"] if item["format"] == "PNG"))
        manifest = json.loads((ROOT / "manifests/public-graphics-catalog.json").read_text())
        for output in manifest["outputs"]:
            self.assertEqual(hashlib.sha256((ROOT / output["path"]).read_bytes()).hexdigest(), output["sha256"])


if __name__ == "__main__":
    unittest.main()
