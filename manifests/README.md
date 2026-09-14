# Manifest Guide

This directory contains target inventories and metadata that support reproducible disassembly work. Existing manifests are project data and should be preserved.

Useful fields may include target/release ID, region, language, revision, source location, bank/section/address or offset, asset identifier, repository path, size, hashes, extraction/conversion method, verification state, and shared byte-identical usage.

Do not invent unknown metadata. Verify hash/byte identity before deduplicating, preserve provenance for shared assets, and keep retail/rebuilt ROM images and console keys out of Git.
