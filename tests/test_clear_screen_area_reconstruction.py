import hashlib
import json
import pathlib
import unittest

ROOT = pathlib.Path(__file__).parents[1]

class ClearScreenAreaReconstructionTests(unittest.TestCase):
    def test_release_matrix_and_maps(self):
        summary = json.loads((ROOT / "analysis/clear-screen-area-summary.json").read_text())
        self.assertEqual(summary["axis"], "Disassembly")
        self.assertEqual(summary["origin_reference"], summary["releases"][0]["id"])
        self.assertEqual(summary["releases"][0]["language"], "Japanese")
        for release in summary["releases"]:
            evidence = json.loads((ROOT / release["evidence"]).read_text())
            behavior = evidence["verified_behavior"]
            self.assertEqual(evidence["function"]["length"], 18)
            self.assertEqual(behavior["blank_tile_value"], 0x7F)
            self.assertEqual(behavior["row_stride"], 20)
            self.assertEqual(behavior["width_input_register"], "C")
            self.assertEqual(behavior["height_input_register"], "B")
            self.assertFalse(evidence["raw_rom_bytes_included"])

    def test_manifest_hashes_outputs(self):
        manifest = json.loads((ROOT / "manifests/clear-screen-area-reconstruction.json").read_text())
        for output in manifest["outputs"]:
            self.assertEqual(hashlib.sha256((ROOT / output["path"]).read_bytes()).hexdigest(),
                             output["sha256"])

    def test_source_preserves_rectangle_fill(self):
        source = (ROOT / "src/clear_screen_area.asm").read_text()
        for token in ("ClearScreenArea::", "SCREEN_WIDTH", "push hl", "push bc",
                      "ld [hli], a", "add hl, de"):
            self.assertIn(token, source)

if __name__ == "__main__":
    unittest.main()

