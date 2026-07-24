import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

const site = process.env.PUBLIC_SITE_URL || 'https://whalecore.example';

export default defineConfig({
  site,
  integrations: [sitemap()],
  redirects: {
    '/pricing': '/contact',
    '/en/pricing': '/en/contact',
    '/solutions/managed': '/solutions#managed',
    '/solutions/self': '/solutions#self',
    '/en/solutions/managed': '/en/solutions#managed',
    '/en/solutions/self': '/en/solutions#self',
  },
  i18n: {
    defaultLocale: 'zh',
    locales: ['zh', 'en'],
    routing: {
      prefixDefaultLocale: false,
    },
  },
});
