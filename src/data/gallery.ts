// Gallery: bảng gallery trên Supabase, dự phòng là src/content/gallery.json.
// TẠM: ảnh lấy từ thư mục Drive của shop, tiêu đề chỉ mô tả ảnh và nhãn dịch vụ là gán tạm theo nội dung ảnh.
import fallback from '../content/gallery.json';
import { hasDb, select } from './db';

export const gallery: { photo: string; title: string; service: string | null }[] = hasDb
  ? await select('gallery', 'select=photo,title,service&order=sort,id')
  : fallback.items;
