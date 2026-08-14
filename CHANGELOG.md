# Changelog

## 2026-08-14

### Changed
- Paper starter is one layer (`main.tex` next to `inputs/`, no `latex/`). `just build` writes junk to `.tmp/` and PDFs to `build/`.

### Added
- Extracted the Rose Pine factory from `palimpsest` into this repository.
- Root `just book` / `paper` / `slide` / `notes` / `handout` / `exercises` / `poster` write a project to an explicit `DEST`.
- Each starter ships a small `justfile` (`just build` / `just clean`).
- `just test` scaffolds every kind into `.tmp/` and checks placeholders are replaced.
- `just sync-theme` copies canonical `rosepine/` into starter snapshots.
