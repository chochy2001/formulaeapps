import 'package:flutter_test/flutter_test.dart';

import 'package:formulae/constantes/contantes_rutas.dart';

void main() {
  test('home route is root path', () {
    expect(kRutaMenu, '/');
  });

  test('sampled routes are non-empty and start with slash', () {
    const routes = [
      kRutaChatGPT,
      kRutaFavorites,
      kRutaPreguntasFrecuentes,
      kRutaCalculoIntegral,
      kRutaCalculoDiferencial,
      kRutaGenerales,
      kRutaMenuAlgebra,
      kRutaEcuacionesLineales,
      kRutaFormulaGeneral,
      kRutaLimites,
      kRutaDerivacionBasica,
      kRutaPropiedadesLogaritmos,
      kRutaMenuVectores,
    ];

    for (final route in routes) {
      expect(route, isNotEmpty);
      expect(route.startsWith('/'), isTrue);
    }
  });

  test('sampled routes have no duplicates', () {
    const routes = [
      kRutaMenu,
      kRutaChatGPT,
      kRutaFavorites,
      kRutaPreguntasFrecuentes,
      kRutaCalculoIntegral,
      kRutaCalculoDiferencial,
      kRutaGenerales,
      kRutaMenuAlgebra,
      kRutaEcuacionesLineales,
      kRutaFormulaGeneral,
      kRutaLimites,
      kRutaDerivacionBasica,
      kRutaPropiedadesLogaritmos,
    ];

    expect(routes.toSet().length, routes.length);
  });
}
