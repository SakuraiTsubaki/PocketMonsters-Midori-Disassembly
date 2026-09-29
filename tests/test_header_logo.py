from __future__ import annotations
import hashlib,json,struct,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
class HeaderLogoTests(unittest.TestCase):
 def test_report_and_png(self):
  r=json.loads((ROOT/"analysis"/"midori-jp-header-logo.json").read_text());png=(ROOT/"graphics"/"header"/"nintendo-logo.png").read_bytes();self.assertEqual((r["source_offset"],r["source_length"]),(0x104,48));self.assertEqual((r["width"],r["height"],r["png_width"],r["png_height"]),(48,8,384,64));self.assertEqual(struct.unpack(">II",png[16:24]),(384,64));self.assertEqual(hashlib.sha256(png).hexdigest(),r["png_sha256"])
 def test_manifest_hashes(self):
  m=json.loads((ROOT/"manifests"/"header-logo.json").read_text());self.assertTrue(all(hashlib.sha256((ROOT/o["path"]).read_bytes()).hexdigest()==o["sha256"] for o in m["outputs"]))
if __name__=="__main__":unittest.main()

