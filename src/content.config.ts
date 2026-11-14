import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import type { Loader } from 'astro/loaders';
import { z } from 'astro/zod';
import { hasDb, select } from './data/db';

// Bài blog lấy từ bảng posts trên Supabase; nội dung Markdown được dựng thành HTML lúc build.
const supabasePosts: Loader = {
  name: 'supabase-posts',
  async load({ store, parseData, renderMarkdown }) {
    store.clear();
    for (const p of await select('posts', 'select=*&published=is.true')) {
      const data = await parseData({
        id: p.slug,
        data: { title: p.title, description: p.description, date: p.date, service: p.service ?? '', cover: p.cover },
      });
      store.set({ id: p.slug, data, body: p.body, rendered: await renderMarkdown(p.body) });
    }
  },
};

const blog = defineCollection({
  // Chưa cấu hình Supabase thì dùng các file Markdown dự phòng
  loader: hasDb ? supabasePosts : glob({ pattern: '*.md', base: './src/content/blog' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    date: z.coerce.date(),
    service: z.string(), // slug dịch vụ liên quan, dùng cho CTA cuối bài
    cover: z.string(), // ảnh bìa: URL hoặc tên file trong src/assets/photos
  }),
});

export const collections = { blog };
