import { defineConfig } from 'vitest/config';
import path from 'path';

export default defineConfig({
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  test: {
    include: ['src/lib/__tests__/**/*.test.ts'],
    coverage: {
      provider: 'v8',
      include: ['src/consts.ts', 'src/i18n/**/*.ts'],
      exclude: ['src/lib/__tests__/**'],
    },
  },
});
