# rosepine-latex

Rose Pine XeLaTeX factory. This repo is the copy source, not a runtime theme.

## Layout

- `rosepine/` — edit the theme here
- `starters/` — one directory per kind/language
- `scripts/scaffold.sh` — only entry used by `just book` / `paper` / …
- Generated projects keep a local `rosepine/` snapshot. They must not `\input` this tree.

## Build

- Factory: `just` / `just test` / `just sync-theme`
- Generated project: `just build` (XeLaTeX via `latexmk`)
- Fonts stay project-local: Latin Modern Roman + STZhongsong (CJK). No fallback chain.

## Do not

- Add NeurIPS / elegantbook / a second palette
- Put OCR, API, or process metadata in PDF bodies
- Make starters `\input` sibling starters or this repo at compile time
