import type { APIRoute } from 'astro';
import { buildLlmsFullTxt } from '../lib/llmsTxt';
import { site } from '../lib/site';

export const prerender = true;

export const GET: APIRoute = () =>
  new Response(buildLlmsFullTxt(site.siteUrl), {
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
      'Cache-Control': 'public, max-age=3600',
    },
  });
