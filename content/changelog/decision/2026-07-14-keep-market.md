---
date: 2026-07-14
kind: decision
title: 用户不能自己做策略，为什么市场还开着
titleEn: Managed mode still shows the strategy market
summary: 托管隐藏工作室，但保留策略市场，让客户发现已公开的官方策略；配方靠服务端脱敏，不靠藏入口。
summaryEn: Managed mode hides the studio but keeps the market so buyers can discover official strategies—protection is server-side, not hidden nav.
source: ADR-0002
---

托管模式下用户本来就不能自己做策略。有人主张：入口能少就少，市场也藏掉，省事。另一种声音说：市场关了，新来的人连官方策略长什么样都看不见，等于自己切断货架。

对齐下来，决定保留市场，只关掉「自己动手改配方」的工作室。公开的是摘要，配方靠服务端守，不靠页面假装没有。

很多功能不是不能删，而是删掉以后，会把产品入口一起删掉。

<!--en-->

In managed mode, users cannot build strategies themselves. Some people wanted to hide the market too—“fewer doors, fewer problems.” Others said shutting the market means newcomers never see what official strategies look like; you cut your own shelf.

We kept the market and closed only the studio where people edit recipes. What is public is a summary; the recipe is guarded server-side, not by pretending the page does not exist.

Many features are not hard to delete. What is hard is deleting them without deleting the product entrance with them.
