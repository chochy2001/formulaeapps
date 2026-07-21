import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/Favorites/pdf_capture_scope.dart';
import 'package:formulae/Favorites/widget_mapper.dart';
import 'package:formulae/chat_gpt/chat_screen.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/constantes/constantes_favoritos.dart';
import 'package:formulae/constantes/contantes_rutas.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/routes.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:formulae/widgets_personalizados/textos_personalizados.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _routesRequiringPlatformChannels = <String>{kRutaChatGPT};

// Commit ad9e863 expanded the route table from 300 to 427 entries and the
// favorites table from 261 to 382. This explicit ledger is intentionally not
// derived from map order: it makes a removed, duplicated, or substituted
// expansion entry fail the test rather than silently testing another screen.
const _contentExpansionRoutes = <String>[
  kRutaCoeficientesBinomiales,
  kRutaPotenciasNEsimas,
  kRutaEcuacionCubica,
  kRutaEcuacionCuadraticaFormaMonicaVieta,
  kRutaNumerosComplejosFormaExponencialNumeroComplejo,
  kRutaNumerosComplejosRaicesEIgualdadNumerosComplejos,
  kRutaPropiedadesLogaritmos2,
  kRutaDeterminantesCramerSarrus,
  kRutaAlgebraLinealMatricesTiposDeMatrices,
  kRutaAlgebraLinealVectoresProductosBaseCanonica,
  kRutaAlgebraLinealVectoresProductoEscalarTriple,
  kRutaAlgebraLinealVectoresSumaVectoresComponentes,
  kRutaAlgebraLinealVectoresLeySenosCosenos,
  kRutaAlgebraLinealVectoresRazonesTrigonometricas,
  kRutaLimitesTeoremasLimites,
  kRutaLimitesLimitesInfinitos,
  kRutaLimitesLimitesImportantes,
  kRutaAsintotasHorizontalesOblicuas,
  kRutaContinuidad,
  kRutaReglaLhopital,
  kRutaDiferenciales,
  kRutaDerivadasAlgebraicasRadicales,
  kRutaReglaCadenaFuncionInversa,
  kRutaDerivadasTrigonometricasComplementarias,
  kRutaDerivadasHiperbolicasInversas,
  kRutaDerivacionLogaritmica,
  kRutaRazonCambioTangenteNormal,
  kRutaAplicacionFisicaDerivada,
  kRutaIntegralesInmediatasAdicionalesIntegral,
  kRutaPotenciasReduccionTrigonometricasIntegral,
  kRutaTrigonometricasRacionalesProductosIntegral,
  kRutaPotenciasReduccionHiperbolicasIntegral,
  kRutaHiperbolicasInversasIntegral,
  kRutaIntegralDefinidaPropiedadesIntegral,
  kRutaIntegracionNumericaIntegral,
  kRutaSustitucionTrigonometricaIntegral,
  kRutaAreaLongitudArcoIntegral,
  kRutaFraccionesParcialesIntegral,
  kRutaConstantesMatematicas,
  kRutaConstantesFisicasUniversales,
  kRutaConstantesElectromagneticas,
  kRutaConstantesAtomicasMoleculares,
  kRutaConstantesTerrestresAstronomicas,
  kRutaMenuConstantesMatematicas,
  kRutaLongitudConversion,
  kRutaSuperficieConversion,
  kRutaVolumenConversion,
  kRutaMasaConversion,
  kRutaDensidadConversion,
  kRutaPresionConversion,
  kRutaEnergiaConversion,
  kRutaPotenciaConversion,
  kRutaMenuConversionDeUnidades,
  kRutaPotenciaYReactanciasEnCa,
  kRutaCaValoresEficacesTransformador,
  kRutaInstrumentosDeMedicionElectrica,
  kRutaCircuitoLrEnSerie,
  kRutaFuerzaYTorcaMagnetica,
  kRutaCapacitoresCilindricoYEsferico,
  kRutaPermeabilidadMagneticaEnMateriales,
  kRutaBateriaRealVoltajeEnTerminales,
  kRutaLaRectaYElTriangulo,
  kRutaTangentesYPropiedadesDeLasConicas,
  kRutaHiperbolaEquilatera,
  kRutaLaCurvaExponencial,
  kRutaAceleracionYMrua,
  kRutaCaidaLibreYTiroVertical,
  kRutaMovimientoDeProyectiles,
  kRutaMovimientoCircularUniforme,
  kRutaCinematicaAngular,
  kRutaAceleracionYFuerzaCentripeta,
  kRutaLeyesDeNewton,
  kRutaPesoYGravedad,
  kRutaCantidadDeMovimientoEImpulso,
  kRutaFriccion,
  kRutaMovimientoArmonicoSimple,
  kRutaPenduloSimple,
  kRutaEquilibrioDeCuerposRigidos,
  kRutaMomentoDeTorsion,
  kRutaEficiencia,
  kRutaHidrostatica,
  kRutaHidrodinamica,
  kRutaMenuMecanica,
  kRutaAxiomasDeCampoNumerosReales,
  kRutaAxiomasDeOrdenYTeoremasReales,
  kRutaDesigualdadesTeoremasDeOrden,
  kRutaConjuntosEIntervalos,
  kRutaValorAbsoluto,
  kRutaMenuNumerosRealesYDesigualdades,
  kRutaLeyDeLaIluminacion,
  kRutaReflexionYAumentoFormaNewtoniana,
  kRutaEcuacionDeLasLentesFormaGaussiana,
  kRutaRefraccionDeLaLuzLeyDeSnell,
  kRutaTiposDeLentesYMarchaDeRayos,
  kRutaMenuOptica,
  kRutaAxiomasDeProbabilidad,
  kRutaFuncionesDeMasaDensidadYAcumulada,
  kRutaFuncionesDeProbabilidadConjuntasYCondicionales,
  kRutaEsperanzaMediaYVarianza,
  kRutaDistribucionesDistribucionDeBernoulli,
  kRutaDistribucionesDistribucionDePascal,
  kRutaDistribucionesDistribucionBeta,
  kRutaDistribucionesDistribucionDeCauchy,
  kRutaDistribucionesDistribucionDeErlang,
  kRutaDistribucionesDistribucionUniforme,
  kRutaRegresionLineal,
  kRutaDesigualdadDeChebyshevYConvergencia,
  kRutaTransferenciaDeCalor,
  kRutaCapacidadCalorificaYCalorLatente,
  kRutaLeyesDeLosGases,
  kRutaCicloDeCarnotYLeyesDeLaTermodinamica,
  kRutaTrabajoTermodinamico,
  kRutaEntalpiaYEnergiaInterna,
  kRutaDilatacionLineal,
  kRutaDilatacionSuperficialYVolumetrica,
  kRutaEntropiaYTeoriaCinetica,
  kRutaProcesosTermodinamicos,
  kRutaMenuTermodinamica,
  kRutaCirculoUnitario,
  kRutaSignosDeFuncionesPorCuadrante,
  kRutaAngulosNotablesGradosRadianes,
  kRutaRelacionEntreFuncionesTrigonometricas,
  kRutaIdentidadesDeAnguloTripleYCuadruple,
  kRutaIdentidadesDeReduccionDePotencias,
  kRutaIdentidadesFundamentalesFormasDerivadas,
  kRutaCotangenteDeSumaYRestaDeAngulos,
  kRutaProductoDeCosenoPorSeno,
];

