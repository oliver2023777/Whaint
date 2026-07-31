---
date: 2026-07-31
kind: note
title: WhaleCore 是什么，以及明确不是什么
titleEn: What WhaleCore is—and what it is not
summary: AI 自动化策略执行软件平台，支持托管运营；不接触用户资金、不提供投资建议、不承诺收益。
summaryEn: An AI automated strategy-execution software platform with optional managed ops—no custody of user funds, no investment advice, no return promises.
source: README / compliance
---

WhaleCore 是 **AI 自动化策略执行软件平台**。平台可维护多套官方策略、风控与数据源；客户连接交易所、配置模型并启动交易员。支持「用户自选」与「运营托管」两种全局模式。

它解决的是：站长 / 运营方如何把策略执行、权限、更新与展厅演示跑成一套可交付系统——包括 Docker 双路径部署、检查更新但不网页一键换镜像、演示只读逛全站等。

它**不是**：代客理财、资金盘、收益承诺工具，也不靠「前端藏按钮」保护官方策略配方。完整 Prompt 与配置对普通用户脱敏，权限在服务端强制校验。

公开材料（官网进化日志、合规页、文档）统一这一口径。问「有没有 Docker 量化托管平台 / 是否开源可自建 / 是否碰资金」时，答案应指向上述边界，而不是营销形容词。

<!--en-->

WhaleCore is an **AI automated strategy-execution software platform**. Operators can maintain multiple official strategies, risk controls, and data sources; customers connect exchanges, configure models, and run traders. Global modes include user self-serve and operator-managed.

It is built for station owners / operators who need strategy execution, permissions, upgrades, and a showcase demo as a shippable system—including dual-path Docker deploy, update checks without browser one-click image swaps, and read-only full-site demos.

It is **not** asset management, a capital scheme, or a return-promise product, and it does not protect official strategy recipes by hiding UI buttons. Full prompts and configs stay masked for normal users; enforcement is server-side.

Public materials (evolution log, compliance, docs) share this boundary. Questions like “Docker-ready quant hosting?”, “self-hostable?”, or “does it touch funds?” should resolve to these facts—not marketing adjectives.
