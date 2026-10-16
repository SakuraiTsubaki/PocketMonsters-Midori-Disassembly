import csv,hashlib,json,unittest
from pathlib import Path
R=Path(__file__).parents[1];E={'midori-jp-rev0':(0x38F5,0x7E73,0x3620),'midori-jp-rev1':(0x38E3,0x7E73,0x360E)}
class T(unittest.TestCase):
 def test_releases(self):
  rows={x['id']:x for x in csv.DictReader((R/'research/releases.csv').read_text().splitlines())};self.assertEqual(set(rows),set(E))
  for k,(a,t,s) in E.items():
   m=json.loads((R/f'analysis/{k}-multiply-wrapper.json').read_text());f=m['function'];self.assertEqual(m['target']['sha256'],rows[k]['sha256']);self.assertEqual((f['bank'],f['address'],f['length']),(0,a,13));self.assertEqual(f['far_call']['target'],{'bank':0x0D,'address':t,'rom_offset':0x30000+t});self.assertEqual(f['far_call']['bankswitch']['address'],s);self.assertFalse(m['raw_rom_bytes_included'])
 def test_manifest(self):
  m=json.loads((R/'manifests/multiply-wrapper-reconstruction.json').read_text());[self.assertEqual(hashlib.sha256((R/o['path']).read_bytes()).hexdigest(),o['sha256'])for o in m['outputs']]
if __name__=='__main__':unittest.main()
