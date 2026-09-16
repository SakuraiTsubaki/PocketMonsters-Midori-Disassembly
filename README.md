# PocketMonsters-Midori-Disassembly

Evidence-driven disassembly research for **Pocket Monsters Midori / Pokémon Green**.

## Target

| Field | Value |
| --- | --- |
| Platform | Game Boy |
| CPU | Sharp SM83 |
| Architecture profile | `gb-sm83` |
| Scope | Japanese Green revisions, including Rev 0 and Rev A only after hash verification. |
| Current stage | Foundation; no release baseline is verified yet |

## Ready to use

- machine-readable target metadata and an intentionally empty release matrix;
- architecture-specific bank/section and symbol tables;
- documented scope, workflow, research method, and roadmap;
- local input hashing and repository validation tools;
- unit tests, GitHub Actions, issue forms, and pull-request checks.

## Start a verified baseline

```sh
python tools/hash_input.py path/to/legally-obtained-input
python tools/validate_repository.py .
python -m unittest discover -s tests -v
```

Add only metadata and hashes to `research/releases.csv`; never add the input.
Use `research/templates/note.md` for each bounded investigation.

Shared methods and reusable tools belong in
[`SakuraiTsubaki/Disassembly`](https://github.com/SakuraiTsubaki/Disassembly).

No earlier experimental work was migrated. Completeness and byte-exactness are
not claimed until automated evidence exists.
