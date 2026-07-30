#!/usr/bin/env bash
# 从 Whapub 拉取官网产品进化稿 → content/evolution/posts/
# 真源：https://github.com/oliver2023777/Whapub → marketing/changelog/posts/
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/content/evolution/posts"
REPO="${WHAPUB_REPO:-https://github.com/oliver2023777/Whapub.git}"
REF="${WHAPUB_REF:-main}"
SPARSE_PATH="marketing/changelog"

TMP="$(mktemp -d)"
cleanup() { rm -rf "$TMP"; }
trap cleanup EXIT

CLONE_URL="$REPO"
if [[ -n "${WHAPUB_TOKEN:-}" ]]; then
  # private 仓：https://x-access-token:TOKEN@github.com/org/repo.git
  if [[ "$REPO" =~ ^https://github.com/(.+)$ ]]; then
    CLONE_URL="https://x-access-token:${WHAPUB_TOKEN}@github.com/${BASH_REMATCH[1]}"
  fi
fi

echo "→ sync changelog from ${REPO}@${REF} (${SPARSE_PATH})"

git clone --depth 1 --filter=blob:none --sparse --branch "$REF" "$CLONE_URL" "$TMP/whapub"
git -C "$TMP/whapub" sparse-checkout set "$SPARSE_PATH"

SRC="$TMP/whapub/${SPARSE_PATH}/posts"
if [[ ! -d "$SRC" ]]; then
  echo "error: missing ${SPARSE_PATH}/posts in Whapub@${REF}" >&2
  exit 1
fi

mkdir -p "$DEST"
# 以远程为准：清掉本地 posts 后整棵拷入（保留目录）
find "$DEST" -type f -name '*.md' -delete
cp -R "$SRC"/. "$DEST"/

count="$(find "$DEST" -type f -name '*.md' | wc -l | tr -d ' ')"
echo "✓ synced ${count} post(s) → content/evolution/posts/"
