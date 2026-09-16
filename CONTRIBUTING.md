# Contributing

- Verify input identity before analysis and keep the input outside Git.
- Record file offsets separately from CPU or bus addresses.
- Label claims observed, derived, inferred, or unknown, with confidence.
- Document exact commands and tool versions.
- Keep reusable cross-target work in `SakuraiTsubaki/Disassembly`.
- Do not claim completeness or byte-exactness without automated verification.

Run before proposing a change:

```sh
python tools/validate_repository.py .
python -m unittest discover -s tests -v
python -m compileall -q tools tests
```

Repository licensing is an owner decision and is not invented by this scaffold.
