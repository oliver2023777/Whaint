# Whaint · 工作区说明（开发 / Agent）

> 给维护本营销站的人与 AI Agent。**对外产品介绍见根目录 [`README.md`](../README.md)**。

新开 Cursor / Agent 对话时：先读根 [`README.md`](../README.md)（受众 / CTA / 合规边界），再读本文（目录、同步、部署）。

---

## 1. 三个仓怎么配合

| 路径 | 角色 |
|------|------|
| `../WhaleCore` | 产品仓（交易平台、策略工作室、部署包） |
| **本仓 `Whaint`** | 对外营销站（询价、合规、SEO/GEO） |
| `../WhalePub`（远程 [Whapub](https://github.com/oliver2023777/Whapub)） | 内容工厂：渠道草稿 + 官网产品进化干净稿 |

- 营销站独立域名 / 独立部署。  
- 主 CTA：询价 → `/contact`；次 CTA：演示站 `https://whacore.cn`。  
- 不要把交易所 Key、策略 Prompt 配进营销站。  
- 公开文案对齐本仓 [`compliance/`](../compliance/README.md)。  
- 卖点素材可参考 `../WhaleCore/docs/huzhan/`，勿另造冲突卖点。

### 联系方式真源

| 渠道 | 值 |
|------|-----|
| QQ | `613747777` |
| Telegram | `@whacore`（`https://t.me/whacore`） |
| 演示站 | `https://whacore.cn` |

代码常量：`src/lib/site.ts` → `contacts`。

---

## 2. 官网信息架构

| 路径 | 目的 |
|------|------|
| `/` | 品牌 + 交付卖点 + 询价 |
| `/product` | 十大能力（运营视角） |
| `/solutions` | 运营模式（托管 / 自选，页内 pill）；旧路径 301 |
| `/contact` | 询价与交付；`/pricing` 301 至此 |
| `/faq` | 运营买家 FAQ |
| `/compliance` | 合规摘要 |
| `/changelog` | 产品进化（kind 分组 + sticky pill；正文可用 `<!--en-->`） |

技术：Astro SSG + Bun；视觉深色 `#0B0E11` + 金色 `#F0B90B`；sitemap / robots / canonical / OG / JSON-LD。

---

## 3. 内容目录 `content/`

```text
content/
  changelog/{decision,weekly,note}/   ← 与 Whapub 对齐的产品进化
  compliance/                         ← 页面口径短笔记（非法律全文）
```

根目录 [`compliance/`](../compliance/README.md) = **合规法律真源**（勿与 `content/compliance/` 混淆）。

产品进化 frontmatter：`date` / `kind` / `title` / `titleEn` / `summary` / `summaryEn` / `source`；正文中文在前，英文在 `<!--en-->` 后。文件名默认：`YYYY-MM-DD-{中文标题}.md`。

---

## 4. 与 Whapub 的产品进化同步

| 侧 | 路径 |
|----|------|
| 真源（写稿） | Whapub `marketing/changelog/{decision\|weekly\|note}/` |
| 渠道草稿 | Whapub `marketing/channels/` |
| 本站消费 | `content/changelog/{decision\|weekly\|note}/` |

流程：

1. WhalePub「官方发布」→ `marketing/changelog/{kind}/` → `git push`  
2. Whaint 服务器：`git pull` → `./start.sh start --build`  
3. 构建前 `scripts/sync-changelog.sh` sparse 拉取 Whapub `marketing/changelog/`

环境变量（`.env` / `.env.example`）：

| 变量 | 说明 |
|------|------|
| `WHAPUB_TOKEN` | 私有仓必填，可读 Whapub 的 GitHub PAT |
| `WHAPUB_REPO` | 默认 `https://github.com/oliver2023777/Whapub.git` |
| `WHAPUB_REF` | 默认 `main` |
| `SYNC_CHANGELOG` | 默认 `1`；`0` 关闭同步 |

本地：`bun run sync:changelog`。`content/changelog/` 是同步结果，勿当长期手改真源。`git pull` 若被未跟踪同步文件挡住，可先删冲突 `.md` 再拉。

---

## 5. SEO / GEO 实现细节

| 地址 | 作用 |
|------|------|
| `/llms.txt` | AI 索引：定位、链接、产品进化摘要、合规、联系 |
| `/llms-full.txt` | 稍长双语 briefing |
| `/sitemap-index.xml` | 站点地图 |
| `robots.txt` | 允许抓取；注明 llms |

- 生成：`src/lib/llmsTxt.ts`  
- 路由：`src/pages/llms.txt.ts`、`llms-full.txt.ts`  
- 绝对链接随 `PUBLIC_SITE_URL`  
- UTF-8 BOM + nginx `charset utf-8`，避免中文被按 GBK 误读  

公开仓根 [`README.md`](../README.md) 是 GitHub 侧产品简介（给爬虫 / LLM 的次级引用源）；**权威产品页仍以线上站为准**。

---

## 6. 可以说 / 不可以说

**可以说：** 完整源码、Docker、策略市场、交易员、套餐与服务费、托管模式、管理后台、不碰资金。  

**不可以说：** 稳赚、保本、日入、躺赚、资金盘/杀猪配套、暗示附带金融牌照、公开页写死「官网标价」（本站询价制）。

---

## 7. Agent 工作约定

1. 先读根 README（受众）+ 本文（流程）。  
2. 不要改 `../WhaleCore` 除非用户明确要求。  
3. 改联系方式只改 `src/lib/site.ts` → `contacts`。  
4. 改合规只改本仓 `compliance/`，再同步 `/compliance` 页。  
5. 产品进化真源在 Whapub；本仓只同步与展示。  
6. 页面口径短笔记放 `content/compliance/`。

本地：`bun install && bun run dev`（默认 http://127.0.0.1:4321）。构建：`bun run build`。

### 服务器

```bash
git clone https://github.com/oliver2023777/Whaint.git
cd Whaint
# 编辑 .env：PUBLIC_SITE_URL、WHAPUB_TOKEN（若 Whapub 仍为私有）等
./start.sh             # 构建并启动；固定端口 3080
./start.sh start --build   # Whapub 更新 changelog 后重建以同步
```

访问：`http://服务器IP:3080`。

---

## 8. 文献索引

| 主题 | 路径 |
|------|------|
| 对外产品介绍（公开 · 中） | [`README.md`](../README.md) |
| 对外产品介绍（公开 · 英） | [`README.en.md`](../README.en.md) |
| 合规真源 | [`compliance/`](../compliance/README.md) |
| 销售规范 | [`compliance/销售规范.md`](../compliance/销售规范.md) |
| 产品进化同步 | [`content/changelog/README.md`](../content/changelog/README.md) |
| 页面口径笔记 | [`content/compliance/`](../content/compliance/README.md) |
| LLM 索引实现 | [`src/lib/llmsTxt.ts`](../src/lib/llmsTxt.ts) |
| Whapub | `../WhalePub/README.md` |
| 产品能力（参考） | `../WhaleCore/README.md` |
| 互站商品文案（参考） | `../WhaleCore/docs/huzhan/v1-商品介绍.md` |
| 运营模式（参考） | `../WhaleCore/docs/guides/运营商模式.md` |
