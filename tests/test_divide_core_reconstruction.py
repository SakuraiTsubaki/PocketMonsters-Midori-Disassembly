import csv,hashlib,json,unittest
from pathlib import Path
R=Path(__file__).parents[1];H='6874646800cec926f4da0d31fd1b650ec27071171d3666f260e0f6abbedae412'
class T(unittest.TestCase):
 def test_releases(self):
  with (R/'research/releases.csv').open() as h: rows={x['id']:x for x in csv.DictReader(h)}
  for k,row in rows.items():
   m=json.loads((R/f'analysis/{k}-divide-core.json').read_text());f=m['function'];w=json.loads((R/f'analysis/{k}-divide-wrapper.json').read_text())['function']['home_call']['target'];self.assertEqual(m['target']['sha256'],row['sha256']);self.assertEqual((f['bank'],f['address'],f['rom_offset'],f['range_end_exclusive'],f['length']),(0x0D,w['address'],w['rom_offset'],w['rom_offset']+136,136));self.assertEqual(f['code_sha256'],H);self.assertEqual(f['hram_layout']['quotient'],[0xFF95,0xFF96,0xFF97,0xFF98]);self.assertEqual(f['hram_layout']['divisor'],0xFF99);self.assertFalse(m['raw_rom_bytes_included'])
 def test_manifest(self):
  m=json.loads((R/'manifests/divide-core-reconstruction.json').read_text());[self.assertEqual(hashlib.sha256((R/o['path']).read_bytes()).hexdigest(),o['sha256'])for o in m['outputs']]
if __name__=='__main__':unittest.main()
