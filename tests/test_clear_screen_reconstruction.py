import hashlib
import json
import pathlib
import unittest


ROOT = pathlib.Path(__file__).parents[1]


class ClearScreenReconstructionTests(unittest.TestCase):
    def test_release_matrix_and_maps(self):
        summary = json.loads((ROOT / "analysis/clear-screen-summary.json").read_text())
        manifest = json.loads((ROOT / "manifests/clear-screen-reconstruction.json").read_text())
        self.assertEqual(summary["axis"], "Disassembly")
        self.assertEqual(summary["release_count"], manifest["release_count"])
        self.assertEqual(summary["origin_reference"], summary["releases"][0]["id"])
        self.assertTrue(summary["releases"][0]["origin_reference"])
        self.assertEqual(summary["releases"][0]["language"], "Japanese")
        for release in summary["releases"]:
            evidence = json.loads((ROOT / release["evidence"]).read_text())
            self.assertEqual(evidence["target"]["sha256"], release["sha256"])
            self.assertEqual(evidence["function"]["length"], 19)
            self.assertEqual(evidence["function"]["tail_jump"]["name"], "Delay3")
            self.assertEqual(evidence["verified_behavior"]["filled_byte_count"], 360)
            self.assertFalse(evidence["raw_rom_bytes_included"])

    def test_manifest_hashes_outputs(self):
        manifest = json.loads((ROOT / "manifests/clear-screen-reconstruction.json").read_text())
        self.assertFalse(manifest["raw_rom_bytes_included"])
        for output in manifest["outputs"]:
            self.assertEqual(hashlib.sha256((ROOT / output["path"]).read_bytes()).hexdigest(),
                             output["sha256"])

    def test_source_preserves_two_pass_loop(self):
        source = (ROOT / "src/clear_screen.asm").read_text()
        for token in ("ClearScreen::", "ld bc, SCREEN_AREA", "inc b",
                      "ld hl, wTileMap", "jp Delay3"):
            self.assertIn(token, source)


if __name__ == "__main__":
    unittest.main()

