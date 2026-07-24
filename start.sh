#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
# Whaint · 营销站一键启动（Docker）
#
#   ./start.sh                 # 构建并启动 → http://IP:3080
#   ./start.sh start           # 仅启动（不重建）
#   ./start.sh start --build   # 强制重建并启动
#   ./start.sh stop|restart|logs|status|help
#
# 无 .env 时会从 .env.example 自动生成；端口固定 3080（见 docker-compose.yml）
# ═══════════════════════════════════════════════════════════════

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

# 与 docker-compose.yml 保持一致
PORT=3080

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${BLUE}[信息]${NC} $*"; }
ok() { echo -e "${GREEN}[完成]${NC} $*"; }
warn() { echo -e "${YELLOW}[警告]${NC} $*"; }
err() { echo -e "${RED}[错误]${NC} $*" >&2; }

detect_compose() {
  if docker compose version >/dev/null 2>&1; then
    COMPOSE=(docker compose)
  elif command -v docker-compose >/dev/null 2>&1; then
    COMPOSE=(docker-compose)
  else
    err "未找到 Docker Compose。请先安装 Docker。"
    exit 1
  fi
}

ensure_env() {
  if [[ -f .env ]]; then
    return 0
  fi
  if [[ ! -f .env.example ]]; then
    err "缺少 .env.example，无法自动创建 .env"
    exit 1
  fi
  cp .env.example .env
  ok "未找到 .env，已自动从 .env.example 创建"
  warn "默认域名是占位符；上线前请改 .env 里的 PUBLIC_SITE_URL，再执行：./start.sh start --build"
}

usage() {
  sed -n '2,12p' "$0"
}

show_access() {
  local mapped
  mapped="$(docker port whaint 80 2>/dev/null || true)"
  if [[ -z "$mapped" ]]; then
    err "容器已起，但没有端口映射！请执行：docker logs whaint"
    err "确认本机 3080 是否被占用：ss -lntp | grep 3080"
    return 1
  fi
  ok "营销站已启动 → http://服务器IP:${PORT}/"
  info "端口映射：${mapped} · 日志：./start.sh logs · 停止：./start.sh stop"
}

cmd="${1:-up}"
shift || true
FORCE_BUILD=0

for arg in "$@"; do
  case "$arg" in
    --build|-b) FORCE_BUILD=1 ;;
    -h|--help) usage; exit 0 ;;
  esac
done

detect_compose
ensure_env

case "$cmd" in
  up|start|"")
    if [[ "$cmd" == "start" && "$FORCE_BUILD" -eq 0 ]]; then
      info "启动容器（不重建）…"
      "${COMPOSE[@]}" up -d
    else
      info "构建并启动…"
      "${COMPOSE[@]}" up -d --build
    fi
    sleep 1
    show_access
    ;;
  stop)
    "${COMPOSE[@]}" down
    ok "已停止"
    ;;
  restart)
    "${COMPOSE[@]}" restart
    ok "已重启"
    show_access
    ;;
  logs)
    "${COMPOSE[@]}" logs -f --tail=200
    ;;
  status|ps)
    "${COMPOSE[@]}" ps
    docker port whaint 80 2>/dev/null || true
    ;;
  help|-h|--help)
    usage
    ;;
  *)
    err "未知命令: $cmd"
    usage
    exit 1
    ;;
esac
