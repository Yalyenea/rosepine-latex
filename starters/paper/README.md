# ++PROJECT-TITLE++ / ++PROJECT-TITLE-ZH++

Rose Pine paper (`article` / `ctexart` + XeLaTeX). Same palette as the book templates — not a conference class.

```
main.tex / main_zh.tex
inputs/ / inputs_zh/
rosepine/
```

```bash
just build-en    # → build/<dir>-en.pdf
just build-zh    # → build/<dir>-zh.pdf
just build
just clean       # drop .tmp/
```

Intermediates stay in `.tmp/`. For language-only projects, scaffold `en` or `zh` and only one main remains.
