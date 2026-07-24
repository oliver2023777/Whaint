# Whaint · 营销站静态镜像
# 构建期注入 PUBLIC_*，运行期 nginx 托管 dist/

FROM oven/bun:1.2-alpine AS build
WORKDIR /app

COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

COPY . .

ARG PUBLIC_SITE_URL=https://whalecore.example
ARG PUBLIC_APP_URL=https://whacore.cn
ARG PUBLIC_CONTACT_EMAIL=hello@whalecore.example

ENV PUBLIC_SITE_URL=$PUBLIC_SITE_URL \
    PUBLIC_APP_URL=$PUBLIC_APP_URL \
    PUBLIC_CONTACT_EMAIL=$PUBLIC_CONTACT_EMAIL

RUN bun run build

FROM nginx:1.27-alpine
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1/health >/dev/null || exit 1
