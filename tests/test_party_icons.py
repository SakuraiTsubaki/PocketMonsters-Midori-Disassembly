import hashlib,json,struct,unittest
from pathlib import Path
ROOT=Path(__file__).parents[1];COUNT=2;RAW='7512db31bd72d44a7b5a918167d1e2baad594729fc591b428b86f07fb9ac7453'
class T(unittest.TestCase):
 def test_assets(self):
  s=json.loads((ROOT/'analysis/party-icons-summary.json').read_text());l=json.loads((ROOT/s['layout']).read_text());self.assertEqual((s['release_count'],s['source_sha256'],s['icon_count'],s['frames_per_icon']),(COUNT,RAW,4,2));self.assertEqual(sum(x['origin_reference'] for x in s['releases']),1);self.assertEqual({x['language'] for x in s['releases']},{'Japanese'});self.assertEqual(len(l['icons']),4);self.assertEqual(struct.unpack('>II',(ROOT/s['png']).read_bytes()[16:24]),(256,128));self.assertEqual(struct.unpack('>II',(ROOT/s['source_png']).read_bytes()[16:24]),(128,128))
  for x in s['releases']:
   r=json.loads((ROOT/x['evidence']).read_text());self.assertEqual((r['target']['sha256'],r['asset']['source_sha256']),(x['sha256'],RAW));self.assertFalse(r['raw_rom_bytes_included'])
 def test_manifest(self):
  m=json.loads((ROOT/'manifests/party-icons.json').read_text());[self.assertEqual(hashlib.sha256((ROOT/o['path']).read_bytes()).hexdigest(),o['sha256']) for o in m['outputs']]
if __name__=='__main__':unittest.main()
