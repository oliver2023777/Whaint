/** 极简 Markdown → HTML（覆盖本站 content/ 所用子集） */
export function marked(src: string): string {
  const lines = src.replace(/\r\n/g, '\n').split('\n');
  const out: string[] = [];
  let listType: 'ul' | 'ol' | null = null;

  const flushList = () => {
    if (listType) {
      out.push(listType === 'ul' ? '</ul>' : '</ol>');
      listType = null;
    }
  };

  const openList = (type: 'ul' | 'ol') => {
    if (listType !== type) {
      flushList();
      out.push(type === 'ul' ? '<ul>' : '<ol>');
      listType = type;
    }
  };

  const inline = (text: string) =>
    text
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')
      .replace(/`([^`]+)`/g, '<code>$1</code>');

  for (const line of lines) {
    const trimmed = line.trim();
    if (!trimmed) {
      flushList();
      continue;
    }
    if (trimmed.startsWith('# ')) {
      flushList();
      out.push(`<h1>${inline(trimmed.slice(2))}</h1>`);
      continue;
    }
    if (trimmed.startsWith('## ')) {
      flushList();
      out.push(`<h2>${inline(trimmed.slice(3))}</h2>`);
      continue;
    }
    if (trimmed.startsWith('- ')) {
      openList('ul');
      out.push(`<li>${inline(trimmed.slice(2))}</li>`);
      continue;
    }
    const ordered = trimmed.match(/^(\d+)\.\s+(.*)$/);
    if (ordered) {
      openList('ol');
      out.push(`<li>${inline(ordered[2])}</li>`);
      continue;
    }
    flushList();
    out.push(`<p>${inline(trimmed)}</p>`);
  }
  flushList();
  return out.join('\n');
}
