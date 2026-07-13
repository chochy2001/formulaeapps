/**
 * Tabla de traducciones. El copy en ES y EN está adaptado del
 * landing actual en producción (formulaeapps.com), corrigiendo:
 *  - El subtítulo en EN que estaba en español.
 *  - El nombre de la versión gratuita ("Formulae Community", no "Formulae").
 *  - Pequeñas mejoras de claridad sin inventar funcionalidad nueva.
 */

import type { Locale } from '../consts';

export const ui = {
  es: {
    'nav.home': 'Inicio',
    'nav.pro': 'Formulae Pro',
    'nav.community': 'Formulae Community',
    'nav.support': 'Soporte',
    'nav.privacy': 'Privacidad',
    'nav.terms': 'Términos',
    'nav.download': 'Descargar',
    'nav.openApp': 'Abrir App Web',
    'nav.primaryLabel': 'Principal',
    'nav.menuLabel': 'Menú',
    'nav.mobileLabel': 'Móvil',

    'hero.title': 'Mejora tus habilidades en matemáticas y ciencias',
    'hero.subtitle':
      'Ofrecemos dos aplicaciones, Formulae Pro y Formulae Community, diseñadas para ayudarte en tus estudios. Ambas ofrecen una lista de tareas para que no se te olvide lo que debes hacer, un buscador de fórmulas para encontrar rápidamente lo que necesitas y más.',
    'hero.cta.primary': '¡Descarga la App!',
    'hero.cta.secondary': 'Ver Formulae Pro',
    'hero.imageAlt':
      'Captura de Formulae mostrando un catálogo de fórmulas matemáticas en pantalla móvil',

    'video.eyebrow': 'En 60 segundos',
    'video.title': 'Mira Formulae en acción',

    'screenshots.eyebrow': 'Capturas reales',
    'screenshots.title': 'Mira Formulae por dentro',
    'screenshots.subtitle':
      'Vistas de la app: catálogo de fórmulas, imágenes explicativas, vídeos, ejercicios resueltos y más.',
    'screenshots.scrollHint': '← Desliza para ver más →',

    'features.eyebrow': 'Funcionalidades',
    'features.title': 'Todo lo que necesitas para estudiar',
    'features.formulas.title': 'Fórmulas',
    'features.formulas.desc':
      'Accede a una amplia variedad de fórmulas matemáticas y científicas en un solo lugar.',
    'features.search.title': 'Buscador',
    'features.search.desc':
      'Encuentra rápidamente la fórmula que necesitas con nuestro práctico buscador.',
    'features.tasks.title': 'Tareas',
    'features.tasks.desc':
      'Mantén un seguimiento de tus tareas y compromisos escolares con nuestra lista de tareas integrada.',
    'features.favorites.title': 'Favoritos',
    'features.favorites.desc':
      'Guarda tus fórmulas favoritas para acceder a ellas fácilmente en el futuro.',
    'features.images.title': 'Imágenes',
    'features.images.desc': 'Comprende mejor los conceptos con nuestras imágenes explicativas.',
    'features.videos.title': 'Vídeos',
    'features.videos.desc': 'Aprende de forma interactiva con nuestros vídeos explicativos.',
    'features.exercises.title': 'Ejercicios',
    'features.exercises.desc':
      'Practica y mejora tus habilidades con nuestros ejercicios resueltos.',
    'features.pdfs.title': 'PDFs',
    'features.pdfs.desc':
      'Descarga y guarda tus fórmulas en formato PDF para tenerlas a mano siempre.',
    'features.chatgpt.title': 'ChatGPT',
    'features.chatgpt.desc':
      'Habla con nuestro chatbot habilitado por ChatGPT en cualquier momento y obtén ayuda instantánea.',
    'features.practice.title': 'Practica',
    'features.practice.desc':
      'Practica y mejora tus habilidades con nuestros ejercicios resueltos.',

    'comparison.eyebrow': 'Pro o gratis',
    'comparison.title': 'Elige la versión que encaja contigo',
    'comparison.pro.name': 'Formulae Pro',
    'comparison.pro.tagline':
      'Una aplicación de pago para ayudarte en tus estudios de matemáticas y ciencias. Ofrece videos y imágenes explicativas, un buscador de fórmulas y una lista de tareas para no olvidar lo que debes hacer.',
    'comparison.pro.cta': 'Descargar Pro',
    'comparison.community.name': 'Formulae Community',
    'comparison.community.tagline':
      'Una aplicación gratuita para ayudarte en tus estudios de matemáticas y ciencias. Ofrece videos y imágenes explicativas, un buscador de fórmulas y una lista de tareas para no olvidar lo que debes hacer.',
    'comparison.community.cta': 'Descargar gratis',
    'comparison.feature.adFree': 'Sin publicidad',
    'comparison.feature.chatgpt': 'Asistente ChatGPT',
    'comparison.feature.pdf': 'Exportar a PDF',
    'comparison.feature.tasks': 'Tareas y recordatorios',
    'comparison.feature.formulas': 'Catálogo de fórmulas',
    'comparison.feature.videos': 'Vídeos explicativos',
    'comparison.recommended': 'Recomendado',

    'subjects.eyebrow': 'Materias',
    'subjects.title': 'Materias que cubre Formulae Pro',
    'subjects.subtitle':
      'Formulae Pro va más allá de las matemáticas puras y reúne fórmulas de matemáticas e ingeniería en una sola app, desde álgebra y cálculo hasta mecánica, óptica y termodinámica.',
    'subjects.algebra.label': 'Álgebra',
    'subjects.linearAlgebra.label': 'Álgebra lineal',
    'subjects.trigonometry.label': 'Trigonometría',
    'subjects.geometry.label': 'Geometría',
    'subjects.calculus.label': 'Cálculo diferencial, integral y multivariable',
    'subjects.differentialEquations.label': 'Ecuaciones diferenciales',
    'subjects.probabilityStatistics.label': 'Probabilidad y estadística',
    'subjects.fourier.label': 'Series de Fourier',
    'subjects.discreteMath.label': 'Matemáticas discretas',
    'subjects.financialMath.label': 'Matemáticas financieras',
    'subjects.mechanics.label': 'Mecánica',
    'subjects.electromagnetism.label': 'Electricidad y magnetismo',
    'subjects.optics.label': 'Óptica',
    'subjects.thermodynamics.label': 'Termodinámica',
    'subjects.unitConversion.label': 'Conversión de unidades',
    'subjects.constants.label': 'Constantes físicas y matemáticas',

    'download.title': 'Descarga la App',
    'download.subtitle': 'Disponible en App Store, Google Play, Microsoft Store y AppGallery',
    'download.appStore': 'App Store',
    'download.appStoreSubtitle': 'Descargar en',
    'download.googlePlay': 'Google Play',
    'download.googlePlaySubtitle': 'Disponible en',
    'download.microsoftStore': 'Microsoft Store',
    'download.microsoftStoreSubtitle': 'Disponible en',
    'download.huawei': 'AppGallery',
    'download.huaweiSubtitle': 'Explora en',
    'download.linktree': 'Ver todos los enlaces',

    'support.title': 'Soporte',
    'support.subtitle':
      '¿Tienes una duda, has encontrado un fallo o quieres sugerir una mejora? Escríbenos.',
    'support.email.label': 'Correo de contacto',
    'support.faq.title': 'Preguntas frecuentes',

    'privacy.title': 'Política de privacidad',
    'terms.title': 'Términos y condiciones',
    'legal.lastUpdated': 'Última actualización',

    'footer.tagline': 'Aplicaciones para aprender matemáticas y ciencias creadas por CAPDESIS.',
    'footer.product': 'Producto',
    'footer.legal': 'Legal',
    'footer.contact': 'Contacto',
    'footer.copyright': 'Todos los derechos reservados.',

    'language.switcher.label': 'Idioma',
    'a11y.skipToContent': 'Saltar al contenido',
    '404.title': 'Página no encontrada',
    '404.subtitle': 'La página que buscas no existe o se ha movido.',
    '404.cta': 'Volver al inicio',
  },

  en: {
    'nav.home': 'Home',
    'nav.pro': 'Formulae Pro',
    'nav.community': 'Formulae Community',
    'nav.support': 'Support',
    'nav.privacy': 'Privacy',
    'nav.terms': 'Terms',
    'nav.download': 'Download',
    'nav.openApp': 'Open Web App',
    'nav.primaryLabel': 'Primary navigation',
    'nav.menuLabel': 'Menu',
    'nav.mobileLabel': 'Mobile navigation',

    'hero.title': 'Improve your skills in maths and science',
    'hero.subtitle':
      'We offer two applications, Formulae Pro and Formulae Community, designed to assist you in your studies. Both include a task list so you never forget what you have to do, a formula searcher to quickly find what you need and more.',
    'hero.cta.primary': 'Download the App!',
    'hero.cta.secondary': 'See Formulae Pro',
    'hero.imageAlt': 'Formulae screenshot showing the math formulas catalog on a mobile screen',

    'video.eyebrow': 'In 60 seconds',
    'video.title': 'See Formulae in action',

    'screenshots.eyebrow': 'Real screenshots',
    'screenshots.title': 'Take a look inside Formulae',
    'screenshots.subtitle':
      'App views: formula catalog, explanatory images, videos, solved exercises and more.',
    'screenshots.scrollHint': '← Swipe to see more →',

    'features.eyebrow': 'Features',
    'features.title': 'Everything you need to study',
    'features.formulas.title': 'Formulas',
    'features.formulas.desc':
      'Access a wide variety of mathematical and scientific formulas in one place.',
    'features.search.title': 'Searcher',
    'features.search.desc': 'Quickly find the formula you need with our convenient searcher.',
    'features.tasks.title': 'Tasks',
    'features.tasks.desc':
      'Keep track of your tasks and school commitments with our integrated task list.',
    'features.favorites.title': 'Favorites',
    'features.favorites.desc': 'Save your favorite formulas for easy access in the future.',
    'features.images.title': 'Images',
    'features.images.desc': 'Better understand concepts with our explanatory images.',
    'features.videos.title': 'Videos',
    'features.videos.desc': 'Learn interactively with our explanatory videos.',
    'features.exercises.title': 'Exercises',
    'features.exercises.desc': 'Practice and improve your skills with our solved exercises.',
    'features.pdfs.title': 'PDFs',
    'features.pdfs.desc':
      'Download and save your formulas in PDF format to always have them at hand.',
    'features.chatgpt.title': 'ChatGPT',
    'features.chatgpt.desc':
      'Talk to our ChatGPT-enabled chatbot at any time and receive instant assistance.',
    'features.practice.title': 'Practice',
    'features.practice.desc': 'Practice and improve your skills with our solved exercises.',

    'comparison.eyebrow': 'Pro or free',
    'comparison.title': 'Pick the version that fits you',
    'comparison.pro.name': 'Formulae Pro',
    'comparison.pro.tagline':
      'A paid application to help you in your math and science studies. It offers explanatory videos and images, a formula searcher and a task list so you never forget what you have to do.',
    'comparison.pro.cta': 'Get Pro',
    'comparison.community.name': 'Formulae Community',
    'comparison.community.tagline':
      'A free application to help you in your math and science studies. It offers explanatory videos and images, a formula searcher and a task list so you never forget what you have to do.',
    'comparison.community.cta': 'Download free',
    'comparison.feature.adFree': 'Ad-free',
    'comparison.feature.chatgpt': 'ChatGPT assistant',
    'comparison.feature.pdf': 'PDF export',
    'comparison.feature.tasks': 'Tasks & reminders',
    'comparison.feature.formulas': 'Formula catalog',
    'comparison.feature.videos': 'Explanatory videos',
    'comparison.recommended': 'Recommended',

    'subjects.eyebrow': 'Subjects',
    'subjects.title': 'Subjects Formulae Pro covers',
    'subjects.subtitle':
      'Formulae Pro goes beyond pure mathematics and brings together formulas from maths and engineering in a single app, from algebra and calculus to mechanics, optics and thermodynamics.',
    'subjects.algebra.label': 'Algebra',
    'subjects.linearAlgebra.label': 'Linear algebra',
    'subjects.trigonometry.label': 'Trigonometry',
    'subjects.geometry.label': 'Geometry',
    'subjects.calculus.label': 'Differential, integral and multivariable calculus',
    'subjects.differentialEquations.label': 'Differential equations',
    'subjects.probabilityStatistics.label': 'Probability and statistics',
    'subjects.fourier.label': 'Fourier series',
    'subjects.discreteMath.label': 'Discrete mathematics',
    'subjects.financialMath.label': 'Financial mathematics',
    'subjects.mechanics.label': 'Mechanics',
    'subjects.electromagnetism.label': 'Electricity and magnetism',
    'subjects.optics.label': 'Optics',
    'subjects.thermodynamics.label': 'Thermodynamics',
    'subjects.unitConversion.label': 'Unit conversion',
    'subjects.constants.label': 'Physical and mathematical constants',

    'download.title': 'Download the App',
    'download.subtitle': 'Available on App Store, Google Play, Microsoft Store and AppGallery',
    'download.appStore': 'App Store',
    'download.appStoreSubtitle': 'Download on the',
    'download.googlePlay': 'Google Play',
    'download.googlePlaySubtitle': 'Get it on',
    'download.microsoftStore': 'Microsoft Store',
    'download.microsoftStoreSubtitle': 'Get it from',
    'download.huawei': 'AppGallery',
    'download.huaweiSubtitle': 'Explore it on',
    'download.linktree': 'See all download links',

    'support.title': 'Support',
    'support.subtitle':
      'Got a question, found a bug or want to suggest an improvement? Get in touch.',
    'support.email.label': 'Contact email',
    'support.faq.title': 'Frequently asked questions',

    'privacy.title': 'Privacy policy',
    'terms.title': 'Terms and conditions',
    'legal.lastUpdated': 'Last updated',

    'footer.tagline': 'Apps to learn maths and science, made by CAPDESIS.',
    'footer.product': 'Product',
    'footer.legal': 'Legal',
    'footer.contact': 'Contact',
    'footer.copyright': 'All rights reserved.',

    'language.switcher.label': 'Language',
    'a11y.skipToContent': 'Skip to content',
    '404.title': 'Page not found',
    '404.subtitle': 'The page you are looking for does not exist or has moved.',
    '404.cta': 'Back to home',
  },
} as const satisfies Record<Locale, Record<string, string>>;

export type UIKey = keyof (typeof ui)['es'];

export function useTranslations(locale: Locale) {
  return function t(key: UIKey): string {
    return ui[locale][key] ?? ui.es[key];
  };
}
