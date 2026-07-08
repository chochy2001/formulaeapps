import { describe, it, expect } from 'vitest';
import { translatePath } from '../../i18n/routes';

describe('translatePath', () => {
  describe('target locale: es', () => {
    it('returns root path for /', () => {
      expect(translatePath('/', 'es')).toBe('/');
    });

    it('returns /pro for /pro', () => {
      expect(translatePath('/pro', 'es')).toBe('/pro');
    });

    it('maps /free to /gratuita', () => {
      expect(translatePath('/free', 'es')).toBe('/gratuita');
    });

    it('maps /support to /soporte', () => {
      expect(translatePath('/support', 'es')).toBe('/soporte');
    });

    it('maps /privacy to /privacidad', () => {
      expect(translatePath('/privacy', 'es')).toBe('/privacidad');
    });

    it('maps /terms to /terminos', () => {
      expect(translatePath('/terms', 'es')).toBe('/terminos');
    });

    it('maps /en/free to /gratuita', () => {
      expect(translatePath('/en/free', 'es')).toBe('/gratuita');
    });

    it('maps /en/support to /soporte', () => {
      expect(translatePath('/en/support', 'es')).toBe('/soporte');
    });

    it('keeps /soporte as /soporte', () => {
      expect(translatePath('/soporte', 'es')).toBe('/soporte');
    });
  });

  describe('target locale: en', () => {
    it('returns /en for /', () => {
      expect(translatePath('/', 'en')).toBe('/en');
    });

    it('returns /en/pro for /pro', () => {
      expect(translatePath('/pro', 'en')).toBe('/en/pro');
    });

    it('maps /gratuita to /en/free', () => {
      expect(translatePath('/gratuita', 'en')).toBe('/en/free');
    });

    it('maps /soporte to /en/support', () => {
      expect(translatePath('/soporte', 'en')).toBe('/en/support');
    });

    it('maps /privacidad to /en/privacy', () => {
      expect(translatePath('/privacidad', 'en')).toBe('/en/privacy');
    });

    it('maps /terminos to /en/terms', () => {
      expect(translatePath('/terminos', 'en')).toBe('/en/terms');
    });

    it('maps /en/support to /en/support', () => {
      expect(translatePath('/en/support', 'en')).toBe('/en/support');
    });

    it('keeps /en/free as /en/free', () => {
      expect(translatePath('/en/free', 'en')).toBe('/en/free');
    });
  });

  describe('trailing slash handling', () => {
    it('strips trailing slash from root path for es target', () => {
      expect(translatePath('/', 'es')).toBe('/');
    });

    it('handles /soporte/ with trailing slash (es)', () => {
      expect(translatePath('/soporte/', 'es')).toBe('/soporte');
    });

    it('handles /en/support/ with trailing slash (en)', () => {
      expect(translatePath('/en/support/', 'en')).toBe('/en/support');
    });

    it('handles /en/free/ with trailing slash (es target)', () => {
      expect(translatePath('/en/free/', 'es')).toBe('/gratuita');
    });
  });

  describe('paths not in ROUTE_MAP', () => {
    it('keeps /pro for en target as /en/pro', () => {
      expect(translatePath('/pro', 'en')).toBe('/en/pro');
    });

    it('keeps /pro for es target as /pro', () => {
      expect(translatePath('/pro', 'es')).toBe('/pro');
    });

    it('keeps / for en target as /en', () => {
      expect(translatePath('/', 'en')).toBe('/en');
    });
  });

  describe('en-prefixed paths', () => {
    it('strips /en prefix when path is /en', () => {
      expect(translatePath('/en', 'es')).toBe('/');
    });

    it('strips /en prefix when path is /en/pro', () => {
      expect(translatePath('/en/pro', 'es')).toBe('/pro');
    });

    it('strips /en prefix when path is /en/', () => {
      expect(translatePath('/en/', 'es')).toBe('/');
    });
  });
});
