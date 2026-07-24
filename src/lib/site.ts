/** 站点配置与联系常量（文案见 src/i18n/messages） */

export const site = {
  productName: 'WhaleCore',
  brandZh: '鲸擎',
  displayName: '鲸擎 · WhaleCore',
  brandName: 'WhaleCore',
  get siteUrl() {
    return import.meta.env.PUBLIC_SITE_URL || 'https://whalecore.example';
  },
  get appUrl() {
    return import.meta.env.PUBLIC_APP_URL || 'https://whacore.cn';
  },
  get contactEmail() {
    return import.meta.env.PUBLIC_CONTACT_EMAIL || 'hello@whalecore.example';
  },
} as const;

export const contacts = {
  qq: '613747777',
  telegram: '@whacore',
  telegramUrl: 'https://t.me/whacore',
  demoHost: 'whacore.cn',
  get demoUrl() {
    return site.appUrl;
  },
} as const;
