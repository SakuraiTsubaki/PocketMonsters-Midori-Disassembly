import csv,hashlib,json,unittest
from pathlib import Path
ROOT=Path(__file__).parents[1]
ADDR={'midori-jp-rev0':(4,0x7FEA),'midori-jp-rev1':(4,0x7FEA)}
class Tests(unittest.TestCase):
 def test_releases(self):
  rows={r['id']:r for r in csv.DictReader((ROOT/'research/releases.csv').read_text(encoding='utf-8').splitlines())};self.assertEqual(set(rows),set(ADDR))
  for release,place in ADDR.items():
   m=json.loads((ROOT/f'analysis/{release}-random.json').read_text());f=m['function'];self.assertEqual(m['target']['sha256'],rows[release]['sha256']);self.assertEqual((f['bank'],f['address']),place);self.assertEqual((f['length'],f['globals'],f['code_sha256']),(17,{'hRandomAdd':0xFFD3,'hRandomSub':0xFFD4},'4f8dcfd55a40324b60e01baf3a1cfc0263398ba741ad3b73c697de486139d985'))
 def test_manifest(self):
  m=json.loads((ROOT/'manifests/random-reconstruction.json').read_text());self.assertFalse(m['raw_rom_bytes_included']);[self.assertEqual(hashlib.sha256((ROOT/o['path']).read_bytes()).hexdigest(),o['sha256']) for o in m['outputs']]
if __name__=='__main__':unittest.main()
