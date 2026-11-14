// Tra ảnh. Nhận ba dạng:
//  - URL https (ảnh tải lên Supabase Storage qua trang admin)
//  - tên trần "09643" hoặc đường dẫn "/src/assets/photos/09643.jpg" (ảnh nằm trong src/assets/photos)
import { inferRemoteSize } from 'astro:assets';

const files = import.meta.glob<{ default: ImageMetadata }>('../assets/photos/*.{jpg,jpeg,png,webp,JPG,JPEG,PNG}', { eager: true });
const key = (p: string) => p.split('/').pop()!.replace(/\.\w+$/, '');
const byName = Object.fromEntries(Object.entries(files).map(([p, m]) => [key(p), m.default]));

// Trả về props để rải vào <Image {...img.props} /> hoặc getImage(), kèm kích thước gốc.
export async function photo(id: string) {
  if (/^https?:\/\//.test(id)) {
    const { width, height } = await inferRemoteSize(id);
    return { props: { src: id, width, height }, width, height };
  }
  const img = byName[key(id)];
  if (!img) throw new Error(`Không tìm thấy ảnh "${id}" trong src/assets/photos`);
  return { props: { src: img }, width: img.width, height: img.height };
}
