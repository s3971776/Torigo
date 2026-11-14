-- Schema cho web Torigo. Chạy một lần trong Supabase: SQL Editor > New query > dán > Run.
-- Sau đó chạy seed.sql để nạp dữ liệu hiện có.

-- Người được phép sửa dữ liệu. Thêm email admin vào bảng này (xem cuối file).
create table if not exists admins (email text primary key);
alter table admins enable row level security; -- không có policy: chỉ SQL Editor / service role đọc ghi được

create or replace function is_admin() returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from admins where email = auth.jwt() ->> 'email');
$$;

-- Thông tin shop: một dòng duy nhất, nội dung nằm trong cột data
create table if not exists site_settings (
  id int primary key default 1 check (id = 1),
  data jsonb not null
);

create table if not exists services (
  id bigint generated always as identity primary key,
  slug text unique not null check (slug ~ '^[a-z0-9-]+$'),
  sort int not null default 0,
  name text not null,
  short text not null default '',
  description text not null default '',
  price text not null default '',      -- giá thấp nhất, hiện dạng "Từ …"
  photo text not null default '',      -- URL ảnh trong Storage hoặc tên file trong src/assets/photos
  cols jsonb,                          -- ["Loại ngựa đàn","Thay dây","Setup"] hoặc null
  rows jsonb not null default '[]',    -- [["Cơ bản","100.000"], …]
  notes jsonb,                         -- ["Chưa bao gồm linh kiện."] hoặc null
  callout jsonb                        -- {label,title,text,rows} hoặc null
);

create table if not exists gallery (
  id bigint generated always as identity primary key,
  sort int not null default 0,
  photo text not null,
  title text not null default '',
  service text references services (slug) on update cascade on delete set null
);

create table if not exists posts (
  id bigint generated always as identity primary key,
  slug text unique not null check (slug ~ '^[a-z0-9-]+$'),
  title text not null,
  description text not null default '',
  date date not null default current_date,
  service text references services (slug) on update cascade on delete set null,
  cover text not null default '',
  body text not null default '',       -- Markdown
  published boolean not null default true
);

-- Phân quyền: ai cũng đọc được (web công khai), chỉ admin được ghi.
alter table site_settings enable row level security;
alter table services enable row level security;
alter table gallery enable row level security;
alter table posts enable row level security;

create policy "doc cong khai" on site_settings for select using (true);
create policy "doc cong khai" on services for select using (true);
create policy "doc cong khai" on gallery for select using (true);
create policy "doc bai da dang" on posts for select using (published or is_admin());

create policy "admin ghi" on site_settings for all to authenticated using (is_admin()) with check (is_admin());
create policy "admin ghi" on services for all to authenticated using (is_admin()) with check (is_admin());
create policy "admin ghi" on gallery for all to authenticated using (is_admin()) with check (is_admin());
create policy "admin ghi" on posts for all to authenticated using (is_admin()) with check (is_admin());

-- Kho ảnh công khai, chỉ admin tải lên / xóa
insert into storage.buckets (id, name, public) values ('photos', 'photos', true) on conflict (id) do nothing;
create policy "admin tai anh" on storage.objects for insert to authenticated with check (bucket_id = 'photos' and is_admin());
create policy "admin sua anh" on storage.objects for update to authenticated using (bucket_id = 'photos' and is_admin());
create policy "admin xoa anh" on storage.objects for delete to authenticated using (bucket_id = 'photos' and is_admin());

-- VIỆC CẦN LÀM SAU KHI CHẠY FILE NÀY:
-- 1. Authentication > Users > Add user: tạo tài khoản admin (email + mật khẩu).
-- 2. Chạy lệnh sau với đúng email đó:
--      insert into admins (email) values ('email-cua-ban@vi-du.com');
