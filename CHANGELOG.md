# Changelog

## 2026-08-14

- `just thesis DEST [zh|en]`: degree thesis (cover, abstract, declaration, bib).
- README previews sit in a two-column table.
- English starters use pdfLaTeX (`lmodern`); Chinese stay on XeLaTeX.
- Public README is English; Chinese lives in `README_zh.md`.
- README documents layout and what to edit in each starter.
- Preview PNGs in `docs/previews/` (`just previews`).
- One theme: factory `rosepine/`. Starters no longer ship a copy; `just book` injects it. Removed `just sync-theme`.
- Compiled sample PDFs live in `build/` (gitignored), not `.tmp/`.
- Paper starter is one layer; `just build` writes `.tmp/` and `build/`.
- `just book` / `paper` / `slide` / `notes` / `handout` / `exercises` / `poster` write to `DEST`.
- `just test`.
