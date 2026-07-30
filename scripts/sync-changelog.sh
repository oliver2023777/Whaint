#!/bin/sh
# 从 Whapub 拉取官网产品进化稿 → content/changelog/{decision|weekly|note}/
# 与 Whapub marketing/changelog 目录结构对齐
set -eu

ROOT="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
DEST_ROOT="$ROOT/content/changelog"
REPO="${WHAPUB_REPO:-https://github.com/oliver2023777/Whapub.git}"
REF="${WHAPUB_REF:-main}"
SPARSE_PATH="marketing/changelog"

TMP="$(mktemp -d)"
cleanup() { rm -rf "$TMP"; }
trap cleanup EXIT

CLONE_URL="$REPO"
if [ -n "${WHAPUB_TOKEN:-}" ]; then
  case "$REPO" in
    https://github.com/*)
      path_part="${REPO#https://github.com/}"
      CLONE_URL="https://x-access-token:${WHAPUB_TOKEN}@github.com/${path_part}"
      ;;
  esac
fi

echo "→ sync changelog from ${REPO}@${REF} → content/changelog/{decision,weekly,note}"

git clone --depth 1 --filter=blob:none --sparse --branch "$REF" "$CLONE_URL" "$TMP/whapub"
git -C "$TMP/whapub" sparse-checkout set "$SPARSE_PATH"

SRC_ROOT="$TMP/whapub/${SPARSE_PATH}"
if [ ! -d "$SRC_ROOT" ]; then
  echo "error: missing ${SPARSE_PATH} in Whapub@${REF}" >&2
  exit 1
fi

# 清掉旧扁平目录（若仍存在）
rm -rf "$ROOT/content/evolution/posts" "$ROOT/content/evolution"

count=0
for kind in decision weekly note; do
  dest="$DEST_ROOT/$kind"
  mkdir -p "$dest"
  find "$dest" -type f -name '*.md' ! -name '.gitkeep.md' -delete

  dir="$SRC_ROOT/$kind"
  [ -d "$dir" ] || continue
  for f in "$dir"/*.md; do
    [ -f "$f" ] || continue
    base="$(basename "$f")"
    case "$base" in
      .gitkeep.md|README.md) continue ;;
      _*) continue ;;
    esac
    cp "$f" "$dest/$base"
    count=$((count + 1))
  done
done

if [ "$count" -eq 0 ]; then
  echo "error: no changelog posts under ${SPARSE_PATH}/{decision,weekly,note}" >&2
  exit 1
fi

echo "✓ synced ${count} post(s) → content/changelog/{decision,weekly,note}/"
