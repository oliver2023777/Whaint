# 官网「产品进化」内容（与 Whapub 对齐）

> 目录与同步开关短说明。  
> **整套系统交互（给协作者 / 审查）** → [`docs/系统交互说明.md`](../../docs/系统交互说明.md)

```text
content/changelog/
  decision/
  weekly/
  note/
```

真源：**Whapub** `marketing/changelog/{decision|weekly|note}/`  
同步后保持相同子目录，不再扁平到 `posts/`。

## 同步

```bash
bun run sync:changelog
bun run build:ci
```

服务器：`.env` 填 `WHAPUB_TOKEN` 后 `./start.sh start --build`。

构建时默认还会把有变更的 `content/changelog/` **commit + push** 回 Whaint（`scripts/commit-changelog.sh`），让公开 GitHub 也有文给 GEO。  
关闭推送：`SYNC_CHANGELOG_PUSH=0`。推送凭证：`WHAINT_TOKEN`（或能写 Whaint 的 `WHAPUB_TOKEN` / SSH）。
