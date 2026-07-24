import { site } from './site';

export type PageSeo = {
  title: string;
  description: string;
  path: string;
  /** 覆盖 OG 类型，默认 website */
  ogType?: 'website' | 'article';
};

export function absoluteUrl(path: string): string {
  const base = site.siteUrl.replace(/\/$/, '');
  const p = path.startsWith('/') ? path : `/${path}`;
  return p === '/' ? `${base}/` : `${base}${p}`;
}

export function fullTitle(pageTitle: string): string {
  if (
    pageTitle === site.displayName ||
    pageTitle.startsWith(`${site.displayName} `) ||
    pageTitle.startsWith(`${site.displayName} ·`)
  ) {
    return pageTitle;
  }
  return `${pageTitle} · ${site.displayName}`;
}
