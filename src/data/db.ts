// Đọc dữ liệu từ Supabase (Postgres) qua REST lúc build. Chỉ đọc; ghi nằm ở trang /admin/.
// Chưa cấu hình .env thì hasDb = false và web dùng dữ liệu dự phòng trong src/content.
// ponytail: dữ liệu nạp một lần khi module được tải. Sửa trong admin xong cần build lại
// (hoặc khởi động lại `astro dev`) để web thấy. Cần dữ liệu tức thời thì chuyển sang SSR.
const url = import.meta.env.PUBLIC_SUPABASE_URL;
const key = import.meta.env.PUBLIC_SUPABASE_ANON_KEY;

export const hasDb = Boolean(url && key);

export async function select<T = any>(table: string, query = 'select=*'): Promise<T[]> {
  const res = await fetch(`${url}/rest/v1/${table}?${query}`, {
    headers: { apikey: key, Authorization: `Bearer ${key}` },
  });
  if (!res.ok) throw new Error(`Supabase: đọc bảng ${table} lỗi ${res.status}: ${await res.text()}`);
  return res.json();
}
