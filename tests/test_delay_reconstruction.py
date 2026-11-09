import hashlib,json,unittest
from pathlib import Path
R=Path(__file__).parents[1]
class T(unittest.TestCase):
 def test_catalog(self):
  s=json.loads((R/'analysis/delay-summary.json').read_text());self.assertEqual((s['release_count'],s['origin_reference'],sum(x['origin_reference'] for x in s['releases'])),(2,'midori-jp-rev0',1));self.assertEqual((s['releases'][0]['delay_frame_address'],s['releases'][0]['delay_frames_address']),('0x0B31','0x3781'))
  for x in s['releases']:
   e=json.loads((R/x['evidence']).read_text());self.assertEqual((e['functions']['DelayFrame']['length'],e['functions']['DelayFrames']['length'],e['functions']['DelayFrame']['h_vblank_occurred_address']),(11,7,0xFFD6));self.assertEqual(e['functions']['DelayFrames']['delay_frame_target'],e['functions']['DelayFrame']['address']);self.assertFalse(e['raw_rom_bytes_included'])
 def test_manifest(self):
  m=json.loads((R/'manifests/delay-reconstruction.json').read_text());
  for x in m['outputs']:self.assertEqual(hashlib.sha256((R/x['path']).read_bytes()).hexdigest(),x['sha256'])
if __name__=='__main__':unittest.main()
