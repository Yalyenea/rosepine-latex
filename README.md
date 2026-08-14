# rosepine-latex

[English](README.md) · [中文](README_zh.md)

[Rosé Pine Dawn](https://rosepinetheme.com) starters for XeLaTeX / pdfLaTeX.

English documents use **pdfLaTeX**. Chinese documents use **XeLaTeX**.

```bash
git clone git@github.com:Yalyenea/rosepine-latex.git
cd rosepine-latex
just book ~/Projects/my-book en
cd ~/Projects/my-book && just build
```

`DEST` is the new project directory (relative or absolute). Then `cd DEST && just build`.

| Command | Default | Kind | You edit |
|---------|---------|------|----------|
| `just book DEST [zh\|en]` | `zh` | Book | `manuscript/chapters/` |
| `just thesis DEST [zh\|en]` | `zh` | Thesis | `manuscript/chapters/` |
| `just paper DEST [bi\|en\|zh]` | `bi` | Paper | `inputs/` / `inputs_zh/` |
| `just slide DEST [zh\|en]` | `zh` | 16:9 slides | `frames/` |
| `just notes DEST [zh\|en]` | `zh` | Lecture notes | `lectures/` |
| `just handout DEST [zh\|en]` | `zh` | 4-up handout | `frames/` |
| `just exercises DEST [zh\|en]` | `zh` | Problem set | `problems/` |
| `just poster DEST [zh\|en]` | `zh` | A0 poster (landscape) | `main.tex` |

English and Chinese books are separate projects. Portrait poster: `\posterlandscapefalse` before `\input{preamble}`.

## Layout

This repo is a factory. `just <kind> DEST` copies a starter into `DEST` and fills in the title.

```
rosepine-latex/
  rosepine/           shared theme
  starters/           one directory per kind × language
  scripts/scaffold.sh used by the just recipes above
  docs/previews/      README images
  justfile            just book / thesis / paper / …
```

| Path | Role |
|------|------|
| `rosepine/` | Shared theme. Canonical copy. |
| `starters/book-en`, `book-zh` | Book templates |
| `starters/thesis-en`, `thesis-zh` | Degree thesis |
| `starters/paper` | Paper template (`bi` keeps both languages) |
| `starters/slide-*` | 16:9 Beamer |
| `starters/notes-*` | Lecture notes |
| `starters/handout-*` | Same frames as slides, 4-up A4 |
| `starters/exercises-*` | Problem set |
| `starters/poster-*` | A0 poster |
| `docs/previews/` | First-page PNGs used below |

`just book DEST` copies a starter and injects `rosepine/`. The new project has `justfile`, `preamble.tex`, and `just build`. Title and author live in `main.tex`.

```
# book / thesis
manuscript/main.tex          cover fields (thesis: school, degree, supervisor)
manuscript/chapters.tex      include list
manuscript/chapters/         write chapters here
manuscript/refs.bib          thesis bibliography
manuscript/imgs/
build/main.pdf               after just build

# paper
main.tex / main_zh.tex       EN / ZH entry
inputs/ / inputs_zh/         sections
refs.bib
build/<dir>-en.pdf           just build-en
build/<dir>-zh.pdf           just build-zh

# slide / handout
frames/                      one file per frame
imgs/

# notes
lectures/

# exercises
problems/                    one file per problem set

# poster
main.tex                     banner + posterbox blocks
imgs/
```

## Preview

| | English | Chinese |
|---|:---:|:---:|
| Book | <img src="docs/previews/book-en.png" width="260" alt="English book"> | <img src="docs/previews/book-zh.png" width="260" alt="Chinese book"> |
| Thesis | <img src="docs/previews/thesis-en.png" width="260" alt="English thesis"> | <img src="docs/previews/thesis-zh.png" width="260" alt="Chinese thesis"> |
| Paper | <img src="docs/previews/paper-en.png" width="260" alt="English paper"> | <img src="docs/previews/paper-zh.png" width="260" alt="Chinese paper"> |
| Slides | <img src="docs/previews/slide-en-1.png" width="260" alt="English slide"> | <img src="docs/previews/slide-zh-1.png" width="260" alt="Chinese slide"> |
| Notes | <img src="docs/previews/notes-en.png" width="260" alt="English notes"> | <img src="docs/previews/notes-zh.png" width="260" alt="Chinese notes"> |
| Handout | <img src="docs/previews/handout-en.png" width="260" alt="English handout"> | <img src="docs/previews/handout-zh.png" width="260" alt="Chinese handout"> |
| Exercises | <img src="docs/previews/exercises-en.png" width="260" alt="English exercises"> | <img src="docs/previews/exercises-zh.png" width="260" alt="Chinese exercises"> |
| Poster | <img src="docs/previews/poster-en.png" width="260" alt="English poster"> | <img src="docs/previews/poster-zh.png" width="260" alt="Chinese poster"> |

## Requirements

- [`just`](https://github.com/casey/just), `latexmk`, TeX Live
- English: pdfLaTeX, Latin Modern (`lmodern`)
- Chinese: XeLaTeX, **STZhongsong** (华文中宋)

MIT. Palette: [Rosé Pine Dawn](https://rosepinetheme.com).
