import { messages, type Locale, type Messages } from './messages';

export type { Locale, Messages };
export { messages };

export const defaultLocale: Locale = 'zh';
export const locales: Locale[] = ['zh', 'en'];

export const localeLabels: Record<Locale, string> = {
  zh: '中文',
  en: 'EN',
};

export function isLocale(value: string | undefined | null): value is Locale {
  return value === 'zh' || value === 'en';
}

export function getLocale(current: string | undefined | null): Locale {
  return isLocale(current) ? current : defaultLocale;
}

export function getMessages(locale: string | undefined | null): Messages {
  return messages[getLocale(locale)];
}

/** Remove trailing slash except root; normalize empty to `/`. */
export function normalizePath(pathname: string): string {
  if (!pathname || pathname === '/') return '/';
  const trimmed = pathname.replace(/\/+$/, '');
  return trimmed || '/';
}

/** Strip `/en` prefix → locale-agnostic path. */
export function stripLocale(pathname: string): string {
  const p = normalizePath(pathname);
  if (p === '/en') return '/';
  if (p.startsWith('/en/')) return normalizePath(p.slice(3));
  return p;
}

/** Prefixed path for a locale (`zh` has no prefix). */
export function localizePath(path: string, locale: Locale): string {
  const bare = stripLocale(path);
  if (locale === defaultLocale) return bare;
  return bare === '/' ? `/${locale}` : `/${locale}${bare}`;
}

export function switchLocalePath(pathname: string, target: Locale): string {
  return localizePath(stripLocale(pathname), target);
}

export function localeFromPath(pathname: string): Locale {
  const p = normalizePath(pathname);
  if (p === '/en' || p.startsWith('/en/')) return 'en';
  return 'zh';
}
