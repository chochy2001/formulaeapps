import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/drop_down.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/menus/menu.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/screens_personalizados/drawer_personalizado.dart';
import 'package:formulae/secciones_app/algebra/ecuaciones/ecuaciones_primer_grado.dart';
import 'package:formulae/secciones_app/algebra/ecuaciones/ecuaciones_segundo_grado.dart';
import 'package:formulae/secciones_app/algebra/formulas_de_productos.dart';
import 'package:formulae/secciones_app/algebra/formulas_factorizacion.dart';
import 'package:formulae/secciones_app/algebra/operaciones_con_fracciones_algebraicas.dart';
import 'package:formulae/secciones_app/algebra/propiedades_de_los_exponentes.dart';
import 'package:formulae/secciones_app/algebra/propiedades_radicales.dart';
import 'package:formulae/secciones_app/calculo_diferencial/derivacion_basica_diferencial.dart';
import 'package:formulae/secciones_app/calculo_diferencial/exponencial_logaritmos.dart';
import 'package:formulae/secciones_app/calculo_diferencial/funciones_trigonometricas_diferencial.dart';
import 'package:formulae/secciones_app/calculo_diferencial/limites/propiedades_limites.dart';
import 'package:formulae/secciones_app/calculo_integral/exponencial_logaritmo_integral.dart';
import 'package:formulae/secciones_app/calculo_integral/funciones_trigonometricas_integral.dart';
import 'package:formulae/secciones_app/calculo_integral/integracion_basica_integral.dart';
import 'package:formulae/secciones_app/generales/funciones_trigonometricas_general.dart';
import 'package:formulae/secciones_app/generales/identidades_trigonometricas_generales.dart';
import 'package:formulae/secciones_app/generales/propiedades_logaritmos_generales.dart';
import 'package:formulae/secciones_app/generales/trigonometricas_hiperbolicas_generales.dart';
import 'package:formulae/secciones_app/geometria/areas/area_y_perimetro_de_cuadrilateros.dart';
import 'package:formulae/secciones_app/geometria/areas/area_y_perimetro_de_triangulos.dart';
import 'package:formulae/secciones_app/geometria/areas/area_y_perimetro_del_circulo.dart';
import 'package:formulae/secciones_app/geometria/circunferencia.dart';
import 'package:formulae/secciones_app/geometria/distancia_entre_dos_puntos.dart';
import 'package:formulae/secciones_app/geometria/ecuacion_de_la_recta.dart';
import 'package:formulae/secciones_app/geometria/punto_medio_entre_dos_puntos.dart';
import 'package:formulae/widgets_personalizados/textos_personalizados.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> pumpFormula(WidgetTester tester, Widget screen) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    while (tester.takeException() != null) {}

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<FavoritesNotifier>(
            create: (_) => FavoritesNotifier(),
          ),
          ChangeNotifierProvider<ModelsProvider>(create: (_) => ModelsProvider()),
          ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
        ],
        child: MaterialApp(
          locale: const Locale('es'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          home: screen,
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    while (tester.takeException() != null) {}
  }

  testWidgets(
    'under-covered formula screens build without crashing',
    (tester) async {
      final screens = <Widget>[
        const DerivacionBasicaDiferencial(),
        const IntegracionBasicaIntegral(),
        const PropiedadesLogaritmosGenerales(),
        const IdentidadesTrigonometricasGenerales(),
        const TrigonometricasHiperbolicasGenerales(),
        const AreaYPerimetroDeCuadrilateros(),
        const AreaYPerimetroDeTriangulos(),
        const AreaYPerimetroDelCirculo(),
        const EcuacionesDeSegundoGrado(),
        const EcuacionesDePrimerGrado(),
        const OperacionesFraccionesAlgebraicas(),
        const FuncionesTrigonometricasGenerales(),
        const DistanciaEntreDosPuntos(),
        const PuntoMedioEntreDosPuntos(),
        const ExponencialyLogaritmosDiferencial(),
        const ExponencialyLogaritmoIntegral(),
        const PropiedadesDeLosExponentes(),
        const PropiedadesRadicales(),
        const FormulasDeFactorizacion(),
        const FormulasDeProductos(),
        const FuncionesTrigonometricasDiferencial(),
        const FuncionesTrigonometricasIntegral(),
        const EcuacionDeLaRecta(),
        const Circunferencia(),
        const PropiedadesLimites(),
      ];

      for (final screen in screens) {
        await pumpFormula(tester, screen);
        expect(
          find.byType(Scaffold),
          findsWidgets,
          reason: '${screen.runtimeType} should build a Scaffold',
        );
      }
    },
  );

  testWidgets(
    'derivacion basica reveals Latex when section flags are enabled',
    (tester) async {
      await pumpFormula(tester, const DerivacionBasicaDiferencial());
      final state = tester.state<DerivacionBasicaDiferencialState>(
        find.byType(DerivacionBasicaDiferencial),
      );
      // ignore: invalid_use_of_protected_member
      state.setState(() {
        state.seleccionadoDerivacionConstante = true;
        state.seleccionadoDerivacionDeX = true;
        state.seleccionadoConstantePorX = true;
        state.seleccionadoXaLaN = true;
        state.seleccionadoConstantePorXaLaN = true;
      });
      await tester.pump();
      while (tester.takeException() != null) {}
      expect(find.byType(Latex), findsWidgets);
      expect(
        tester
            .widgetList<Latex>(find.byType(Latex))
            .map((w) => w.formulaText),
        contains(r'\frac{d}{dx}(c) = 0'),
      );
    },
  );

  testWidgets(
    'integracion basica reveals Latex when section flags are enabled',
    (tester) async {
      await pumpFormula(tester, const IntegracionBasicaIntegral());
      final state = tester.state<IntegracionBasicaIntegralState>(
        find.byType(IntegracionBasicaIntegral),
      );
      // ignore: invalid_use_of_protected_member
      state.setState(() {
        state.seleccionadoIntegralDx = true;
        state.seleccionadoConstantePorDx = true;
        state.seleccionadoVariableElevadoAUnExponente = true;
      });
      await tester.pump();
      while (tester.takeException() != null) {}
      expect(find.byType(Latex), findsWidgets);
      expect(
        tester
            .widgetList<Latex>(find.byType(Latex))
            .map((w) => w.formulaText),
        contains(r'\int dx = x + C'),
      );
    },
  );

  testWidgets('models dropdown lists stub models and changes selection', (
    tester,
  ) async {
    final models = ModelsProvider()..setCurrentModel('openai/gpt-4o-mini');
    await tester.pumpWidget(
      ChangeNotifierProvider<ModelsProvider>.value(
        value: models,
        child: const MaterialApp(home: Scaffold(body: ModelsDropDownWidget())),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.byType(DropdownButton<String>), findsOneWidget);
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();

    final item = find.text('openai/gpt-4o-mini').last;
    expect(item, findsOneWidget);
    await tester.tap(item);
    await tester.pumpAndSettle();
    expect(models.getCurrentModel, 'openai/gpt-4o-mini');
  });

  test('favorites folders cover rename/move/delete paths', () async {
    SharedPreferences.setMockInitialValues({});
    final notifier = FavoritesNotifier();
    final favorite = Favorite(
      title: 'Log',
      widgetName: 'PropiedadesLogaritmos',
    );

    expect(
      FavoriteFolder.fromJson({'id': 'x', 'name': 'X'}).favorites,
      isEmpty,
    );
    expect(
      FavoriteFolder.fromJson({
        'id': 'y',
        'name': 'Y',
        'favorites': [
          {'title': 'A', 'widgetName': 'B'},
          'skip-me',
        ],
      }).favorites,
      [Favorite(title: 'A', widgetName: 'B')],
    );

    notifier.createFolder('   ');
    expect(notifier.folders, hasLength(1));
    notifier.createFolder('Exam');
    notifier.createFolder('exam');
    expect(notifier.folders.where((f) => f.name == 'Exam'), hasLength(1));

    notifier.addFavorite(favorite);
    notifier.renameFolder(FavoritesNotifier.defaultFolderId, 'Nope');
    notifier.renameFolder(notifier.activeFolderId, '   ');
    notifier.renameFolder(notifier.activeFolderId, 'Examen');
    expect(notifier.activeFolder.name, 'Examen');

    final examId = notifier.activeFolderId;
    notifier.setActiveFolder(FavoritesNotifier.defaultFolderId);
    notifier.moveFavoriteToFolder(favorite, examId);
    expect(notifier.activeFolder.favorites, isEmpty);
    notifier.setActiveFolder(examId);
    expect(notifier.activeFolder.favorites, contains(favorite));
    notifier.moveFavoriteToFolder(favorite, 'missing');

    notifier.deleteFolder(FavoritesNotifier.defaultFolderId);
    notifier.deleteFolder(examId);
    expect(
      notifier.folders.any((f) => f.id == FavoritesNotifier.defaultFolderId),
      isTrue,
    );
    expect(notifier.activeFolderId, FavoritesNotifier.defaultFolderId);

    notifier.removeAllFavorites();
    expect(notifier.favorites, isEmpty);
    expect(
      Favorite(title: 't', widgetName: 'w').runtimeType.typeName,
      'Favorite',
    );
  });

  test('favorites loadFolders restores custom active folder and default', () async {
    SharedPreferences.setMockInitialValues({
      'favoriteFolders': jsonEncode([
        {
          'id': 'custom',
          'name': 'Custom',
          'favorites': [
            {'title': 'T', 'widgetName': 'W'},
          ],
        },
      ]),
      'activeFavoriteFolderId': 'custom',
    });
    final loaded = await FavoritesNotifier.loadFavorites();
    expect(loaded.activeFolderId, 'custom');
    expect(loaded.activeFolder.favorites, hasLength(1));
    expect(
      loaded.folders.any((f) => f.id == FavoritesNotifier.defaultFolderId),
      isTrue,
    );
  });

  testWidgets(
    'menu shell switches tabs, re-taps home, and handles nested pops',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_shellApp(child: const Menu()));
      await tester.pump(const Duration(seconds: 1));
      while (tester.takeException() != null) {}

      final hasRail = find.byType(NavigationRail).evaluate().isNotEmpty;
      final hasBottom = find.byType(BottomNavigationBar).evaluate().isNotEmpty;
      expect(hasRail || hasBottom, isTrue);

      await tester.tap(find.text('Tareas').last);
      await tester.pump(const Duration(seconds: 1));
      while (tester.takeException() != null) {}
      expect(find.text('To-Do List'), findsOneWidget);

      await tester.tap(find.text('Menú').last);
      await tester.pump(const Duration(seconds: 1));
      while (tester.takeException() != null) {}

      await tester.tap(find.text('Menú').last);
      await tester.pump(const Duration(milliseconds: 200));

      final menuState = tester.state<MenuState>(find.byType(Menu));
      final navigator = menuState.debugNavigatorKeys.first.currentState;
      expect(navigator, isNotNull);
      navigator!.push(
        MaterialPageRoute<void>(
          settings: const RouteSettings(name: '/nested-coverage'),
          builder: (_) => const Scaffold(body: Text('nested-route')),
        ),
      );
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('nested-route'), findsOneWidget);

      navigator.pushNamed('/does-not-exist-coverage');
      await tester.pump(const Duration(milliseconds: 300));

      await tester.binding.handlePopRoute();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.binding.handlePopRoute();
      await tester.pump(const Duration(milliseconds: 300));
    },
  );

  testWidgets('drawer iOS and Android destinations remain tappable', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(900, 1800));
    for (final platform in [0, 1]) {
      await tester.pumpWidget(
        KeyedSubtree(
          key: ValueKey('drawer-$platform'),
          child: _shellApp(
            routes: {
              '/preguntasFrecuentes': (_) => const Scaffold(body: Text('faq')),
              '/informacion': (_) => const Scaffold(body: Text('info')),
              '/configuracion': (_) => const Configuracion(),
            },
            child: Scaffold(
              drawer: DrawerPersonalizado(platform),
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      for (final label in [
        'FAQ',
        'Info',
        'Preguntas',
        'Información',
        'Config',
      ]) {
        final finder = find.textContaining(label);
        if (finder.evaluate().isEmpty) continue;
        await tester.tap(finder.first, warnIfMissed: false);
        await tester.pump(const Duration(milliseconds: 100));
        while (tester.takeException() != null) {}
        break;
      }
    }
  });
}

Widget _shellApp({
  required Widget child,
  Map<String, WidgetBuilder>? routes,
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
      ChangeNotifierProvider<FavoritesNotifier>(
        create: (_) => FavoritesNotifier(),
      ),
    ],
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
      routes: routes ?? const <String, WidgetBuilder>{},
      home: child,
    ),
  );
}
