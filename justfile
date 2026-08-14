set shell := ["bash", "-lc"]

factory := justfile_directory()

default:
  @just --list

# New project at DEST (relative to $PWD, or absolute).
[no-cd]
book dest lang="zh":
  @bash "{{factory}}/scripts/scaffold.sh" book "{{dest}}" "{{lang}}"

[no-cd]
thesis dest lang="zh":
  @bash "{{factory}}/scripts/scaffold.sh" thesis "{{dest}}" "{{lang}}"

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

# Render starter first pages into docs/previews/.
previews:
  @bash "{{factory}}/scripts/previews.sh"

# Scaffold each kind into .tmp/ and check placeholders are gone.
test:
  @set -euo pipefail; \
    tmp="{{factory}}/.tmp/scaffold-test"; \
    rm -rf "$tmp"; \
    mkdir -p "$tmp"; \
    just -f "{{factory}}/justfile" book "$tmp/book-zh" zh; \
    just -f "{{factory}}/justfile" book "$tmp/book-en" en; \
    just -f "{{factory}}/justfile" thesis "$tmp/thesis-zh" zh; \
    just -f "{{factory}}/justfile" thesis "$tmp/thesis-en" en; \
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
    test -f "$tmp/thesis-zh/manuscript/main.tex"; \
    test -f "$tmp/thesis-en/manuscript/rosepine/theme-thesis.tex"; \
    test -f "$tmp/paper-bi/main.tex"; \
    test -f "$tmp/paper-bi/main_zh.tex"; \
    test -f "$tmp/paper-bi/justfile"; \
    test ! -f "$tmp/paper-en/main_zh.tex"; \
    test ! -f "$tmp/paper-zh/main.tex"; \
    test -f "$tmp/slide-zh/main.tex"; \
    if grep -R --include='*.tex' --include='*.md' --include='justfile' -n '++[A-Z0-9-]*++' "$tmp"; then \
      echo "unreplaced placeholders"; exit 1; \
    fi; \
    echo "ok: $tmp"
