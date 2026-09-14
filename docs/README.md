# Documentation Hub

This directory is the central documentation portal for the disassembly project. Existing research notes remain authoritative for their documented scope; this hub connects them with shared project standards, version tracking, reconstruction, matching, and asset workflows.

## Quick links

| Document | Purpose |
| --- | --- |
| [Project Status](PROJECT_STATUS.md) | Current reconstruction and matching stage |
| [Roadmap](ROADMAP.md) | Long-term path from inventory to reproducible exact builds |
| [Version Coverage](VERSIONS.md) | Regions, languages, revisions, releases, sizes, hashes, and support status |
| [Research Guide](RESEARCH_GUIDE.md) | Evidence, naming, offsets, uncertainty, and research workflow |
| [Disassembly Standards](DISASSEMBLY_STANDARDS.md) | Shared assembly/source reconstruction standards |
| [Build and Matching](BUILD_AND_MATCHING.md) | Reproducible build and exact-match procedure |
| [Verification](VERIFICATION.md) | Unverified, Observed, Reconstructed, and Matched criteria |
| [Repository Structure](REPOSITORY_STRUCTURE.md) | How to preserve the repository's verified source layout |
| [Asset Workflow](ASSET_WORKFLOW.md) | Graphics, text, audio, maps, deduplication, manifests, and review batches |
| [Manifest Guide](../manifests/README.md) | Existing and future manifest conventions |
| [Contributing](../CONTRIBUTING.md) | Contribution and pull-request expectations |

## Working flow

1. Identify the exact target in `VERSIONS.md`.
2. Record evidence according to `RESEARCH_GUIDE.md`.
3. Reconstruct code/data under `DISASSEMBLY_STANDARDS.md`.
4. Use `BUILD_AND_MATCHING.md` and `VERIFICATION.md` to measure progress.
5. For asset work, follow `ASSET_WORKFLOW.md` and update manifests/checksums.
6. Update `PROJECT_STATUS.md` and `ROADMAP.md` at meaningful milestones.

Do not create empty directory trees merely for appearance; preserve and extend the repository's actual verified architecture.
