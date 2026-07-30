---
date: 2026-07-22
kind: decision
title: 客服说一套、对外页说一套，比少写文档更危险
titleEn: Conflicting copy is worse than writing less
summary: 合规口径收成唯一真源；对外页、客服、互站只准引用这一处。
summaryEn: One compliance source of truth—site, support, and listings must cite the same docs.
source: ADR-0006
---

合规口径散落各处的时候，我们差点继续「各写各的」。

有人主张只在互站写一长篇授权与禁止，省事。有人想全塞进 README。还有人幻想靠技术锁死交付物防滥用。三条都否了：会变第二真源、README 过载；完整源码也锁不死。

最后收成同一套合规文档，对外页、客服、互站只准引用这一处。定位写死：策略执行软件平台，可做托管；不碰用户资金、不提供投资建议、不承诺收益。

原因只有一个——口径打架时，拒不了单，也说不清边界。少写几篇不可怕，各说各话才可怕。

<!--en-->

When compliance copy lived in many places, we almost kept writing separately.

Some wanted one long “license and bans” post on listing sites. Some wanted everything in the README. Some hoped tech locks would stop abuse. All three failed: second sources of truth, README overload, and full source you cannot truly lock down.

We collapsed to one compliance set. Site, support, and listings may only cite that. Positioning is fixed: a strategy-execution software platform that can run custody modes—no holding user funds, no investment advice, no return promises.

One reason: when copy conflicts, you cannot refuse bad deals or explain the boundary. Writing less is fine. Talking past each other is not.
