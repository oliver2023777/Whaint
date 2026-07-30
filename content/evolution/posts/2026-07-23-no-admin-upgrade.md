---
date: 2026-07-23
kind: decision
title: 后台点一下就升级？我们故意没做
titleEn: We refused one-click upgrades from the admin UI
summary: 后台只提示有更新；真正换版本在宿主机执行固定命令，保留数据可控。
summaryEn: Admin only notifies; hosts run a fixed upgrade command so data and process stay under control.
source: ADR-0007
---

升级怎么做，我们差点选了最「爽」的那条：后台一个按钮，系统自己换掉。

有人主张管理端直接换镜像，客户零操作。另一种声音说：网页或容器里动宿主机 Docker，安全风险高，盘中交易也可能被拽停。静默自动升、以及新装和升级拆成两套命令——前者控不住环境，后者徒增认知成本，都否了。

最后：后台只提示有更新；真正换版本到服务器跑固定安装 / 升级命令。发版地址不对网页暴露。

原因很具体——从网页里直接动服务器，出事了谁都拦不住。少一个神奇按钮，有时是在多留一点可控。
