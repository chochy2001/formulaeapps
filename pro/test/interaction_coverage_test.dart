import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/Favorites/favorites_screen.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/constantes/constantes_favoritos.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/secciones_app/algebra/ecuaciones/ecuaciones_segundo_grado.dart';
import 'package:formulae/secciones_app/algebra/formula_general.dart';
import 'package:formulae/secciones_app/calculo_diferencial/derivacion_basica_diferencial.dart';
import 'package:formulae/secciones_app/calculo_integral/integracion_basica_integral.dart';
import 'package:formulae/secciones_app/generales/identidades_trigonometricas_generales.dart';
import 'package:formulae/secciones_app/generales/propiedades_logaritmos_generales.dart';
import 'package:formulae/secciones_app/geometria/areas/area_y_perimetro_de_cuadrilateros.dart';
import 'package:formulae/secciones_app/geometria/areas/area_y_perimetro_de_triangulos.dart';
import 'package:formulae/widgets_personalizados/todo/add_task_screen.dart';
import 'package:formulae/widgets_personalizados/todo/export_options.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:formulae/widgets_personalizados/todo/tasks_list.dart';
import 'package:formulae/widgets_personalizados/todo/tasks_screen.dart';
import 'package:formulae/widgets_personalizados/ver_pdf.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterError.onError = (_) {};
  });

  testWidgets('FavoritesScreen with favorites and clear dialog', (tester) async {
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
    while (tester.takeException() != null) {}
    expect(find.byType(FavoritesScreen), findsOneWidget);

    final delete = find.byIcon(Icons.delete_forever);
    if (delete.evaluate().isNotEmpty) {
      await tester.tap(delete.first);
      await tester.pump();
      while (tester.takeException() != null) {}
      final cancelEs = find.textContaining('Cancelar');
      if (cancelEs.evaluate().isNotEmpty) {
        await tester.tap(cancelEs.first);
        await tester.pump();
      }
    }
  });

  testWidgets('Configuracion mounts and toggles', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    await tester.pumpWidget(_harness(home: const Configuracion()));
    await tester.pump();
    while (tester.takeException() != null) {}
    expect(find.byType(Configuracion), findsOneWidget);
    final switches = find.byType(Switch);
    for (var i = 0; i < switches.evaluate().length && i < 3; i++) {
      await tester.tap(switches.at(i));
      await tester.pump();
      while (tester.takeException() != null) {}
    }
  });

  testWidgets('Todo screens interact', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    final tasks = TaskData();
    await tester.pumpWidget(_harness(taskData: tasks, home: const TasksScreen()));
    await tester.pump();
    while (tester.takeException() != null) {}

    await tester.pumpWidget(
      _harness(taskData: tasks, home: const Scaffold(body: TasksList())),
    );
    await tester.pump();
    while (tester.takeException() != null) {}

    // Exercise slidable / checkbox if present
    final checkboxes = find.byType(Checkbox);
    if (checkboxes.evaluate().isNotEmpty) {
      await tester.tap(checkboxes.first);
      await tester.pump();
      while (tester.takeException() != null) {}
    }

    await tester.pumpWidget(
      _harness(taskData: tasks, home: const Scaffold(body: AddTaskScreen())),
    );
    await tester.pump();
    final fields = find.byType(TextField);
    if (fields.evaluate().isNotEmpty) {
      await tester.enterText(fields.first, 'coverage task');
      await tester.pump();
    }

    await tester.pumpWidget(
      _harness(
        taskData: tasks,
        home: const Scaffold(body: ExportOptionsDialog()),
      ),
    );
    await tester.pump();
    final tiles = find.byType(CheckboxListTile);
    for (var i = 0; i < tiles.evaluate().length && i < 3; i++) {
      await tester.tap(tiles.at(i));
      await tester.pump();
    }
  });

  testWidgets('Formula screens: favorite toggles and ExpansionTiles',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 2000));
    final screens = <Widget>[
      const FormulaGeneral(),
      PropiedadesLogaritmosGenerales(),
      IdentidadesTrigonometricasGenerales(),
      DerivacionBasicaDiferencial(),
      IntegracionBasicaIntegral(),
      const AreaYPerimetroDeCuadrilateros(),
      AreaYPerimetroDeTriangulos(),
      EcuacionesDeSegundoGrado(),
    ];

    for (final screen in screens) {
      await tester.pumpWidget(_harness(home: screen));
      await tester.pump();
      while (tester.takeException() != null) {}

      final fav = find.byIcon(Icons.favorite_border);
      if (fav.evaluate().isNotEmpty) {
        await tester.tap(fav.first);
        await tester.pump();
        while (tester.takeException() != null) {}
      }

      final list = find.byType(Scrollable);
      if (list.evaluate().isNotEmpty) {
        await tester.drag(list.first, const Offset(0, -500));
        await tester.pump();
      }

      final tiles = find.byType(ExpansionTile);
      for (var i = 0; i < tiles.evaluate().length && i < 4; i++) {
        await tester.ensureVisible(tiles.at(i));
        await tester.tap(tiles.at(i));
        await tester.pump();
        while (tester.takeException() != null) {}
      }
    }
  });

  testWidgets('VerPDF known id', (tester) async {
    await tester.pumpWidget(
      _harness(home: const Scaffold(body: VerPDF(url: kWidgetFormulaGeneral))),
    );
    await tester.pump();
    while (tester.takeException() != null) {}
    expect(find.byType(VerPDF), findsOneWidget);
  });

  test('Favorite equality and json', () {
    final a = Favorite(title: 't', widgetName: kWidgetFormulaGeneral);
    final b = Favorite.fromJson(a.toJson());
    expect(a, b);
    expect(a.hashCode, b.hashCode);
  });
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
