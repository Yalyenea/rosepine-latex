#!/usr/bin/env bash
# Build every starter and export first-page PNGs to docs/previews/.
set -euo pipefail

FACTORY="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$FACTORY/docs/previews"
TMP="$FACTORY/.tmp/previews"
YEAR="$(date +%Y)"
MONTH="$(date +%m)"
DAY="$(date +%d)"

rm -rf "$TMP"
mkdir -p "$TMP" "$OUT"

replace() {
  local dest="$1"
  python3 - "$dest" <<'PY'
import sys
from pathlib import Path
dest = Path(sys.argv[1])
vals = {
    "++PROJECT-SLUG++": dest.name,
    "++PAPER-ID++": "RP-001",
    "++PROJECT-TITLE++": "Rose Pine",
    "++PROJECT-TITLE-ZH++": "玫瑰松",
    "++PROJECT-SUBTITLE++": "Dawn",
    "++PROJECT-SUBTITLE-ZH++": "黎明",
    "++PROJECT-AUTHORS++": "Ada Lovelace",
    "++PROJECT-AFFIL++": "Department of Mathematics",
    "++COURSE++": "Mathematics",
    "++DUE++": "Due Friday",
}
# YEAR/MONTH/DAY filled by caller via env file if present
env = dest / ".preview-env"
if env.exists():
    for line in env.read_text(encoding="utf-8").splitlines():
        if "=" in line:
            k, v = line.split("=", 1)
            vals[k] = v
    env.unlink()
suffixes = {".tex", ".md", ".bib"}
names = {"justfile", "Justfile"}
for path in dest.rglob("*"):
    if not path.is_file():
        continue
    if path.suffix not in suffixes and path.name not in names:
        continue
    text = path.read_text(encoding="utf-8")
    orig = text
    for k, v in vals.items():
        text = text.replace(k, v)
    if text != orig:
        path.write_text(text, encoding="utf-8")
PY
}

inject_theme() {
  local dest="$1"
  if [[ -d "$dest/manuscript" ]]; then
    rm -rf "$dest/manuscript/rosepine"
    cp -R "$FACTORY/rosepine" "$dest/manuscript/rosepine"
  else
    rm -rf "$dest/rosepine"
    cp -R "$FACTORY/rosepine" "$dest/rosepine"
  fi
}

stage() {
  local src="$1" dest="$2"
  rm -rf "$dest"
  cp -R "$src" "$dest"
  inject_theme "$dest"
  {
    printf '%s=%s\n' "++YEAR++" "$YEAR"
    printf '%s=%s\n' "++MONTH++" "$MONTH"
    printf '%s=%s\n' "++DAY++" "$DAY"
  } > "$dest/.preview-env"
  replace "$dest"
}

export_page() {
  local pdf="$1" stem="$2" dpi="${3:-140}" pages="${4:-1}"
  local dir
  dir="$(dirname "$stem")"
  mkdir -p "$dir"
  pdftoppm -png -r "$dpi" -f 1 -l "$pages" "$pdf" "$stem"
  if [[ -f "${stem}-1.png" && "$pages" -eq 1 ]]; then
    mv "${stem}-1.png" "${stem}.png"
  fi
}

stage "$FACTORY/starters/book-en" "$TMP/book-en"
stage "$FACTORY/starters/book-zh" "$TMP/book-zh"
stage "$FACTORY/starters/thesis-en" "$TMP/thesis-en"
stage "$FACTORY/starters/thesis-zh" "$TMP/thesis-zh"
stage "$FACTORY/starters/paper" "$TMP/paper"
stage "$FACTORY/starters/slide-en" "$TMP/slide-en"
stage "$FACTORY/starters/slide-zh" "$TMP/slide-zh"
stage "$FACTORY/starters/notes-en" "$TMP/notes-en"
stage "$FACTORY/starters/notes-zh" "$TMP/notes-zh"
stage "$FACTORY/starters/handout-en" "$TMP/handout-en"
stage "$FACTORY/starters/handout-zh" "$TMP/handout-zh"
stage "$FACTORY/starters/exercises-en" "$TMP/exercises-en"
stage "$FACTORY/starters/exercises-zh" "$TMP/exercises-zh"
stage "$FACTORY/starters/poster-en" "$TMP/poster-en"
stage "$FACTORY/starters/poster-zh" "$TMP/poster-zh"

( cd "$TMP/book-en" && just build )
( cd "$TMP/book-zh" && just build )
( cd "$TMP/thesis-en" && just build )
( cd "$TMP/thesis-zh" && just build )
( cd "$TMP/paper" && just build )
( cd "$TMP/slide-en" && just build )
( cd "$TMP/slide-zh" && just build )
( cd "$TMP/notes-en" && just build )
( cd "$TMP/notes-zh" && just build )
( cd "$TMP/handout-en" && just build )
( cd "$TMP/handout-zh" && just build )
( cd "$TMP/exercises-en" && just build )
( cd "$TMP/exercises-zh" && just build )
( cd "$TMP/poster-en" && just build )
( cd "$TMP/poster-zh" && just build )

export_page "$TMP/book-en/build/main.pdf" "$OUT/book-en" 130
export_page "$TMP/book-zh/build/main.pdf" "$OUT/book-zh" 130
export_page "$TMP/thesis-en/build/main.pdf" "$OUT/thesis-en" 130
export_page "$TMP/thesis-zh/build/main.pdf" "$OUT/thesis-zh" 130
export_page "$TMP/paper/build/paper-en.pdf" "$OUT/paper-en" 130
export_page "$TMP/paper/build/paper-zh.pdf" "$OUT/paper-zh" 130
export_page "$TMP/slide-en/main.pdf" "$OUT/slide-en" 120 2
export_page "$TMP/slide-zh/main.pdf" "$OUT/slide-zh" 120 2
export_page "$TMP/notes-en/main.pdf" "$OUT/notes-en" 130
export_page "$TMP/notes-zh/main.pdf" "$OUT/notes-zh" 130
export_page "$TMP/handout-en/main.pdf" "$OUT/handout-en" 130
export_page "$TMP/handout-zh/main.pdf" "$OUT/handout-zh" 130
export_page "$TMP/exercises-en/main.pdf" "$OUT/exercises-en" 130
export_page "$TMP/exercises-zh/main.pdf" "$OUT/exercises-zh" 130
export_page "$TMP/poster-en/main.pdf" "$OUT/poster-en" 36
export_page "$TMP/poster-zh/main.pdf" "$OUT/poster-zh" 36

echo "previews: $OUT"
ls -l "$OUT"
