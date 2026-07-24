# Whaint · WhaleCore 营销站工作区

> **本仓库用途**：为 **WhaleCore** 建设 **SEO / GEO 导向的官方营销站**。  
> **受众**：**站长 / 运营团队**（买源码、自建可收费平台）——**不是**拉终端交易用户来注册炒币。  
> **与 WhaleCore 产品仓隔离**：不要在本目录改交易后台代码；产品真源仍在旁边的 `WhaleCore` 仓。

新开 Cursor / Agent 对话时：**先读本文**，再动手写站或写文案。

---

## 1. 两个目录怎么配合

| 路径 | 角色 |
|------|------|
| `/Users/oliver/Downloads/xm/WhaleCore` | 产品仓（交易平台、策略工作室、部署包；可参考互站商品文案） |
| `/Users/oliver/Downloads/xm/Whaint` | **本仓**：对外营销站（卖源码给运营、SEO、GEO、询价落地、**合规真源**） |

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

## 3. 官网已定方案摘要

### 转化

| 优先级 | 动作 |
|--------|------|
| 主 | 询价与授权 → `/contact`（QQ / TG） |
| 次 | 看演示站 → `whacore.cn` |

### 首期信息架构

| 路径 | 目的 |
|------|------|
| `/` | 卖给运营的品牌 + 交付卖点 + 询价 |
| `/product` | 十大能力（运营视角） |
| `/solutions` | 运营模式（托管 / 自选，页内切换）；旧路径 301 至此 |
| `/contact` | 询价与授权（交付 / 边界 / QQ·TG·演示站）；`/pricing` 301 至此 |
| `/faq` | 运营买家 FAQ |
| `/compliance` | 合规摘要 |

### 技术偏好

- Astro SSG；一期无 CMS  
- 视觉：深色底 `#0B0E11` + 金色 `#F0B90B`  
- sitemap / robots / canonical / OG / JSON-LD  

### SEO / GEO

1. 每页唯一 title / description / H1  
2. 首页与产品页含可引用定义块  
3. 冲「AI 量化托管源码 / 运营平台」类词；**禁止**稳赚话术  
4. 禁止把内部 SEO 黑话写进公开页  

---

## 4. 可以说 / 不可以说

**可以说：** 完整源码、Docker、策略市场、交易员、套餐与服务费、托管模式、管理后台、不碰资金。  

**不可以说：** 稳赚、保本、日入、躺赚、资金盘/杀猪配套、暗示附带金融牌照。  

---

## 5. Agent 工作约定

1. **先读本文**；受众默认是运营买家。  
2. **不要修改** `../WhaleCore` 除非用户明确要求。  
3. 改联系方式只改 `src/lib/site.ts` 的 `contacts`，再同步本文表格。  
4. 改合规口径只改本仓 `compliance/`，再同步 `/compliance` 页。  
5. 长文放 `content/`；组件保持干净。  

本地：`bun install && bun run dev`；构建：`bun run build`。

---

## 6. 文献索引

| 主题 | 路径 |
|------|------|
| 合规（本仓真源） | [`compliance/`](compliance/README.md) |
| 销售规范 | [`compliance/销售规范.md`](compliance/销售规范.md) |
| 产品能力（参考） | `../WhaleCore/README.md` |
| 互站商品文案（参考） | `../WhaleCore/docs/huzhan/v1-商品介绍.md` |
| 运营模式（参考） | `../WhaleCore/docs/guides/运营商模式.md` |
