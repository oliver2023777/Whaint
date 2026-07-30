---
date: 2026-07-17
kind: decision
title: 全站只准跟一条策略，客户会跑
titleEn: We rejected a single forced strategy for everyone
summary: 平台维护多套官方策略供选择；不做全站强制单策略，也不做按套餐自动分配。
summaryEn: Multiple official strategies users can pick—no global forced strategy, no auto-assign by plan.
source: ADR-0001
---

托管刚起步时，我们差点全站只推一条官方策略。

有人觉得：一条线，运营省心，更新也快。另一种声音说：运营要同时跑多套官方线，客户也要选得动——绑死等于赶走一半人。还讨论过「按套餐自动塞策略」，算下来权益和策略缠死，客服先崩，一并砍掉。

最后否掉全局强制单策略。平台准备多套官方策略，用户自己挑；系统只确认有没有资格跟这条。官方要脱敏，权限要测——换来的是货架上能摆多条线。

省事方案常常不是在省事，是在把选择权从客户手里拿走。

<!--en-->

Early on we nearly forced one official strategy for the whole site.

One side wanted a single line—easier ops, faster updates. The other said operators need several official lines and customers need a real choice; locking everyone in drives half of them away. We also killed “auto-assign strategy by plan”—entitlements and strategies tangled, support would break first.

No global forced strategy. The platform offers several official strategies; users pick; the system only checks eligibility. Official recipes stay redacted; permissions get tested. The tradeoff is a shelf with more than one line.

“Simpler” often just means taking choice away from the customer.
