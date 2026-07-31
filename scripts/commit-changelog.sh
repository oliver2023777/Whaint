#!/bin/sh
# 将 content/changelog/ 的同步结果提交并（可选）推送到 Whaint 远程，便于公开仓 / GEO。
# 仅暂存 content/changelog/，不碰其它工作区改动。
set -eu

ROOT="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

COMMIT="${SYNC_CHANGELOG_COMMIT:-1}"
PUSH="${SYNC_CHANGELOG_PUSH:-1}"

if [ "$COMMIT" = "0" ]; then
  echo "→ skip changelog commit (SYNC_CHANGELOG_COMMIT=0)"
  exit 0
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "warn: not a git repo; skip changelog commit" >&2
  exit 0
fi

branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
if [ -z "$branch" ] || [ "$branch" = "HEAD" ]; then
  echo "warn: detached HEAD; skip changelog commit" >&2
  exit 0
fi

git add -A -- content/changelog/

if git diff --cached --quiet -- content/changelog/; then
  echo "→ changelog tree unchanged; nothing to commit"
  exit 0
fi

name="${SYNC_CHANGELOG_GIT_NAME:-Whaint Changelog Sync}"
email="${SYNC_CHANGELOG_GIT_EMAIL:-changelog-sync@users.noreply.github.com}"
msg="${SYNC_CHANGELOG_COMMIT_MSG:-Sync changelog posts from Whapub.}"

git -c "user.name=$name" -c "user.email=$email" commit -m "$msg"
echo "✓ committed content/changelog/ on ${branch}"

if [ "$PUSH" = "0" ]; then
  echo "→ skip push (SYNC_CHANGELOG_PUSH=0)"
  exit 0
fi

token="${WHAINT_TOKEN:-${GITHUB_TOKEN:-${WHAPUB_TOKEN:-}}}"
export GIT_TERMINAL_PROMPT=0

push_with_token() {
  origin="$(git remote get-url origin 2>/dev/null || true)"
  [ -n "$origin" ] || return 1
  path_part=""
  case "$origin" in
    https://github.com/*)
      path_part="${origin#https://github.com/}"
      ;;
    https://x-access-token:*@github.com/*)
      path_part="${origin#*@github.com/}"
      ;;
    git@github.com:*)
      path_part="${origin#git@github.com:}"
      ;;
    *)
      return 1
      ;;
  esac
  path_part="${path_part%.git}"
  [ -n "$path_part" ] || return 1
  git push "https://x-access-token:${token}@github.com/${path_part}.git" "HEAD:${branch}"
}

if [ -n "$token" ]; then
  if push_with_token; then
    echo "✓ pushed ${branch} → origin (token)"
    exit 0
  fi
  echo "warn: token push failed; trying plain git push…" >&2
fi

if git push origin "HEAD:${branch}"; then
  echo "✓ pushed ${branch} → origin"
  exit 0
fi

echo "warn: git push failed — site build continues; fix credentials (WHAINT_TOKEN / SSH) and push manually for GitHub GEO" >&2
exit 0
