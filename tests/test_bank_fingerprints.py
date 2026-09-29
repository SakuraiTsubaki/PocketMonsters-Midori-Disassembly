from __future__ import annotations
import csv,hashlib,json,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
class BankFingerprintTests(unittest.TestCase):
 def test_origin_bank_map_is_complete_and_synchronized(self):
  report=json.loads((ROOT/"analysis"/"midori-jp-rev0-bank-fingerprints.json").read_text(encoding="utf-8"));rows=list(csv.DictReader((ROOT/"analysis"/"banks.csv").read_text(encoding="utf-8").splitlines()));self.assertEqual(report["sha256"],"6576b4e0979e93d4a6fa02db893c294b7aeab3b841b1acc8658bc10b3554f33c");self.assertEqual(report["bank_size"],0x4000);self.assertEqual(report["bank_count"],32);self.assertEqual(len(rows),32);self.assertEqual(len({x["sha256"] for x in report["banks"]}),32);self.assertTrue(all(x["source_sha256"]==report["sha256"] for x in rows))
 def test_manifest_hashes_outputs(self):
  manifest=json.loads((ROOT/"analysis"/"midori-jp-rev0-bank-manifest.json").read_text(encoding="utf-8"));
  for output in manifest["outputs"]:self.assertEqual(hashlib.sha256((ROOT/output["path"]).read_bytes()).hexdigest(),output["sha256"])
if __name__=="__main__":unittest.main()

