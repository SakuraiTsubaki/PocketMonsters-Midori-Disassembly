from __future__ import annotations
import hashlib,json,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
class EntryTargetBlockTests(unittest.TestCase):
 def setUp(self):
  self.report_path=next((ROOT/"analysis").glob("*-jp-entry-target-block.json"));self.report=json.loads(self.report_path.read_text());self.source=(ROOT/"src"/"entry_target_block.asm").read_text();self.manifest=json.loads((ROOT/"manifests"/"entry-target-block.json").read_text())
 def test_instruction_bytes_and_source(self):
  raw=b"".join(bytes.fromhex(i["bytes"]) for i in self.report["instructions"]);self.assertEqual(raw.hex(),self.report["block_bytes"]);self.assertEqual(hashlib.sha256(raw).hexdigest(),self.report["block_bytes_sha256"]);positions=[self.source.index("    "+i["source"]) for i in self.report["instructions"]];self.assertEqual(positions,sorted(positions))
 def test_manifest_hashes_and_provenance(self):
  i=self.manifest["inputs"][0];self.assertEqual((i["sha256"],i["offset"],i["length"],i["slice_sha256"]),(self.report["source_sha256"],self.report["start_address"],self.report["byte_length"],self.report["block_bytes_sha256"]));self.assertTrue(all(hashlib.sha256((ROOT/o["path"]).read_bytes()).hexdigest()==o["sha256"] for o in self.manifest["outputs"]))
if __name__=="__main__":unittest.main()

