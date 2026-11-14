// Dịch vụ & bảng giá: bảng services trên Supabase, dự phòng là src/content/services.json.
// rows: cột đầu là tên hạng mục, các cột sau là giá. cols: tiêu đề cột (chỉ cần khi có nhiều hơn 1 cột giá).
import fallback from '../content/services.json';
import { hasDb, select } from './db';

export type Service = {
  slug: string;
  name: string;
  short: string;
  desc: string;
  price: string;
  photo: string;
  cols?: string[] | null;
  rows: string[][];
  notes?: string[] | null;
  callout?: { label?: string; title?: string; text?: string; rows?: string[][] | null } | null;
};

// File dự phòng lưu mỗi dòng dạng {cells:[…]}; Supabase lưu thẳng mảng.
const cells = (rows?: any[] | null) => rows?.map((r) => (Array.isArray(r) ? r : r.cells) as string[]);

const raw: any[] = hasDb
  ? (await select('services', 'select=*&order=sort,id')).map((s) => ({ ...s, desc: s.description }))
  : fallback.services;

export const services: Service[] = raw.map((s) => ({
  ...s,
  rows: cells(s.rows) ?? [],
  callout: s.callout && { ...s.callout, rows: cells(s.callout.rows) },
}));

export const serviceBySlug = Object.fromEntries(services.map((s) => [s.slug, s]));
