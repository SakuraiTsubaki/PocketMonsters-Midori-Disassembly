import hashlib,json,unittest
from pathlib import Path
R=Path(__file__).parents[1]
class Tests(unittest.TestCase):
 def test_catalog(self):
  s=json.loads((R/'analysis/call-function-in-table-summary.json').read_text());self.assertEqual(s['release_count'],2)
  for x in s['releases']:
   f=json.loads((R/x['evidence']).read_text())['function'];self.assertEqual((f['length'],f['return_address']),(20,f['address']+16))
 def test_manifest(self):
  m=json.loads((R/'manifests/call-function-in-table-reconstruction.json').read_text());
  for x in m['outputs']:self.assertEqual(hashlib.sha256((R/x['path']).read_bytes()).hexdigest(),x['sha256'])
if __name__=='__main__':unittest.main()
