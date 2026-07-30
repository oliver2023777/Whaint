---
date: 2026-07-19
kind: decision
title: 客户机器有的很强、有的很弱，我们不敢只留一种装法
titleEn: Strong and weak hosts need two install paths
summary: 源码现场构建与镜像包导入双路径并存，按环境选，不互相覆盖。
summaryEn: Source build and image-pack import both exist—pick by host, never overwrite each other.
source: ADR-0004
---

客户机器差很大：有的服务器能直接 Docker 构建，有的不行。

只留镜像包，高配客户流程烦。只留服务器现场编译，低配机器用不了。更危险的是用打包脚本覆盖根目录启动入口——入口冲突，容易误操作。

所以做成双路径：高配走源码侧一键构建启动；低配本机打包装服务器再导入。两套说明都要维护，但这是代价。

原因只有一个——交付物要能装上，而不是只在一种理想机器上好看。

<!--en-->

Customer hosts vary wildly: some can Docker-build on the server; some cannot.

Image-pack only annoys strong hosts. On-server compile only fails on weak ones. Worse: a pack script overwriting the root start entry—conflicting entrypoints, easy mistakes.

So we keep two paths: strong hosts build and start from source; weak hosts pack locally, upload, and import. Two guides to maintain—that is the cost.

One reason only: the delivery must install, not merely look good on an ideal machine.
