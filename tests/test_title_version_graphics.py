import hashlib,json,struct,unittest
from pathlib import Path
ROOT=Path(__file__).parents[1]
class Tests(unittest.TestCase):
 def test_manifest_outputs(self):
  m=json.loads((ROOT/'manifests'/'title-version-graphics.json').read_text())
  for o in m['outputs']:
   p=ROOT/o['path'];self.assertTrue(p.is_file());self.assertEqual(hashlib.sha256(p.read_bytes()).hexdigest(),o['sha256'])
 def test_composed_green_selection(self):
  r=json.loads((ROOT/'analysis'/'midori-jp-title-version-composed.json').read_text());png=(ROOT/'graphics'/'title'/'green-version-jp.png').read_bytes()
  self.assertEqual((r['tiles_offset'],r['tiles_length'],r['base_tile_id']),(0x68000,80,'0x60'));self.assertEqual((r['tilemap_offset'],r['tilemap_length']),(0x49da,9));self.assertEqual(r['blank_tile_ids'],['0x7f']);self.assertEqual(struct.unpack('>II',png[16:24]),(288,32));self.assertEqual(hashlib.sha256(png).hexdigest(),r['png_sha256'])
 def test_revisions_share_asset_ranges(self):
  m=json.loads((ROOT/'manifests'/'title-version-graphics.json').read_text());a,b=m['inputs'];self.assertNotEqual(a['rom_sha256'],b['rom_sha256']);self.assertEqual(a['tiles_sha256'],b['tiles_sha256']);self.assertEqual(a['tilemap_sha256'],b['tilemap_sha256'])
if __name__=='__main__':unittest.main()
