import hashlib,json,unittest
from pathlib import Path
R=Path(__file__).parents[1];PROFILE='classic';LENGTH=11
class Tests(unittest.TestCase):
 def test_catalog(self):
  s=json.loads((R/'analysis/fill-memory-summary.json').read_text());self.assertEqual((s['function'],s['profile'],sum(x['origin_reference']for x in s['releases'])),('FillMemory',PROFILE,1));self.assertEqual(s['releases'][0]['language'],'Japanese')
  for x in s['releases']:
   e=json.loads((R/x['evidence']).read_text());self.assertEqual((e['function']['length'],e['function']['bank'],e['semantics']['preserves']),(LENGTH,0,['DE']));self.assertFalse(e['raw_rom_bytes_included'])
 def test_source_and_manifest(self):
  self.assertIn('FillMemory::',(R/'src/fill_memory.asm').read_text());m=json.loads((R/'manifests/fill-memory-reconstruction.json').read_text());self.assertEqual(m['release_count'],2)
  for x in m['outputs']:self.assertEqual(hashlib.sha256((R/x['path']).read_bytes()).hexdigest(),x['sha256'])
if __name__=='__main__':unittest.main()
