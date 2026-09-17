## Scope

Which release, research question, tool, artifact, or analysis changes?

## Evidence and reproduction

List ROM inputs by hash only. Include address conventions, exact commands, tool
versions, and expected outputs. Commit all lawful non-ROM results needed to
inspect or reproduce the work.

## Verification

- [ ] `python tools/validate_repository.py .`
- [ ] `python tools/verify_artifacts.py .`
- [ ] `python -m unittest discover -s tests -v`
- [ ] No original, modified, patched, rebuilt, renamed, or archived ROM was added
- [ ] Useful non-ROM results are committed rather than represented only by hashes
- [ ] Graphics or sprite work includes actual PNG output
- [ ] Claims are labeled observed, derived, inferred, or unknown
