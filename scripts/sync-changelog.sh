#!/bin/sh
# 从 Whapub 拉取官网产品进化稿 → content/evolution/posts/
# 真源：https://github.com/oliver2023777/Whapub → marketing/changelog/posts/
# 使用 POSIX sh（Docker Alpine 无 bash）
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
  # private 仓：https://x-access-token:TOKEN@github.com/org/repo.git
  case "$REPO" in
    https://github.com/*)
      path_part="${REPO#https://github.com/}"
      CLONE_URL="https://x-access-token:${WHAPUB_TOKEN}@github.com/${path_part}"
      ;;
  esac
fi

echo "→ sync changelog from ${REPO}@${REF} (${SPARSE_PATH})"

git clone --depth 1 --filter=blob:none --sparse --branch "$REF" "$CLONE_URL" "$TMP/whapub"
git -C "$TMP/whapub" sparse-checkout set "$SPARSE_PATH"

SRC="$TMP/whapub/${SPARSE_PATH}/posts"
if [ ! -d "$SRC" ]; then
  echo "error: missing ${SPARSE_PATH}/posts in Whapub@${REF}" >&2
  exit 1
fi

mkdir -p "$DEST"
# 以远程为准：清掉本地 posts 后整棵拷入
find "$DEST" -type f -name '*.md' -delete
cp -R "$SRC"/. "$DEST"/

count="$(find "$DEST" -type f -name '*.md' | wc -l | tr -d ' ')"
echo "✓ synced ${count} post(s) → content/evolution/posts/"
