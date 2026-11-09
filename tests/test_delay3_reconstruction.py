import hashlib,json,unittest
from pathlib import Path
R=Path(__file__).parents[1]
class T(unittest.TestCase):
 def test_catalog(self):
  s=json.loads((R/'analysis/delay3-summary.json').read_text());self.assertEqual((s['release_count'],s['origin_reference'],sum(x['origin_reference'] for x in s['releases'])),(2,'midori-jp-rev0',1));self.assertEqual((s['releases'][0]['delay3_address'],s['releases'][0]['protected_delay3_address']),('0x3E07','0x05EB'))
  for x in s['releases']:
   e=json.loads((R/x['evidence']).read_text());self.assertEqual((e['functions']['Delay3']['length'],e['functions']['ProtectedDelay3']['length'],e['functions']['ProtectedDelay3']['preserved_register']),(5,6,'BC'));self.assertEqual(e['functions']['Delay3']['delay_frames_target'],e['dependency']['delay_frames_address']);self.assertEqual(e['functions']['ProtectedDelay3']['delay3_target'],e['functions']['Delay3']['address']);self.assertFalse(e['raw_rom_bytes_included'])
 def test_manifest(self):
  m=json.loads((R/'manifests/delay3-reconstruction.json').read_text());
  for x in m['outputs']:self.assertEqual(hashlib.sha256((R/x['path']).read_bytes()).hexdigest(),x['sha256'])
if __name__=='__main__':unittest.main()
