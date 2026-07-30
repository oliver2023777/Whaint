import type { APIRoute } from 'astro';
import { buildLlmsTxt } from '../lib/llmsTxt';
import { site } from '../lib/site';

export const prerender = true;

export const GET: APIRoute = () => {
  // BOM helps Windows editors detect UTF-8 when charset is ignored
  const body = `\uFEFF${buildLlmsTxt(site.siteUrl)}`;
  return new Response(body, {
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
      'Cache-Control': 'public, max-age=3600',
    },
  });
};
