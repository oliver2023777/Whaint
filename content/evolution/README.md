# 官网「产品进化」精选

构建时消费目录。真源在 **Whapub**：

- 仓：https://github.com/oliver2023777/Whapub
- 路径：`marketing/changelog/posts/`

## 同步

```bash
bun run sync:changelog          # 本地拉一次
bun run build:ci                # 先同步再构建
```

Docker 默认 `SYNC_CHANGELOG=1`；private 仓加 `--build-arg WHAPUB_TOKEN=…`。  
关闭同步：`--build-arg SYNC_CHANGELOG=0`（仅用本目录已有稿）。

在 Whapub 说「官方发布」写入那边的 `marketing/changelog/`，push 后重建 Whaint 即可上线。
