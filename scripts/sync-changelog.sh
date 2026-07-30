#!/bin/sh
# 从 Whapub 拉取官网产品进化稿 → content/evolution/posts/
# 真源：marketing/changelog/{decision|weekly|note}/*.md
set -eu

ROOT="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/content/evolution/posts"
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

echo "→ sync changelog from ${REPO}@${REF} (${SPARSE_PATH}/{decision,weekly,note})"

git clone --depth 1 --filter=blob:none --sparse --branch "$REF" "$CLONE_URL" "$TMP/whapub"
git -C "$TMP/whapub" sparse-checkout set "$SPARSE_PATH"

SRC_ROOT="$TMP/whapub/${SPARSE_PATH}"
if [ ! -d "$SRC_ROOT" ]; then
  echo "error: missing ${SPARSE_PATH} in Whapub@${REF}" >&2
  exit 1
fi

mkdir -p "$DEST"
find "$DEST" -type f -name '*.md' -delete

# 按 kind 子目录扁平拷入 posts/（跳过 README、.gitkeep）
count=0
for kind in decision weekly note; do
  dir="$SRC_ROOT/$kind"
  [ -d "$dir" ] || continue
  for f in "$dir"/*.md; do
    [ -f "$f" ] || continue
    base="$(basename "$f")"
    case "$base" in
      .gitkeep.md|README.md) continue ;;
    esac
    case "$base" in
      _*) continue ;;
    esac
    cp "$f" "$DEST/$base"
    count=$((count + 1))
  done
done

if [ "$count" -eq 0 ]; then
  echo "error: no changelog posts under ${SPARSE_PATH}/{decision,weekly,note}" >&2
  exit 1
fi

echo "✓ synced ${count} post(s) → content/evolution/posts/"
