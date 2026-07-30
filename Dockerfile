# Whaint · 营销站静态镜像
# 构建期注入 PUBLIC_*，运行期 nginx 托管 dist/
# 默认构建前从 Whapub 同步 marketing/changelog → content/changelog/{kind}/

FROM oven/bun:1.2-alpine AS build
WORKDIR /app

RUN apk add --no-cache git

COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

COPY . .

ARG PUBLIC_SITE_URL=https://whaint.cn
ARG PUBLIC_APP_URL=https://whacore.cn
ARG PUBLIC_CONTACT_EMAIL=hello@whalecore.example

# 产品进化同步（Whapub）
ARG SYNC_CHANGELOG=1
ARG WHAPUB_REPO=https://github.com/oliver2023777/Whapub.git
ARG WHAPUB_REF=main
# private 仓构建时传入：--build-arg WHAPUB_TOKEN=…
ARG WHAPUB_TOKEN=
# 每次构建传入新值，避免「Whapub 已更新但本层被 Docker 缓存」
ARG CACHEBUST=1

ENV PUBLIC_SITE_URL=$PUBLIC_SITE_URL \
    PUBLIC_APP_URL=$PUBLIC_APP_URL \
    PUBLIC_CONTACT_EMAIL=$PUBLIC_CONTACT_EMAIL \
    WHAPUB_REPO=$WHAPUB_REPO \
    WHAPUB_REF=$WHAPUB_REF \
    WHAPUB_TOKEN=$WHAPUB_TOKEN

RUN echo "cachebust=${CACHEBUST}" \
 && if [ "$SYNC_CHANGELOG" = "1" ]; then bun run sync:changelog; fi \
 && bun run build

FROM nginx:1.27-alpine
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1/health >/dev/null || exit 1
