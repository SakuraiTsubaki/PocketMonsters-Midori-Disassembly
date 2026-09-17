# Tools

- `hash_input.py` records local ROM size, SHA-1, and SHA-256 without copying it.
- `validate_repository.py` checks the target repository contract.
- `verify_artifacts.py` rejects ROM images and verifies PNG companions for
  encoded graphics.

Add deterministic target-specific tools here and commit their lawful non-ROM
outputs, logs, fixtures, and validation material. Promote reusable tools to
`SakuraiTsubaki/Disassembly` after they gain a target-neutral contract.
