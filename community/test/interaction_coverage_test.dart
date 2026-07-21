import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/Favorites/favorites_screen.dart';
import 'package:formulae/ads/admob_config.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/constantes/constantes_favoritos.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/models/task_data.dart';
import 'package:formulae/screens/add_task_screen.dart';
import 'package:formulae/screens/tasks_screen.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/secciones_app/algebra/ecuaciones/ecuaciones_segundo_grado.dart';
import 'package:formulae/secciones_app/algebra/formula_general.dart';
import 'package:formulae/secciones_app/calculo_diferencial/derivacion_basica_diferencial.dart';
import 'package:formulae/secciones_app/calculo_integral/integracion_basica_integral.dart';
import 'package:formulae/secciones_app/generales/identidades_trigonometricas_generales.dart';
import 'package:formulae/secciones_app/generales/propiedades_logaritmos_generales.dart';
import 'package:formulae/secciones_app/geometria/areas/area_y_perimetro_de_cuadrilateros.dart';
import 'package:formulae/secciones_app/geometria/areas/area_y_perimetro_de_triangulos.dart';
import 'package:formulae/secciones_app/geometria/punto_medio_entre_dos_puntos.dart';
import 'package:formulae/widgets_personalizados/ver_pdf.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    AdMobConfig.adsEnabled = false;
  });

  tearDown(() {
    AdMobConfig.adsEnabled = true;
  });

  test('TaskData CRUD covers persistence paths', () async {
    final data = TaskData();
    final before = data.taskCount;
    data.addTask('coverage');
    expect(data.taskCount, before + 1);
    final task = data.tasks.last;
    data.updateTask(task);
    data.deleteTask(task);
    data.deleteAllTasks();
    expect(data.taskCount, 0);
  });

  testWidgets('TasksScreen and AddTaskScreen mount', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    final tasks = TaskData();
    await tester.pumpWidget(
      _harness(taskData: tasks, home: const TasksScreen()),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    _expectNoWidgetException(tester, 'TasksScreen initial mount');
    expect(find.byType(TasksScreen), findsOneWidget);

    await tester.pumpWidget(
      _harness(
        taskData: tasks,
        home: const Scaffold(body: AddTaskScreen()),
      ),
    );
    await tester.pump();
    _expectNoWidgetException(tester, 'AddTaskScreen initial mount');
    expect(find.byType(AddTaskScreen), findsOneWidget);
    final fields = find.byType(TextField);
    if (fields.evaluate().isNotEmpty) {
      await tester.enterText(fields.first, 'nueva tarea');
      await tester.pump();
    }
  });

  testWidgets('FavoritesScreen with favorites and clear dialog', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    final favs = FavoritesNotifier();
    favs.addFavorite(
      Favorite(title: 'Formula general', widgetName: kWidgetFormulaGeneral),
    );
    await tester.pumpWidget(
      _harness(favorites: favs, home: const FavoritesScreen()),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    _expectNoWidgetException(tester, 'FavoritesScreen initial mount');
    expect(find.byType(FavoritesScreen), findsOneWidget);

    final delete = find.byIcon(Icons.delete_forever);
    if (delete.evaluate().isNotEmpty) {
      await tester.tap(delete.first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      _expectNoWidgetException(tester, 'Favorites clear dialog');
      final cancelEs = find.textContaining('Cancelar');
      final cancelEn = find.textContaining('Cancel');
      if (cancelEs.evaluate().isNotEmpty) {
        await tester.tap(cancelEs.first);
      } else if (cancelEn.evaluate().isNotEmpty) {
        await tester.tap(cancelEn.first);
      }
      await tester.pump();
      _expectNoWidgetException(tester, 'Favorites clear dialog dismissal');
    }
  });

  testWidgets('Configuracion mounts', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    await tester.pumpWidget(_harness(home: const Configuracion()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    _expectNoWidgetException(tester, 'Configuracion initial mount');
    expect(find.byType(Configuracion), findsOneWidget);
    final switches = find.byType(Switch);
    for (var i = 0; i < switches.evaluate().length && i < 3; i++) {
      await tester.tap(switches.at(i));
      await tester.pump();
      _expectNoWidgetException(tester, 'Configuracion switch $i');
    }
    expect(find.byType(ListView), findsWidgets);
  });

  testWidgets('PuntoMedio calculator fields and favorite toggle', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(900, 2000));
    await tester.pumpWidget(
      _harness(home: const PuntoMedioEntreDosPuntosGeometria()),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    _expectNoWidgetException(tester, 'PuntoMedio initial mount');

    final fav = find.byIcon(Icons.favorite_border);
    if (fav.evaluate().isNotEmpty) {
      await tester.tap(fav.first);
      await tester.pump();
      _expectNoWidgetException(tester, 'PuntoMedio favorite toggle');
    }

    final fields = find.byType(TextField);
    final count = fields.evaluate().length;
    for (var i = 0; i < count && i < 4; i++) {
      await tester.enterText(fields.at(i), '${i + 1}.5');
      await tester.pump();
      _expectNoWidgetException(tester, 'PuntoMedio field $i');
    }
    final buttons = find.byType(ElevatedButton);
    for (var i = 0; i < buttons.evaluate().length && i < 2; i++) {
      await tester.tap(buttons.at(i));
      await tester.pump();
      _expectNoWidgetException(tester, 'PuntoMedio button $i');
    }
  });

  testWidgets('Formula screens: favorite toggles and scroll', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 2000));
    final screens = <Widget>[
      const FormulaGeneral(),
      const PropiedadesLogaritmosGenerales(),
      const IdentidadesTrigonometricasGenerales(),
      const DerivacionBasicaDiferencial(),
      const IntegracionBasicaIntegral(),
      const AreaYPerimetroDeCuadrilateros(),
      const AreaYPerimetroDeTriangulos(),
      const EcuacionesDeSegundoGrado(),
    ];

    for (final screen in screens) {
      await tester.pumpWidget(_harness(home: screen));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 16));
      _expectNoWidgetException(tester, '${screen.runtimeType} initial mount');

      final fav = find.byIcon(Icons.favorite_border);
      if (fav.evaluate().isNotEmpty) {
        await tester.tap(fav.first);
        await tester.pump();
        _expectNoWidgetException(
          tester,
          '${screen.runtimeType} favorite toggle',
        );
      }

      final list = find.byType(Scrollable);
      if (list.evaluate().isNotEmpty) {
        await tester.drag(list.first, const Offset(0, -400));
        await tester.pump();
        _expectNoWidgetException(tester, '${screen.runtimeType} scroll');
      }

      final tiles = find.byType(ExpansionTile);
      for (var i = 0; i < tiles.evaluate().length && i < 3; i++) {
        await tester.ensureVisible(tiles.at(i));
        await tester.tap(tiles.at(i));
        await tester.pump();
        _expectNoWidgetException(
          tester,
          '${screen.runtimeType} expansion tile $i',
        );
      }
    }
  });

  testWidgets('VerPDF with known widget id shows button', (tester) async {
    await tester.pumpWidget(
      _harness(
        home: const Scaffold(body: VerPDF(url: kWidgetFormulaGeneral)),
      ),
    );
    await tester.pump();
    _expectNoWidgetException(tester, 'VerPDF known widget id');
    expect(find.byType(VerPDF), findsOneWidget);
  });
}

void _expectNoWidgetException(WidgetTester tester, String phase) {
  expect(
    tester.takeException(),
    isNull,
    reason: '$phase threw a widget exception',
  );
}

Widget _harness({
  required Widget home,
  TaskData? taskData,
  FavoritesNotifier? favorites,
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LocaleProvider>(
        create: (_) => LocaleProvider(const Locale('es')),
      ),
      ChangeNotifierProvider<ModelsProvider>(create: (_) => ModelsProvider()),
      ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
      ChangeNotifierProvider<TaskData>.value(value: taskData ?? TaskData()),
      ChangeNotifierProvider<FavoritesNotifier>.value(
        value: favorites ?? FavoritesNotifier(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('es'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      home: home,
    ),
  );
}
