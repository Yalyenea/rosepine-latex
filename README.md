# rosepine-latex

Rose Pine Dawn · XeLaTeX 工厂。clone 一次，开新工程一条命令。

Book is the visual source. Paper / slide / notes / handout / exercises / poster derive the same palette and fonts. Generated projects keep a local `rosepine/` snapshot and do not `\input` this repo.

## 30 seconds

```bash
git clone git@github.com:Yalyenea/rosepine-latex.git
cd rosepine-latex
just book ~/Projects/my-book zh
cd ~/Projects/my-book && just build
```

`DEST` is the new project directory (relative to your current working directory, or absolute).

```bash
just -f /path/to/rosepine-latex/justfile paper ./crb-note bi
```

## Commands

| Command | Default | Result |
|---------|---------|--------|
| `just book DEST [zh\|en]` | `zh` | book (`ctexbook` / `book`) |
| `just paper DEST [bi\|en\|zh]` | `bi` | article (`article` / `ctexart`) |
| `just slide DEST [zh\|en]` | `zh` | 16:9 slides |
| `just notes DEST [zh\|en]` | `zh` | lecture notes |
| `just handout DEST [zh\|en]` | `zh` | 4-up printable slides |
| `just exercises DEST [zh\|en]` | `zh` | problem set |
| `just poster DEST [zh\|en]` | `zh` | A0 poster (landscape) |

```bash
just                  # list
just sync-theme       # copy rosepine/ into every starter
just test             # scaffold smoke test → .tmp/scaffold-test
```

Need both languages for a book? Make two projects. There is no bilingual-in-one-file book starter.

## After scaffold

1. `cd DEST && just build`
2. Edit title / author / `hypersetup` in `main*.tex`
3. Write content (`manuscript/chapters/`, `inputs*` for papers, `frames/`, …)

Poster portrait: `\posterlandscapefalse` before `\input{preamble}`.

## Layout

| Path | Role |
|------|------|
| `rosepine/` | Canonical theme (edit here, then `just sync-theme`) |
| `starters/` | Copy sources |
| `scripts/scaffold.sh` | `just book` / `paper` / … |

## Fonts and engine

- Engine: **XeLaTeX** (all starters, including English)
- Latin: **Latin Modern Roman**
- CJK: **STZhongsong** (华文中宋), Chinese only — install it on the machine, not shipped here

Also: `just`, `latexmk`.

## Not included

- NeurIPS / elegantbook / other palettes
- Font fallback chains
- OCR or API pipelines
- A single-volume EN∥ZH book

## License

MIT. Palette name: [Rosé Pine Dawn](https://rosepinetheme.com).
