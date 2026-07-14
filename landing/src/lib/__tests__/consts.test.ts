import { describe, it, expect } from 'vitest';
import { SITE, SOCIAL, STORES, FEATURES, VIDEO, LINKTREE } from '../../consts';

describe('SITE', () => {
  it('has required fields', () => {
    expect(SITE.name).toBe('Formulae');
    expect(SITE.domain).toBe('formulaeapps.com');
    expect(SITE.url).toBe('https://formulaeapps.com');
    expect(SITE.defaultLocale).toBe('es');
    expect(SITE.locales).toEqual(['es', 'en']);
    expect(SITE.email).toBe('formulae@capdesis.com');
    expect(SITE.publisher).toBe('CAPDESIS');
    expect(SITE.publisherLegal).toBe('CAPDESIS S.A. DE C.V.');
  });

  it('locales is readonly tuple with es and en', () => {
    const locales: readonly string[] = SITE.locales;
    expect(locales).toContain('es');
    expect(locales).toContain('en');
    expect(locales.length).toBe(2);
  });
});

describe('SOCIAL', () => {
  it('has expected links', () => {
    expect(SOCIAL.facebook).toContain('facebook.com');
    expect(SOCIAL.instagram).toContain('instagram.com');
    expect(SOCIAL.whatsapp).toContain('wa.me');
  });
});

describe('VIDEO', () => {
  it('has valid YouTube details', () => {
    expect(VIDEO.youtubeId).toBeTruthy();
    expect(VIDEO.watchUrl).toContain('youtu.be');
    expect(VIDEO.embedUrl).toContain('youtube-nocookie.com');
    expect(VIDEO.thumbnailUrl).toContain('ytimg.com');
  });
});

describe('LINKTREE', () => {
  it('points to linktree', () => {
    expect(LINKTREE).toContain('linktr.ee');
  });
});

describe('STORES', () => {
  it('has pro store URLs', () => {
    expect(STORES.pro.appStore).toContain('apps.apple.com');
    expect(STORES.pro.playStore).toContain('play.google.com');
    expect(STORES.pro.microsoftStore).toContain('microsoft.com');
    expect(STORES.pro.huawei).toContain('appgallery.huawei.com');
  });

  it('has community store URLs', () => {
    expect(STORES.community.appStore).toContain('apps.apple.com');
    expect(STORES.community.playStore).toContain('play.google.com');
    expect(STORES.community.microsoftStore).toContain('microsoft.com');
    expect(STORES.community.huawei).toContain('appgallery.huawei.com');
  });

  it('has different appStore IDs for pro and community', () => {
    expect(STORES.pro.appStore).not.toBe(STORES.community.appStore);
  });

  it('has different playStore IDs for pro and community', () => {
    expect(STORES.pro.playStore).not.toBe(STORES.community.playStore);
  });

  it('pro appStore points to id1666691016', () => {
    expect(STORES.pro.appStore).toContain('id1666691016');
  });

  it('community appStore points to id6445803819', () => {
    expect(STORES.community.appStore).toContain('id6445803819');
  });
});

describe('FEATURES', () => {
  it('has all expected features', () => {
    const ids = FEATURES.map((f) => f.id);
    expect(ids).toContain('formulas');
    expect(ids).toContain('search');
    expect(ids).toContain('tasks');
    expect(ids).toContain('favorites');
    expect(ids).toContain('images');
    expect(ids).toContain('videos');
    expect(ids).toContain('exercises');
    expect(ids).toContain('pdfs');
    expect(ids).toContain('chatgpt');
    expect(ids).toContain('practice');
  });

  it('marks correct features as proOnly', () => {
    const proOnly = FEATURES.filter((f) => f.proOnly).map((f) => f.id);
    expect(proOnly).toContain('chatgpt');
    expect(proOnly).toContain('chatgpt');
    expect(proOnly).not.toContain('tasks');
    expect(proOnly).not.toContain('pdfs');
  });

  it('marks correct features as not proOnly', () => {
    const free = FEATURES.filter((f) => !f.proOnly).map((f) => f.id);
    expect(free).toContain('formulas');
    expect(free).toContain('search');
    expect(free).toContain('favorites');
    expect(free).toContain('images');
    expect(free).toContain('videos');
    expect(free).toContain('exercises');
    expect(free).toContain('practice');
  });

  it('every feature has an id', () => {
    for (const f of FEATURES) {
      expect(f.id).toBeTruthy();
      expect(typeof f.id).toBe('string');
    }
  });

  it('every feature has a proOnly boolean', () => {
    for (const f of FEATURES) {
      expect(typeof f.proOnly).toBe('boolean');
    }
  });
});
