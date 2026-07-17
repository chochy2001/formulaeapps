# Fuentes y correcciones de contenido

Este registro cubre solo correcciones verificadas en el codigo. No demuestra la
correccion de todo el catalogo ni reemplaza una revision matematica completa.

## Correcciones de julio de 2026

| Pantalla | Correccion | Evidencia |
|---|---|---|
| Limites importantes | `lim sin(theta)/theta = 1` cuando `theta -> 0`; se retiro el limite bilateral falso de `cos(theta)/theta`. | NIST DLMF 4.19.1: la serie de `sin(z)` comienza con `z`, por lo que el cociente tiende a 1. https://dlmf.nist.gov/4.19.E1 |
| Derivadas trigonometricas complementarias | Se corrigieron arco seno, arco coseno y arco tangente para usar la variable `x` y los signos/denominadores correspondientes. | NIST DLMF 4.24.7-4.24.9. https://dlmf.nist.gov/4.24.E7 https://dlmf.nist.gov/4.24.E8 https://dlmf.nist.gov/4.24.E9 |
| Derivadas trigonometricas complementarias | La derivada de `arcvers(u)` es positiva: `arcvers(u) = arccos(1-u)` y la regla de la cadena cancela los dos signos negativos. | Derivacion desde la formula de `arccos` de NIST DLMF 4.24.8. https://dlmf.nist.gov/4.24.E8 |
| Potencias n-esimas | La factorizacion de `a^n + b^n` por `a+b` ahora declara la condicion `n` impar. | Verificacion algebraica: al sustituir `a=-b`, el polinomio se anula exactamente para `n` impar; el caso base `n=3` coincide con OpenStax College Algebra 1.5. https://openstax.org/books/college-algebra/pages/1-5-factoring-polynomials |
| Razon de cambio, tangente y normal | Se restauro el factor omitido: de `Delta y / Delta x = tan(a)` se obtiene `Delta y = Delta x tan(a)`. | Definicion de pendiente y cociente de diferencias, OpenStax Calculus Volume 1, 3.1. https://openstax.org/books/calculus-volume-1/pages/3-1-defining-the-derivative |
| Constantes fisicas universales | Se auditaron solo las seis constantes mostradas en esta pantalla: `c`, `h`, `k`, `N_A` y `sigma` se muestran como exactas por las definiciones SI de 2019 (con `sigma` derivada de ellas); `G = 6.674 30(15) x 10^-11 m^3 kg^-1 s^-2` conserva su incertidumbre estándar. | NIST CODATA 2022: https://physics.nist.gov/cuu/Constants/ y NIST SP 961, tabla CODATA 2022: https://physics.nist.gov/cuu/pdf/wall_2022.pdf |

## Exportacion PDF

El fallback de texto del PDF usa Noto Sans Math para simbolos matematicos que
Poppins no contiene. La fuente se obtuvo del proyecto oficial Noto Math en el
commit `53eb8eb200ed8fc73fa13d97d26a2c9c56428c17` y se distribuye bajo SIL Open
Font License 1.1. La documentacion oficial describe Noto Sans Math como una
fuente para notacion matematica: https://notofonts.github.io/noto-docs/specimen/NotoSansMath/

La ruta primaria sigue siendo la formula renderizada a PNG. El fallback existe
para runtimes donde `RenderRepaintBoundary.toImage` no esta disponible y tiene
un smoke que falla ante warnings de glifos ausentes.
