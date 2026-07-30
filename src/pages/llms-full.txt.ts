import type { APIRoute } from 'astro';
import { buildLlmsFullTxt } from '../lib/llmsTxt';
import { site } from '../lib/site';

export const prerender = true;

export const GET: APIRoute = () => {
  const body = `\uFEFF${buildLlmsFullTxt(site.siteUrl)}`;
  return new Response(body, {
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
      'Cache-Control': 'public, max-age=3600',
    },
  });
};
