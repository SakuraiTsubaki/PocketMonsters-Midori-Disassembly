import csv,hashlib,json,unittest
from pathlib import Path
R=Path(__file__).parents[1];E={'midori-jp-rev0','midori-jp-rev1'}
class T(unittest.TestCase):
 def test_releases(self):
  rows={x['id']:x for x in csv.DictReader((R/'research/releases.csv').read_text().splitlines())};self.assertEqual(set(rows),E)
  for k in E:
   m=json.loads((R/f'analysis/{k}-divide-wrapper.json').read_text());f=m['function'];x=json.loads((R/f'analysis/{k}-multiply-wrapper.json').read_text())['function'];self.assertEqual(m['target']['sha256'],rows[k]['sha256']);self.assertEqual((f['address'],f['length'],f['variant']),(x['range_end_exclusive'],27,'inline-absolute-hram'));self.assertEqual(f['home_call']['target']['address'],0x7ED7);self.assertEqual(f['home_call']['bank_switch']['loaded_rom_bank_address'],0xFFB8);self.assertFalse(m['raw_rom_bytes_included'])
 def test_manifest(self):
  m=json.loads((R/'manifests/divide-wrapper-reconstruction.json').read_text());[self.assertEqual(hashlib.sha256((R/o['path']).read_bytes()).hexdigest(),o['sha256'])for o in m['outputs']]
if __name__=='__main__':unittest.main()
