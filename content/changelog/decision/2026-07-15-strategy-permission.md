---
date: 2026-07-15
kind: decision
title: 策略配方要是漏出去，平台还怎么卖
titleEn: Hiding a button is not a security model
summary: 策略归属与可见性一律服务端校验；对外只给摘要，不把完整配置交给浏览器「假装不展示」。
summaryEn: Strategy access is enforced server-side—public users get summaries only, never full configs in the browser.
source: ADR-0003
---

藏按钮不算安全。

做托管最怕一件事——官方策略的完整配方被普通人拿走。有人觉得前端把入口藏掉就行，看不见就不会碰。另一种声音更硬：请求可以伪造；把完整配置塞给浏览器再「不展示」，等于主动泄密。

我们否决了「仅前端隐藏」和「完整配置交给前端」。原因只有一个：看不见 ≠ 拿不到。策略归谁、能不能改、能不能公开，一律服务端判定；对外只给摘要。

代价是权限要测全。体验可以藏按钮，生意得守配方。

<!--en-->

Hiding a button is not security.

The worst outcome in custody mode is leaking a full official strategy recipe. Some people thought hiding the UI was enough—if you cannot see it, you will not touch it. The harder view: requests can be forged; shipping the full config to the browser and “not showing” it is an active leak.

We rejected “front-end only hide” and “give the browser the full config.” Invisible is not unreachable. Ownership, edit rights, and publish rights are decided server-side; outsiders get summaries only.

The cost is thorough permission tests. UX can hide buttons. The business must guard the recipe.
