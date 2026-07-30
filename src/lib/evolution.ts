import fs from 'node:fs';
import path from 'node:path';

export type EvolutionKind = 'decision' | 'weekly' | 'note';

export type EvolutionPost = {
  slug: string;
  date: string;
  kind: EvolutionKind;
  title: string;
  titleEn: string;
  summary: string;
  summaryEn: string;
  source?: string;
  body: string;
};

const POSTS_DIR = path.join(process.cwd(), 'content/evolution/posts');

function parseFrontmatter(raw: string): { meta: Record<string, string>; body: string } {
  const trimmed = raw.replace(/^\uFEFF/, '');
  if (!trimmed.startsWith('---')) {
    return { meta: {}, body: trimmed.trim() };
  }
  const end = trimmed.indexOf('\n---', 3);
  if (end < 0) return { meta: {}, body: trimmed.trim() };
  const fm = trimmed.slice(3, end).trim();
  const body = trimmed.slice(end + 4).trim();
  const meta: Record<string, string> = {};
  for (const line of fm.split('\n')) {
    const i = line.indexOf(':');
    if (i < 0) continue;
    const key = line.slice(0, i).trim();
    let val = line.slice(i + 1).trim();
    if ((val.startsWith('"') && val.endsWith('"')) || (val.startsWith("'") && val.endsWith("'"))) {
      val = val.slice(1, -1);
    }
    meta[key] = val;
  }
  return { meta, body };
}

export function loadEvolutionPosts(): EvolutionPost[] {
  if (!fs.existsSync(POSTS_DIR)) return [];
  const files = fs
    .readdirSync(POSTS_DIR)
    .filter((f) => f.endsWith('.md') && !f.startsWith('_'))
    .sort()
    .reverse();

  return files.map((file) => {
    const raw = fs.readFileSync(path.join(POSTS_DIR, file), 'utf8');
    const { meta, body } = parseFrontmatter(raw);
    const slug = file.replace(/\.md$/, '');
    const kind = (meta.kind as EvolutionKind) || 'note';
    return {
      slug,
      date: meta.date || slug.slice(0, 10),
      kind,
      title: meta.title || slug,
      titleEn: meta.titleEn || meta.title || slug,
      summary: meta.summary || '',
      summaryEn: meta.summaryEn || meta.summary || '',
      source: meta.source,
      body,
    };
  });
}

export function kindLabel(kind: EvolutionKind, locale: 'zh' | 'en'): string {
  if (locale === 'en') {
    if (kind === 'decision') return 'Decision';
    if (kind === 'weekly') return 'Weekly';
    return 'Note';
  }
  if (kind === 'decision') return '决策日志';
  if (kind === 'weekly') return '周报';
  return '笔记';
}
