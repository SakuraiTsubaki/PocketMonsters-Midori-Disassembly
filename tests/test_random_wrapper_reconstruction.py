import csv,hashlib,json,unittest
from pathlib import Path
ROOT=Path(__file__).parents[1];EXPECTED={'midori-jp-rev0':(0x3E8C,0x3620),'midori-jp-rev1':(0x3E7A,0x360E)}
class Tests(unittest.TestCase):
 def test_releases(self):
  rows={r['id']:r for r in csv.DictReader((ROOT/'research/releases.csv').read_text(encoding='utf-8').splitlines())};self.assertEqual(set(rows),set(EXPECTED))
  for release,(address,switch) in EXPECTED.items():
   m=json.loads((ROOT/f'analysis/{release}-random-wrapper.json').read_text());f=m['function'];c=json.loads((ROOT/f'analysis/{release}-random.json').read_text())['function'];self.assertEqual(m['target']['sha256'],rows[release]['sha256']);self.assertEqual((f['bank'],f['address'],f['length']),(0,address,17));self.assertEqual(f['dependencies']['Random_'],{'bank':c['bank'],'address':c['address']});self.assertEqual(f['dependencies']['Bankswitch']['address'],switch);self.assertFalse(m['raw_rom_bytes_included'])
 def test_manifest(self):
  m=json.loads((ROOT/'manifests/random-wrapper-reconstruction.json').read_text());[self.assertEqual(hashlib.sha256((ROOT/o['path']).read_bytes()).hexdigest(),o['sha256']) for o in m['outputs']]
if __name__=='__main__':unittest.main()
