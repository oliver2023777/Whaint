/** 产品截图清单（文案在 i18n messages.showcase） */
export const screenshotIds = [
  'console',
  'market',
  'admin',
  'strategy',
  'trader-board',
  'traders',
  'billing',
  'intel',
  'positions',
] as const;

export type ScreenshotId = (typeof screenshotIds)[number];

export function screenshotSrc(id: ScreenshotId): string {
  return `/screenshots/${id}.png`;
}
