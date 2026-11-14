// Thông tin shop: bảng site_settings trên Supabase, dự phòng là src/content/site.json.
// Lưu ý: giờ mở cửa hiện là giả định, cần shop xác nhận.
import fallback from '../content/site.json';
import { hasDb, select } from './db';

const data: typeof fallback = hasDb ? ((await select('site_settings', 'id=eq.1&select=data'))[0]?.data ?? fallback) : fallback;

export const site = {
  ...data,
  // hours: [["Thứ 2 – Thứ 6","9:00 – 19:00"], …]; file dự phòng dùng dạng {days,time}
  hours: (data.hours as any[]).map((h) => (Array.isArray(h) ? h : [h.days, h.time]) as string[]),
};
