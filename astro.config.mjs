// @ts-check
import { defineConfig } from 'astro/config';

import tailwindcss from '@tailwindcss/vite';

// https://astro.build/config
export default defineConfig({
  // Cho phép tối ưu ảnh tải lên Supabase Storage
  image: { remotePatterns: [{ protocol: 'https', hostname: '**.supabase.co' }] },
  vite: {
    plugins: [tailwindcss()]
  }
});