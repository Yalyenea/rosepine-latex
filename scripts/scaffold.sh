#!/usr/bin/env bash
# Copy a starter into DEST and replace ++PLACEHOLDERS++.
set -euo pipefail

FACTORY="$(cd "$(dirname "$0")/.." && pwd)"
KIND="${1:-}"
DEST_ARG="${2:-}"
VARIANT="${3:-}"

usage() {
  cat <<'EOF'
Usage:
  scaffold.sh book      DEST [zh|en]          # default zh
  scaffold.sh paper     DEST [bi|en|zh]       # default bi
  scaffold.sh slide     DEST [zh|en]
  scaffold.sh notes     DEST [zh|en]
  scaffold.sh handout   DEST [zh|en]
  scaffold.sh exercises DEST [zh|en]
  scaffold.sh poster    DEST [zh|en]

DEST is the new project directory (absolute, or relative to $PWD).
EOF
  exit 1
}

[[ -n "$KIND" && -n "$DEST_ARG" ]] || usage

if [[ "$DEST_ARG" == /* ]]; then
  DEST="$DEST_ARG"
else
  DEST="$PWD/$DEST_ARG"
fi
DEST="${DEST%/}"
BASE="$(basename "$DEST")"

YEAR="$(date +%Y)"
MONTH="$(date +%m)"
DAY="$(date +%d)"

replace_in_tree() {
  local dest="$1"
  python3 - "$dest" <<'PY'
import sys
from pathlib import Path

dest = Path(sys.argv[1])
env_path = dest / ".scaffold-env"
vals = {}
for line in env_path.read_text(encoding="utf-8").splitlines():
    if not line or "=" not in line:
        continue
    k, v = line.split("=", 1)
    vals[k] = v

keys = [
    "++PROJECT-SLUG++",
    "++PAPER-ID++",
    "++PROJECT-TITLE++",
    "++PROJECT-TITLE-ZH++",
    "++PROJECT-SUBTITLE++",
    "++PROJECT-SUBTITLE-ZH++",
    "++PROJECT-AUTHORS++",
    "++PROJECT-AFFIL++",
    "++COURSE++",
    "++DUE++",
    "++YEAR++",
    "++MONTH++",
    "++DAY++",
]
suffixes = {".tex", ".md", ".bib"}
names = {"justfile", "Justfile"}

for path in dest.rglob("*"):
    if not path.is_file():
        continue
    if path.name == ".scaffold-env":
        continue
    if path.suffix not in suffixes and path.name not in names:
        continue
    text = path.read_text(encoding="utf-8")
    orig = text
    for k in keys:
        text = text.replace(k, vals.get(k, ""))
    if text != orig:
        path.write_text(text, encoding="utf-8")
env_path.unlink(missing_ok=True)
PY
}

case "$KIND" in
  book)
    VARIANT="${VARIANT:-zh}"
    case "$VARIANT" in zh|en) ;; *) echo "book lang must be zh|en"; exit 1 ;; esac
    SRC="$FACTORY/starters/book-$VARIANT"
    SLUG="$BASE"
    PAPER_ID="$BASE"
    if [[ "$VARIANT" == "zh" ]]; then
      TITLE="Project Title"
      TITLE_ZH="$BASE"
      SUBTITLE="Subtitle"
      SUBTITLE_ZH="副标题"
      AUTHORS="作者"
    else
      TITLE="$BASE"
      TITLE_ZH="$BASE"
      SUBTITLE="Subtitle"
      SUBTITLE_ZH="副标题"
      AUTHORS="Author"
    fi
    AFFIL=""
    COURSE=""
    DUE=""
    ;;
  paper)
    VARIANT="${VARIANT:-bi}"
    case "$VARIANT" in bi|en|zh) ;; *) echo "paper lang must be bi|en|zh"; exit 1 ;; esac
    SRC="$FACTORY/starters/paper"
    SLUG="$BASE"
    PAPER_ID="$BASE"
    TITLE="$BASE"
    TITLE_ZH="$BASE"
    SUBTITLE=""
    SUBTITLE_ZH=""
    AUTHORS="Author"
    AFFIL="Affiliation"
    COURSE=""
    DUE=""
    ;;
  slide|notes|handout|exercises|poster)
    VARIANT="${VARIANT:-zh}"
    case "$VARIANT" in zh|en) ;; *) echo "$KIND lang must be zh|en"; exit 1 ;; esac
    SRC="$FACTORY/starters/${KIND}-$VARIANT"
    SLUG="$BASE"
    PAPER_ID="$BASE"
    AFFIL=""
    DUE=""
    if [[ "$VARIANT" == "zh" ]]; then
      TITLE="Project Title"
      TITLE_ZH="$BASE"
      AUTHORS="作者"
      case "$KIND" in
        slide) SUBTITLE="Subtitle"; SUBTITLE_ZH="副标题"; COURSE="" ;;
        notes) SUBTITLE="Lecture"; SUBTITLE_ZH="第 1 讲"; COURSE="课程" ;;
        handout) SUBTITLE="Handout"; SUBTITLE_ZH="讲义"; COURSE="" ;;
        exercises) SUBTITLE="Homework 1"; SUBTITLE_ZH="作业 1"; COURSE="课程"; DUE="截止日期：待填" ;;
        poster) SUBTITLE="Poster"; SUBTITLE_ZH="海报"; COURSE="单位 / 会议" ;;
      esac
    else
      TITLE="$BASE"
      TITLE_ZH="$BASE"
      AUTHORS="Author"
      case "$KIND" in
        slide) SUBTITLE="Subtitle"; SUBTITLE_ZH="副标题"; COURSE="" ;;
        notes) SUBTITLE="Lecture 1"; SUBTITLE_ZH="第 1 讲"; COURSE="Course" ;;
        handout) SUBTITLE="Handout"; SUBTITLE_ZH="讲义"; COURSE="" ;;
        exercises) SUBTITLE="Homework 1"; SUBTITLE_ZH="作业 1"; COURSE="Course"; DUE="Due: TBA" ;;
        poster) SUBTITLE="Poster"; SUBTITLE_ZH="海报"; COURSE="Affiliation / venue" ;;
      esac
    fi
    ;;
  *)
    usage
    ;;
esac

[[ -d "$SRC" ]] || { echo "missing starter: $SRC"; exit 1; }
[[ ! -e "$DEST" ]] || { echo "target exists: $DEST"; exit 1; }

mkdir -p "$(dirname "$DEST")"
cp -R "$SRC" "$DEST"

case "$KIND" in
  book)
    rm -rf "$DEST/manuscript/rosepine"
    cp -R "$FACTORY/rosepine" "$DEST/manuscript/rosepine"
    ;;
  paper)
    rm -rf "$DEST/rosepine"
    cp -R "$FACTORY/rosepine" "$DEST/rosepine"
    if [[ "$VARIANT" == "en" ]]; then
      rm -f "$DEST/main_zh.tex" "$DEST/preamble_zh.tex"
      rm -rf "$DEST/inputs_zh"
    elif [[ "$VARIANT" == "zh" ]]; then
      rm -f "$DEST/main.tex" "$DEST/preamble.tex"
      rm -rf "$DEST/inputs"
    fi
    ;;
  slide|notes|handout|exercises|poster)
    rm -rf "$DEST/rosepine"
    cp -R "$FACTORY/rosepine" "$DEST/rosepine"
    ;;
esac

{
  printf '%s=%s\n' "++PROJECT-SLUG++" "$SLUG"
  printf '%s=%s\n' "++PAPER-ID++" "$PAPER_ID"
  printf '%s=%s\n' "++PROJECT-TITLE++" "$TITLE"
  printf '%s=%s\n' "++PROJECT-TITLE-ZH++" "$TITLE_ZH"
  printf '%s=%s\n' "++PROJECT-SUBTITLE++" "$SUBTITLE"
  printf '%s=%s\n' "++PROJECT-SUBTITLE-ZH++" "$SUBTITLE_ZH"
  printf '%s=%s\n' "++PROJECT-AUTHORS++" "$AUTHORS"
  printf '%s=%s\n' "++PROJECT-AFFIL++" "$AFFIL"
  printf '%s=%s\n' "++COURSE++" "$COURSE"
  printf '%s=%s\n' "++DUE++" "$DUE"
  printf '%s=%s\n' "++YEAR++" "$YEAR"
  printf '%s=%s\n' "++MONTH++" "$MONTH"
  printf '%s=%s\n' "++DAY++" "$DAY"
} > "$DEST/.scaffold-env"

replace_in_tree "$DEST"

echo "Created: $DEST"
echo "Next: cd $DEST && just build"
