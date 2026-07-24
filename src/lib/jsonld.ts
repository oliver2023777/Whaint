import { getMessages, localizePath, type Locale } from '../i18n';
import { site } from './site';

export function organizationJsonLd(locale: Locale = 'zh') {
  const t = getMessages(locale);
  return {
    '@context': 'https://schema.org',
    '@type': 'Organization',
    name: site.displayName,
    url: site.siteUrl,
    description: t.meta.tagline,
    email: site.contactEmail,
  };
}

export function softwareApplicationJsonLd(locale: Locale = 'zh') {
  const t = getMessages(locale);
  const contactPath = localizePath('/contact', locale);
  return {
    '@context': 'https://schema.org',
    '@type': 'SoftwareApplication',
    name: site.displayName,
    applicationCategory: 'BusinessApplication',
    operatingSystem: 'Web',
    description: t.meta.tagline,
    url: site.siteUrl,
    offers: {
      '@type': 'Offer',
      url: `${site.siteUrl.replace(/\/$/, '')}${contactPath === '/' ? '' : contactPath}`,
      priceCurrency: 'CNY',
      availability: 'https://schema.org/InStock',
    },
  };
}

export function faqPageJsonLd(items: { question: string; answer: string }[]) {
  return {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: items.map((item) => ({
      '@type': 'Question',
      name: item.question,
      acceptedAnswer: {
        '@type': 'Answer',
        text: item.answer,
      },
    })),
  };
}
