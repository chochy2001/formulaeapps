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
      // Narrow include: marketing consts + i18n only (not full Astro UI).
      // CI prints honest LF/LH for this set — do not treat as whole-app %.
      reporter: ['text', 'lcov'],
      reportsDirectory: './coverage',
      include: ['src/consts.ts', 'src/i18n/**/*.ts'],
      exclude: ['src/lib/__tests__/**'],
    },
  },
});
