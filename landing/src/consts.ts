/**
 * Constantes del sitio. URLs y datos extraídos de la landing actual
 * en producción (formulaeapps.com) y verificados directamente contra
 * las fichas de tienda — auditoría 2026-04-30.
 *
 *  PRO  → Apple id1666691016 — Google com.capdesis.formulae_pro.formulae_calculo_pro
 *  COMM → Apple id6445803819 — Google capdesis.formulae
 *
 * Ambas fichas confirman developer: "CAPDESIS S.A. DE C.V.".
 *
 * NOTA: el landing actual tiene los enlaces de Apple y Google Play
 *       cruzados entre Pro y Community. Aquí están corregidos.
 */

export const SITE = {
  name: 'Formulae',
  domain: 'formulaeapps.com',
  url: 'https://formulaeapps.com',
  appUrl: 'https://app.formulaeapps.com',
  defaultLocale: 'es' as const,
  locales: ['es', 'en'] as const,
  email: 'formulae@capdesis.com',
  /** Marca corta usada en footer y JSON-LD. */
  publisher: 'CAPDESIS',
  /** Razón social completa para textos legales y schema.org. */
  publisherLegal: 'CAPDESIS S.A. DE C.V.',
  twitter: '',
  ogImage: '/og/default.png',
} as const;

export const SOCIAL = {
  facebook: 'https://www.facebook.com/people/FormulaeApp/100092426805612/',
  instagram: 'https://instagram.com/formulaeapps?igshid=NTc4MTIwNjQ2YQ==',
  /** Número CDMX con código país México (52). Confirmado 2026-04-30. */
  whatsapp: 'https://wa.me/525561869139',
} as const;

/** Linktree global con todos los enlaces de descarga. */
export const LINKTREE = 'https://linktr.ee/formulae_';

/**
 * Video demostrativo de YouTube. ID extraído del HTML del sitio actual.
 *  - watchUrl: enlace canónico para compartir
 *  - embedUrl: usamos youtube-nocookie para no plantar cookies
 *    de tracking hasta que el usuario haga play.
 */
export const VIDEO = {
  youtubeId: '5a-1hC3TgI8',
  watchUrl: 'https://youtu.be/5a-1hC3TgI8',
  embedUrl: 'https://www.youtube-nocookie.com/embed/5a-1hC3TgI8',
  thumbnailUrl: 'https://i.ytimg.com/vi_webp/5a-1hC3TgI8/hqdefault.webp',
} as const;

/**
 * URLs de tienda. CORREGIDAS respecto al landing actual:
 *  Pro       → id1666691016
 *  Community → id6445803819
 *
 * Apple URLs sin región — Apple redirige por geolocalización del usuario.
 */
export const STORES = {
  pro: {
    appStore: 'https://apps.apple.com/app/id1666691016',
    playStore:
      'https://play.google.com/store/apps/details?id=com.capdesis.formulae_pro.formulae_calculo_pro',
    microsoftStore: 'https://www.microsoft.com/store/productId/9PLJZVDNGWZL',
    huawei: 'https://appgallery.huawei.com/app/C108327279',
  },
  community: {
    appStore: 'https://apps.apple.com/app/id6445803819',
    playStore: 'https://play.google.com/store/apps/details?id=capdesis.formulae',
    microsoftStore: 'https://www.microsoft.com/store/productId/9PLJZVDNGWZL',
    huawei: 'https://appgallery.huawei.com/app/C104757435',
  },
} as const;

/**
 * Lista canónica de features mostradas en la landing actual,
 * en el mismo orden y con los mismos nombres que aparecen ahí.
 */
export const FEATURES = [
  { id: 'formulas', proOnly: false },
  { id: 'search', proOnly: false },
  { id: 'tasks', proOnly: true },
  { id: 'favorites', proOnly: false },
  { id: 'images', proOnly: false },
  { id: 'videos', proOnly: false },
  { id: 'exercises', proOnly: false },
  { id: 'pdfs', proOnly: true },
  { id: 'chatgpt', proOnly: true },
  { id: 'practice', proOnly: false },
] as const;

/**
 * Materias que cubre Formulae Pro. Es una lista verificable de áreas
 * (no un conteo de fórmulas), usada por la sección "Materias" de la
 * landing para comunicar que Pro abarca matemáticas e ingeniería, no
 * solo matemáticas puras. El orden aquí define el orden de render; el
 * texto de cada materia vive en i18n/ui.ts como 'subjects.<id>.label'.
 */
export const SUBJECTS = [
  'algebra',
  'linearAlgebra',
  'trigonometry',
  'geometry',
  'calculus',
  'differentialEquations',
  'probabilityStatistics',
  'fourier',
  'discreteMath',
  'financialMath',
  'mechanics',
  'electromagnetism',
  'optics',
  'thermodynamics',
  'unitConversion',
  'constants',
] as const;

export type Locale = (typeof SITE.locales)[number];
export type FeatureId = (typeof FEATURES)[number]['id'];
export type SubjectId = (typeof SUBJECTS)[number];
