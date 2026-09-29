from __future__ import annotations
import hashlib,json,re,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
class CartridgeEntryTests(unittest.TestCase):
 def test_source_reassembles_entry(self):
  r=json.loads((ROOT/"analysis"/"midori-jp-entrypoint.json").read_text());s=(ROOT/"src"/"cartridge_entry.asm").read_text();target=int(re.search(r"jp \$([0-9a-f]+)",s,re.I).group(1),16);raw=bytes((0x00,0xC3,target&0xff,target>>8));self.assertEqual((raw.hex(),target),(r["entry_bytes"],r["target_address"]));self.assertEqual(hashlib.sha256(raw).hexdigest(),r["entry_bytes_sha256"])
 def test_manifest_hashes(self):
  m=json.loads((ROOT/"manifests"/"entrypoint.json").read_text());self.assertTrue(all(hashlib.sha256((ROOT/o["path"]).read_bytes()).hexdigest()==o["sha256"] for o in m["outputs"]))
if __name__=="__main__":unittest.main()

