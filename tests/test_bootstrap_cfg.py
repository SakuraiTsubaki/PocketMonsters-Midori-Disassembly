from __future__ import annotations
import hashlib,json,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
class BootstrapCfgTests(unittest.TestCase):
 def setUp(self):
  self.report_path=next((ROOT/"analysis").glob("*-jp-bootstrap-cfg.json"));self.report=json.loads(self.report_path.read_text());self.source=(ROOT/"src"/"bootstrap_cfg.asm").read_text();self.manifest=json.loads((ROOT/"manifests"/"bootstrap-cfg.json").read_text())
 def test_blocks_internal_loop_and_source(self):
  self.assertEqual((len(self.report["blocks"]),len(self.report["edges"])),(2,3));chunks=[];cursor=self.report["blocks"][0]["start_address"]
  for block in self.report["blocks"]:
   self.assertEqual(block["start_address"],cursor);self.assertNotIn("block_bytes",block);self.assertTrue(all("bytes" not in i and "opcode" not in i for i in block["instructions"]));self.assertTrue(all(("    "+i["source"]) in self.source for i in block["instructions"]));self.assertIn(f"Block_{block['start_address']:04x}::",self.source);cursor=block["end_address"]
  self.assertTrue(any(e["target"]>self.report["blocks"][0]["start_address"] and e["target"]<self.report["blocks"][0]["end_address"] for e in self.report["edges"]));self.assertEqual(cursor-self.report["start_address"],self.manifest["inputs"][0]["length"])
 def test_manifest_hashes_and_identity(self):
  i=self.manifest["inputs"][0];self.assertEqual((i["sha256"],i["offset"]),(self.report["source_sha256"],self.report["start_address"]));self.assertTrue(all(hashlib.sha256((ROOT/o["path"]).read_bytes()).hexdigest()==o["sha256"] for o in self.manifest["outputs"]))
if __name__=="__main__":unittest.main()
