# 官网「产品进化」内容（与 Whapub 对齐）

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
