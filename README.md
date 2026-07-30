# Whaint · WhaleCore 营销站工作区

> **本仓库用途**：为 **WhaleCore** 建设 **SEO / GEO 导向的官方营销站**。  
> **受众**：**站长 / 运营团队**（买源码、自建可收费平台）——**不是**拉终端交易用户来注册炒币。  
> **与 WhaleCore 产品仓隔离**：不要在本目录改交易后台代码；产品真源仍在旁边的 `WhaleCore` 仓。

新开 Cursor / Agent 对话时：**先读本文**，再动手写站或写文案。

---

## 1. 三个目录怎么配合

| 路径 | 角色 |
|------|------|
| `/Users/oliver/Downloads/xm/WhaleCore` | 产品仓（交易平台、策略工作室、部署包） |
| `/Users/oliver/Downloads/xm/Whaint` | **本仓**：对外营销站（询价、合规、SEO/GEO） |
| `/Users/oliver/Downloads/xm/WhalePub`（远程 [Whapub](https://github.com/oliver2023777/Whapub)） | 内容工厂：小红书等渠道草稿 + **官网产品进化**干净稿 |

- 营销站用**独立域名 / 独立部署**（方案 B，已拍板）。  
- **主 CTA：询价购买** → `/contact`；次 CTA：看演示站 `https://whacore.cn`。  
- **不要**把交易所 Key、策略 Prompt 配进营销站。  
- 公开文案口径必须对齐本仓 [`compliance/`](compliance/README.md)，禁止另写第二套「稳赚」话术。  
- 卖点素材可参考 `../WhaleCore/docs/huzhan/`，勿另造冲突卖点。

### 联系方式真源（写死）

| 渠道 | 值 |
|------|-----|
| QQ | `613747777` |
| Telegram / 飞机 | `@whacore`（`https://t.me/whacore`） |
| 产品 / 演示站 | `https://whacore.cn` |

代码常量：`src/lib/site.ts` → `contacts`。

---

## 2. 产品一句话（官网可用 · 卖给运营）

**WhaleCore 是可对外运营的 AI 量化托管平台（完整源码）**：你维护官方策略与套餐；终端用户自连交易所与 AI 模型并启停交易员。

平台 **不接触用户资金、不提供投资建议、不承诺收益**。对外运营资质由买家自理。

### 我们是什么 / 不是什么（对外必须一致）

**是：**

- 可收费运营的软件平台（策略市场、交易员、套餐、服务费、管理后台）  
- 完整源码 + Docker 一键部署  
- 支持「用户自选 / 运营托管」两种模式后台切换  
- 终端用户自主账户：交易所 API、模型 Key、资金与启停自管  

**不是：**

- 证券公司 / 银行 / 支付机构 / 持牌金融机构  
- 代客理财、配资、资金托管、「盘口」  
- 收益担保、投资顾问、「稳赚」工具  
- 「拉个人来体验 AI 炒币」的 C 端获客站（那是演示站角色，不是本站主转化）  

完整真源：

- 本仓 [`compliance/`](compliance/README.md)（营销站合规口径）  
- 本仓 [`README.md`](README.md)（受众 / 转化 / 信息架构）  
- 可参考：`../WhaleCore/docs/huzhan/v1-商品介绍.md`（卖点素材，非合规真源）

---

## 3. 官网信息架构

### 转化

| 优先级 | 动作 |
|--------|------|
| 主 | 询价与交付 → `/contact`（QQ / TG） |
| 次 | 看演示站 → `whacore.cn` |

### 页面

| 路径 | 目的 |
|------|------|
| `/` | 卖给运营的品牌 + 交付卖点 + 询价 |
| `/product` | 十大能力（运营视角） |
| `/solutions` | 运营模式（托管 / 自选，页内 pill 切换）；旧路径 301 至此 |
| `/contact` | 询价与交付（交付 / 边界 / QQ·TG·演示站）；`/pricing` 301 至此 |
| `/faq` | 运营买家 FAQ |
| `/compliance` | 合规摘要 |
| `/changelog` | **产品进化**：决策日志 / 周报（按 kind 分组 + sticky pill）；中英标题摘要，正文可用 `<!--en-->` 双语 |

### 技术偏好

- Astro SSG + Bun；一期无 CMS  
- 视觉：深色底 `#0B0E11` + 金色 `#F0B90B`  
- sitemap / robots / canonical / OG / JSON-LD  

---

## 4. 内容目录（本仓 `content/`）

```text
content/
  changelog/                 ← 官网产品进化（与 Whapub 对齐）
    decision/                ← 决策日志
    weekly/                  ← 周报精选
    note/                    ← 其它
  compliance/                ← 页面口径短笔记（非法律全文）
    README.md · product.md · pricing.md · contact.md · solutions-*.md
```

根目录 [`compliance/`](compliance/README.md) = **合规法律真源**（勿与 `content/compliance/` 混淆）。

产品进化条目 frontmatter：`date` / `kind` / `title` / `titleEn` / `summary` / `summaryEn` / `source`；正文中文在前，英文在 `<!--en-->` 之后。文件名默认 **中文主标题**：`YYYY-MM-DD-{中文标题}.md`。

---

## 5. 与 Whapub 的产品进化同步

| 侧 | 路径 |
|----|------|
| 真源（写稿） | Whapub `marketing/changelog/{decision\|weekly\|note}/` |
| 渠道草稿 | Whapub `marketing/channels/`（小红书 daily/decision/weekly 等） |
| 本站消费 | `content/changelog/{decision\|weekly\|note}/` |

流程：

1. 在 **WhalePub** 说「官方发布」→ 写入 `marketing/changelog/{kind}/`（中文文件名）→ `git push`  
2. 在 **Whaint 服务器**：`git pull`（若有新站代码）→ `./start.sh start --build`  
3. 构建前 `scripts/sync-changelog.sh` 会 sparse 拉取 Whapub 的 `marketing/changelog/`，保持同类目录结构  

环境变量（`.env` / `.env.example`）：

| 变量 | 说明 |
|------|------|
| `WHAPUB_TOKEN` | 私有仓必填，可读 Whapub 的 GitHub PAT |
| `WHAPUB_REPO` | 默认 `https://github.com/oliver2023777/Whapub.git` |
| `WHAPUB_REF` | 默认 `main` |
| `SYNC_CHANGELOG` | 默认 `1`；设 `0` 可关闭同步 |

本地只同步：`bun run sync:changelog`。  
说明：`content/changelog/` 是同步结果；勿当长期手改真源。`git pull` 若被未跟踪的同步文件挡住，可先删掉冲突的 `.md` 再拉。

---

## 6. SEO / GEO · 给 LLM 看的索引

| 地址 | 作用 |
|------|------|
| [`/llms.txt`](https://llmstxt.org/) | AI 爬虫精简索引：定位、产品链接、**每篇产品进化中英摘要**、合规锚点、联系 |
| `/llms-full.txt` | 稍长的中英双语 briefing |
| `/sitemap-index.xml` | 常规站点地图 |
| `robots.txt` | 允许抓取；注明 llms 索引 |

- 文案生成：`src/lib/llmsTxt.ts`（摘要来自 `loadEvolutionPosts()`）  
- 路由：`src/pages/llms.txt.ts`、`llms-full.txt.ts`  
- 绝对链接随 `PUBLIC_SITE_URL`  
- 响应带 `charset=utf-8` + UTF-8 BOM；Docker nginx 对 `.txt` 强制 UTF-8，避免中文被按 GBK 误读  

其它 SEO 约定：每页唯一 title / description / H1；冲「AI 量化托管源码 / 运营平台」类词；**禁止**稳赚话术与内部 SEO 黑话上公开页。

---

## 7. 可以说 / 不可以说

**可以说：** 完整源码、Docker、策略市场、交易员、套餐与服务费、托管模式、管理后台、不碰资金。  

**不可以说：** 稳赚、保本、日入、躺赚、资金盘/杀猪配套、暗示附带金融牌照。  

---

## 8. Agent 工作约定

1. **先读本文**；受众默认是运营买家。  
2. **不要修改** `../WhaleCore` 除非用户明确要求。  
3. 改联系方式只改 `src/lib/site.ts` 的 `contacts`，再同步本文表格。  
4. 改合规口径只改本仓 `compliance/`，再同步 `/compliance` 页。  
5. 产品进化真源在 **Whapub**；本仓只同步与展示。渠道日更/决策草稿也在 Whapub `marketing/channels/`。  
6. 页面口径短笔记放 `content/compliance/`；组件保持干净。  

本地：`bun install && bun run dev`（默认 http://127.0.0.1:4321）。构建：`bun run build`。

### 服务器（推荐）

```bash
git clone https://github.com/oliver2023777/Whaint.git
cd Whaint
# 编辑 .env：PUBLIC_SITE_URL、WHAPUB_TOKEN（私有 Whapub）等
./start.sh             # 构建并启动；固定端口 3080
./start.sh start --build   # Whapub 更新 changelog 后重建以同步
```

访问：`http://服务器IP:3080`。

---

## 9. 文献索引

| 主题 | 路径 |
|------|------|
| 合规（本仓真源） | [`compliance/`](compliance/README.md) |
| 销售规范 | [`compliance/销售规范.md`](compliance/销售规范.md) |
| 产品进化同步说明 | [`content/changelog/README.md`](content/changelog/README.md) |
| 页面口径笔记 | [`content/compliance/`](content/compliance/README.md) |
| LLM 索引实现 | [`src/lib/llmsTxt.ts`](src/lib/llmsTxt.ts) |
| Whapub 内容工厂 | `../WhalePub/README.md` |
| 产品能力（参考） | `../WhaleCore/README.md` |
| 互站商品文案（参考） | `../WhaleCore/docs/huzhan/v1-商品介绍.md` |
| 闲鱼 / 小红书短话术 | `../WhaleCore/docs/huzhan/渠道短话术-闲鱼小红书.md` |
| 运营模式（参考） | `../WhaleCore/docs/guides/运营商模式.md` |
