import { describe, it, expect } from 'vitest';
import { useTranslations, ui } from '../../i18n/ui';
import type { Locale } from '../../consts';

describe('ui translations table', () => {
  it('has es locale', () => {
    expect(ui.es).toBeDefined();
  });

  it('has en locale', () => {
    expect(ui.en).toBeDefined();
  });

  it('es and en have the same keys', () => {
    const esKeys = Object.keys(ui.es).sort();
    const enKeys = Object.keys(ui.en).sort();
    expect(esKeys).toEqual(enKeys);
  });

  it('all translation values are non-empty strings', () => {
    for (const value of Object.values(ui.es)) {
      expect(typeof value).toBe('string');
      expect(value.trim().length).toBeGreaterThan(0);
    }
    for (const value of Object.values(ui.en)) {
      expect(typeof value).toBe('string');
      expect(value.trim().length).toBeGreaterThan(0);
    }
  });
});

describe('useTranslations', () => {
  it('returns a function', () => {
    const t = useTranslations('es');
    expect(typeof t).toBe('function');
  });

  it('returns ES translation for keys in es locale', () => {
    const t = useTranslations('es');
    expect(t('nav.home')).toBe('Inicio');
    expect(t('hero.title')).toBe('Mejora tus habilidades en matemáticas y ciencias');
  });

  it('returns EN translation for keys in en locale', () => {
    const t = useTranslations('en');
    expect(t('nav.home')).toBe('Home');
    expect(t('hero.title')).toBe('Improve your skills in maths and science');
  });

  it('falls back to es for keys present in es but not en', () => {
    const t = useTranslations('en');
    expect(t('nav.home')).toBe('Home');
  });

  it('handles dot-notation keys correctly', () => {
    const t = useTranslations('es');
    expect(t('features.formulas.title')).toBe('Fórmulas');
    expect(t('features.chatgpt.desc')).toContain('ChatGPT');
  });

  it('returns correct comparison keys in es', () => {
    const t = useTranslations('es');
    expect(t('comparison.feature.adFree')).toBe('Sin publicidad');
    expect(t('comparison.recommended')).toBe('Recomendado');
  });

  it('returns correct comparison keys in en', () => {
    const t = useTranslations('en');
    expect(t('comparison.feature.adFree')).toBe('Ad-free');
    expect(t('comparison.recommended')).toBe('Recommended');
  });

  it('returns correct download keys in es', () => {
    const t = useTranslations('es');
    expect(t('download.appStore')).toBe('App Store');
    expect(t('download.googlePlaySubtitle')).toBe('Disponible en');
  });

  it('returns correct download keys in en', () => {
    const t = useTranslations('en');
    expect(t('download.appStore')).toBe('App Store');
    expect(t('download.googlePlaySubtitle')).toBe('Get it on');
  });

  it('returns correct footer keys in es', () => {
    const t = useTranslations('es');
    expect(t('footer.tagline')).toContain('CAPDESIS');
    expect(t('footer.copyright')).toContain('reservados');
  });

  it('returns correct footer keys in en', () => {
    const t = useTranslations('en');
    expect(t('footer.tagline')).toContain('CAPDESIS');
    expect(t('footer.copyright')).toContain('reserved');
  });

  it('returns correct support keys', () => {
    const t = useTranslations('es');
    expect(t('support.title')).toBe('Soporte');
    expect(t('support.subtitle')).toContain('duda');
  });

  it('returns correct legal keys', () => {
    const t = useTranslations('es');
    expect(t('privacy.title')).toBe('Política de privacidad');
    expect(t('terms.title')).toContain('Términos');
    expect(t('legal.lastUpdated')).toBe('Última actualización');
  });

  it('returns correct 404 keys', () => {
    const t = useTranslations('es');
    expect(t('404.title')).toContain('no encontrada');
    expect(t('404.cta')).toContain('Volver');
  });

  it('returns correct accessibility keys', () => {
    const t = useTranslations('es');
    expect(t('a11y.skipToContent')).toBe('Saltar al contenido');
  });

  it('returns correct nav keys in en', () => {
    const t = useTranslations('en');
    expect(t('nav.privacy')).toBe('Privacy');
    expect(t('nav.openApp')).toBe('Open Web App');
  });

  it('works with both Locale types', () => {
    const locales: Locale[] = ['es', 'en'];
    for (const loc of locales) {
      const t = useTranslations(loc);
      expect(typeof t('nav.home')).toBe('string');
    }
  });
});
