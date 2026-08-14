set shell := ["bash", "-lc"]

factory := justfile_directory()

default:
  @just --list

# New project at DEST (relative to $PWD, or absolute).
[no-cd]
book dest lang="zh":
  @bash "{{factory}}/scripts/scaffold.sh" book "{{dest}}" "{{lang}}"

[no-cd]
paper dest lang="bi":
  @bash "{{factory}}/scripts/scaffold.sh" paper "{{dest}}" "{{lang}}"

[no-cd]
slide dest lang="zh":
  @bash "{{factory}}/scripts/scaffold.sh" slide "{{dest}}" "{{lang}}"

[no-cd]
notes dest lang="zh":
  @bash "{{factory}}/scripts/scaffold.sh" notes "{{dest}}" "{{lang}}"

[no-cd]
handout dest lang="zh":
  @bash "{{factory}}/scripts/scaffold.sh" handout "{{dest}}" "{{lang}}"

[no-cd]
exercises dest lang="zh":
  @bash "{{factory}}/scripts/scaffold.sh" exercises "{{dest}}" "{{lang}}"

[no-cd]
poster dest lang="zh":
  @bash "{{factory}}/scripts/scaffold.sh" poster "{{dest}}" "{{lang}}"

# Copy canonical rosepine/ into every starter snapshot.
sync-theme:
  @set -euo pipefail; \
    cp -R "{{factory}}/rosepine/." "{{factory}}/starters/book-zh/manuscript/rosepine/"; \
    cp -R "{{factory}}/rosepine/." "{{factory}}/starters/book-en/manuscript/rosepine/"; \
    cp -R "{{factory}}/rosepine/." "{{factory}}/starters/paper/latex/rosepine/"; \
    for k in slide notes handout exercises poster; do \
      cp -R "{{factory}}/rosepine/." "{{factory}}/starters/$k-zh/rosepine/"; \
      cp -R "{{factory}}/rosepine/." "{{factory}}/starters/$k-en/rosepine/"; \
    done; \
    echo "synced rosepine/ into starters"

# Scaffold each kind into .tmp/ and check placeholders are gone.
test:
  @set -euo pipefail; \
    tmp="{{factory}}/.tmp/scaffold-test"; \
    rm -rf "$tmp"; \
    mkdir -p "$tmp"; \
    just -f "{{factory}}/justfile" book "$tmp/book-zh" zh; \
    just -f "{{factory}}/justfile" book "$tmp/book-en" en; \
    just -f "{{factory}}/justfile" paper "$tmp/paper-bi" bi; \
    just -f "{{factory}}/justfile" paper "$tmp/paper-en" en; \
    just -f "{{factory}}/justfile" paper "$tmp/paper-zh" zh; \
    just -f "{{factory}}/justfile" slide "$tmp/slide-zh" zh; \
    just -f "{{factory}}/justfile" notes "$tmp/notes-zh" zh; \
    just -f "{{factory}}/justfile" handout "$tmp/handout-zh" zh; \
    just -f "{{factory}}/justfile" exercises "$tmp/exercises-zh" zh; \
    just -f "{{factory}}/justfile" poster "$tmp/poster-zh" zh; \
    test -f "$tmp/book-zh/justfile"; \
    test -f "$tmp/book-zh/manuscript/main.tex"; \
    test -f "$tmp/book-zh/manuscript/rosepine/theme.tex"; \
    test -f "$tmp/paper-bi/latex/main.tex"; \
    test -f "$tmp/paper-bi/latex/main_zh.tex"; \
    test ! -f "$tmp/paper-en/latex/main_zh.tex"; \
    test ! -f "$tmp/paper-zh/latex/main.tex"; \
    test -f "$tmp/slide-zh/main.tex"; \
    if grep -R --include='*.tex' --include='*.md' --include='justfile' -n '++[A-Z0-9-]*++' "$tmp"; then \
      echo "unreplaced placeholders"; exit 1; \
    fi; \
    echo "ok: $tmp"
