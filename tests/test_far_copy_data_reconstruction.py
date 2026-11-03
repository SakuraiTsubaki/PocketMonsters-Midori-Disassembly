import hashlib,json,pathlib,unittest
ROOT=pathlib.Path(__file__).parents[1]
class T(unittest.TestCase):
 def test_releases(self):
  s=json.loads((ROOT/"analysis/far-copy-data-summary.json").read_text());self.assertEqual(s["release_count"],2);self.assertEqual(s["function"],"FarCopyData")
  for r in s["releases"]:
   e=json.loads((ROOT/r["evidence"]).read_text());f=e["function"];self.assertEqual(f["length"],24);self.assertEqual(f["range_end_exclusive"],json.loads((ROOT/e["cross_reference"]["copy_data"]).read_text())["function"]["rom_offset"]);self.assertTrue(e["semantics"]["preserves_previous_rom_bank"]);self.assertFalse(e["raw_rom_bytes_included"])
 def test_manifest(self):
  m=json.loads((ROOT/"manifests/far-copy-data-reconstruction.json").read_text())
  for x in m["outputs"]:self.assertEqual(hashlib.sha256((ROOT/x["path"]).read_bytes()).hexdigest(),x["sha256"])
if __name__=="__main__":unittest.main()