const _contentExpansionWidgets = <String>[
  kWidgetCoeficientesBinomiales,
  kWidgetPotenciasNEsimas,
  kWidgetEcuacionCubica,
  kWidgetEcuacionCuadraticaFormaMonicaVieta,
  kWidgetNumerosComplejosFormaExponencialNumeroComplejo,
  kWidgetNumerosComplejosRaicesEIgualdadNumerosComplejos,
  kWidgetPropiedadesLogaritmos,
  kWidgetDeterminantesCramerSarrus,
  kWidgetAlgebraLinealMatricesTiposDeMatrices,
  kWidgetAlgebraLinealVectoresProductosBaseCanonica,
  kWidgetAlgebraLinealVectoresProductoEscalarTriple,
  kWidgetAlgebraLinealVectoresSumaVectoresComponentes,
  kWidgetAlgebraLinealVectoresLeySenosCosenos,
  kWidgetAlgebraLinealVectoresRazonesTrigonometricas,
  kWidgetLimitesTeoremasLimites,
  kWidgetLimitesLimitesInfinitos,
  kWidgetLimitesLimitesImportantes,
  kWidgetAsintotasHorizontalesOblicuas,
  kWidgetContinuidad,
  kWidgetReglaLhopital,
  kWidgetDiferenciales,
  kWidgetDerivadasAlgebraicasRadicales,
  kWidgetReglaCadenaFuncionInversa,
  kWidgetDerivadasTrigonometricasComplementarias,
  kWidgetDerivadasHiperbolicasInversas,
  kWidgetDerivacionLogaritmica,
  kWidgetRazonCambioTangenteNormal,
  kWidgetAplicacionFisicaDerivada,
  kWidgetIntegralesInmediatasAdicionalesIntegral,
  kWidgetPotenciasReduccionTrigonometricasIntegral,
  kWidgetTrigonometricasRacionalesProductosIntegral,
  kWidgetPotenciasReduccionHiperbolicasIntegral,
  kWidgetHiperbolicasInversasIntegral,
  kWidgetIntegralDefinidaPropiedadesIntegral,
  kWidgetIntegracionNumericaIntegral,
  kWidgetSustitucionTrigonometricaIntegral,
  kWidgetAreaLongitudArcoIntegral,
  kWidgetFraccionesParcialesIntegral,
  kWidgetConstantesMatematicas,
  kWidgetConstantesFisicasUniversales,
  kWidgetConstantesElectromagneticas,
  kWidgetConstantesAtomicasMoleculares,
  kWidgetConstantesTerrestresAstronomicas,
  kWidgetLongitudConversion,
  kWidgetSuperficieConversion,
  kWidgetVolumenConversion,
  kWidgetMasaConversion,
  kWidgetDensidadConversion,
  kWidgetPresionConversion,
  kWidgetEnergiaConversion,
  kWidgetPotenciaConversion,
  kWidgetPotenciaYReactanciasEnCa,
  kWidgetCaValoresEficacesTransformador,
  kWidgetInstrumentosDeMedicionElectrica,
  kWidgetCircuitoLrEnSerie,
  kWidgetFuerzaYTorcaMagnetica,
  kWidgetCapacitoresCilindricoYEsferico,
  kWidgetPermeabilidadMagneticaEnMateriales,
  kWidgetBateriaRealVoltajeEnTerminales,
  kWidgetLaRectaYElTriangulo,
  kWidgetTangentesYPropiedadesDeLasConicas,
  kWidgetHiperbolaEquilatera,
  kWidgetLaCurvaExponencial,
  kWidgetAceleracionYMrua,
  kWidgetCaidaLibreYTiroVertical,
  kWidgetMovimientoDeProyectiles,
  kWidgetMovimientoCircularUniforme,
  kWidgetCinematicaAngular,
  kWidgetAceleracionYFuerzaCentripeta,
  kWidgetLeyesDeNewton,
  kWidgetPesoYGravedad,
  kWidgetCantidadDeMovimientoEImpulso,
  kWidgetFriccion,
  kWidgetMovimientoArmonicoSimple,
  kWidgetPenduloSimple,
  kWidgetEquilibrioDeCuerposRigidos,
  kWidgetMomentoDeTorsion,
  kWidgetEficiencia,
  kWidgetHidrostatica,
  kWidgetHidrodinamica,
  kWidgetAxiomasDeCampoNumerosReales,
  kWidgetAxiomasDeOrdenYTeoremasReales,
  kWidgetDesigualdadesTeoremasDeOrden,
  kWidgetConjuntosEIntervalos,
  kWidgetValorAbsoluto,
  kWidgetLeyDeLaIluminacion,
  kWidgetReflexionYAumentoFormaNewtoniana,
  kWidgetEcuacionDeLasLentesFormaGaussiana,
  kWidgetRefraccionDeLaLuzLeyDeSnell,
  kWidgetTiposDeLentesYMarchaDeRayos,
  kWidgetAxiomasDeProbabilidad,
  kWidgetFuncionesDeMasaDensidadYAcumulada,
  kWidgetFuncionesDeProbabilidadConjuntasYCondicionales,
  kWidgetEsperanzaMediaYVarianza,
  kWidgetDistribucionesDistribucionDeBernoulli,
  kWidgetDistribucionesDistribucionDePascal,
  kWidgetDistribucionesDistribucionBeta,
  kWidgetDistribucionesDistribucionDeCauchy,
  kWidgetDistribucionesDistribucionDeErlang,
  kWidgetDistribucionesDistribucionUniforme,
  kWidgetRegresionLineal,
  kWidgetDesigualdadDeChebyshevYConvergencia,
  kWidgetTransferenciaDeCalor,
  kWidgetCapacidadCalorificaYCalorLatente,
  kWidgetLeyesDeLosGases,
  kWidgetCicloDeCarnotYLeyesDeLaTermodinamica,
  kWidgetTrabajoTermodinamico,
  kWidgetEntalpiaYEnergiaInterna,
  kWidgetDilatacionLineal,
  kWidgetDilatacionSuperficialYVolumetrica,
  kWidgetEntropiaYTeoriaCinetica,
  kWidgetProcesosTermodinamicos,
  kWidgetCirculoUnitario,
  kWidgetSignosDeFuncionesPorCuadrante,
  kWidgetAngulosNotablesGradosRadianes,
  kWidgetRelacionEntreFuncionesTrigonometricas,
  kWidgetIdentidadesDeAnguloTripleYCuadruple,
  kWidgetIdentidadesDeReduccionDePotencias,
  kWidgetIdentidadesFundamentalesFormasDerivadas,
  kWidgetCotangenteDeSumaYRestaDeAngulos,
  kWidgetProductoDeCosenoPorSeno,
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Application routes', () {
    test('keeps the expected route table shape', () {
      final routes = getApplicationRoutes();
      expect(routes, hasLength(427));
      expect(routes.keys.toSet(), hasLength(routes.length));
      expect(routes.keys.every((route) => route.startsWith('/')), isTrue);
      expect(
        _contentExpansionRoutes.toSet(),
        hasLength(_contentExpansionRoutes.length),
        reason:
            'The content-expansion route ledger must not contain duplicates',
      );
      expect(
        routes.keys,
        containsAll(_contentExpansionRoutes),
        reason: 'Every content-expansion route must remain mounted',
      );
    });

    testWidgets(
      'mounts each route added by the content expansion without errors',
      (tester) async {
        final routes = getApplicationRoutes();
        var mounted = 0;
        await tester.binding.setSurfaceSize(const Size(900, 1600));

        for (final route in _contentExpansionRoutes) {
          if (_routesRequiringPlatformChannels.contains(route)) {
            continue;
          }
          final builder = routes[route];
          expect(builder, isNotNull, reason: 'Route $route must be mounted');

          await tester.pumpWidget(
            _buildHarness(
              favoritesNotifier: FavoritesNotifier(),
              homeBuilder: builder!,
            ),
          );
          await tester.pump();
          expect(
            tester.takeException(),
            isNull,
            reason: 'Route $route must build without Flutter errors',
          );
          mounted++;
        }

        expect(mounted, _contentExpansionRoutes.length);
      },
      timeout: const Timeout(Duration(minutes: 45)),
    );

    testWidgets(
      'every non-platform route renders instructional content without errors',
      (tester) async {
        final routes = getApplicationRoutes();
        var rendered = 0;
        await tester.binding.setSurfaceSize(const Size(900, 1600));

        for (final entry in routes.entries) {
          if (_routesRequiringPlatformChannels.contains(entry.key)) {
            continue;
          }

          await tester.pumpWidget(
            _buildHarness(
              favoritesNotifier: FavoritesNotifier(),
              homeBuilder: entry.value,
            ),
          );
          await tester.pump();

          expect(
            tester.takeException(),
            isNull,
            reason: 'Route ${entry.key} must build without Flutter errors',
          );
          expect(
            find.byWidgetPredicate(
              (widget) => widget is Text || widget is Latex,
            ),
            findsWidgets,
            reason: 'Route ${entry.key} must show instructional content',
          );
          rendered++;
        }

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        expect(
          rendered,
          routes.length - _routesRequiringPlatformChannels.length,
        );
      },
      timeout: const Timeout(Duration(minutes: 45)),
    );

    testWidgets(
      'every non-platform route renders localized English content',
      (tester) async {
        final routes = getApplicationRoutes();
        var rendered = 0;
        await tester.binding.setSurfaceSize(const Size(900, 1600));

        for (final entry in routes.entries) {
          if (_routesRequiringPlatformChannels.contains(entry.key)) {
            continue;
          }

          await tester.pumpWidget(
            _buildHarness(
              favoritesNotifier: FavoritesNotifier(),
              locale: const Locale('en'),
              homeBuilder: entry.value,
            ),
          );
          await tester.pump();

          expect(
            tester.takeException(),
            isNull,
            reason:
                'English route ${entry.key} must build without Flutter errors',
          );
          expect(
            find.byWidgetPredicate(
              (widget) => widget is Text || widget is Latex,
            ),
            findsWidgets,
            reason:
                'English route ${entry.key} must show instructional content',
          );
          rendered++;
        }

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        expect(
          rendered,
          routes.length - _routesRequiringPlatformChannels.length,
        );
      },
      timeout: const Timeout(Duration(minutes: 45)),
    );

    testWidgets('still maps chat route to ChatScreen', (tester) async {
      final routes = getApplicationRoutes();
      late BuildContext context;
      await tester.pumpWidget(
        _buildHarness(
          favoritesNotifier: FavoritesNotifier(),
          homeBuilder: (ctx) {
            context = ctx;
            return const SizedBox.shrink();
          },
        ),
      );
      await tester.pump();
      expect(routes[kRutaChatGPT]!(context), isA<ChatScreen>());
    });
  });

  group('Favorites widget mapper', () {
    test('keeps the expected widget table shape', () {
      expect(widgetTable, hasLength(382));
      expect(
        _contentExpansionWidgets.toSet(),
        hasLength(_contentExpansionWidgets.length),
        reason:
            'The content-expansion widget ledger must not contain duplicates',
      );
      expect(
        widgetTable.keys,
        containsAll(_contentExpansionWidgets),
        reason: 'Every content-expansion widget must remain mapped',
      );
    });

    testWidgets('throws for unknown widget names', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        _buildHarness(
          favoritesNotifier: FavoritesNotifier(),
          homeBuilder: (ctx) {
            context = ctx;
            return const SizedBox.shrink();
          },
        ),
      );
      await tester.pump();
      expect(
        () => widgetMapper('__invalid_widget_name__', context),
        throwsArgumentError,
      );
    });

    testWidgets(
      'mounts each formula widget added by the expansion without errors',
      (tester) async {
        var mounted = 0;
        await tester.binding.setSurfaceSize(const Size(900, 1600));

        for (final widgetName in _contentExpansionWidgets) {
          final builder = widgetTable[widgetName];
          expect(
            builder,
            isNotNull,
            reason: 'Favorite $widgetName must remain mapped',
          );
          await tester.pumpWidget(
            _buildHarness(
              favoritesNotifier: FavoritesNotifier(),
              homeBuilder: builder!,
            ),
          );
          await tester.pump();
          expect(
            tester.takeException(),
            isNull,
            reason: 'Favorite $widgetName must build without Flutter errors',
          );
          mounted++;
        }

        expect(mounted, _contentExpansionWidgets.length);
      },
      timeout: const Timeout(Duration(minutes: 45)),
    );

    testWidgets(
      'every saved formula page renders instructional content without errors',
      (tester) async {
        var rendered = 0;
        await tester.binding.setSurfaceSize(const Size(900, 1600));

        for (final entry in widgetTable.entries) {
          await tester.pumpWidget(
            _buildHarness(
              favoritesNotifier: FavoritesNotifier(),
              homeBuilder: entry.value,
            ),
          );
          await tester.pump();

          expect(
            tester.takeException(),
            isNull,
            reason: 'Favorite ${entry.key} must build without Flutter errors',
          );
          expect(
            find.byWidgetPredicate(
              (widget) => widget is Text || widget is Latex,
            ),
            findsWidgets,
            reason: 'Favorite ${entry.key} must show instructional content',
          );
          rendered++;
        }

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        expect(rendered, widgetTable.length);
      },
      timeout: const Timeout(Duration(minutes: 45)),
    );
  });
}

Widget _buildHarness({
  required FavoritesNotifier favoritesNotifier,
  required WidgetBuilder homeBuilder,
  Locale locale = const Locale('es'),
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LocaleProvider>(
        create: (_) => LocaleProvider(locale),
      ),
      ChangeNotifierProvider<ModelsProvider>(create: (_) => ModelsProvider()),
      ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
      ChangeNotifierProvider<TaskData>(create: (_) => TaskData()),
      ChangeNotifierProvider<FavoritesNotifier>.value(value: favoritesNotifier),
    ],
    child: PdfCaptureScope(
      isCapturing: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: L10n.all,
        home: Builder(builder: homeBuilder),
      ),
    ),
  );
}
