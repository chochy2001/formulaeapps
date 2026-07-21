import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/Favorites/favorites_screen.dart';
import 'package:formulae/constantes/constantes_favoritos.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/screens_personalizados/drawer_personalizado.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:formulae/widgets_personalizados/todo/tasks_list.dart';
import 'package:formulae/widgets_personalizados/ver_pdf.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets(
    'task list toggles completion and exposes the task details requested by a long press',
    (tester) async {
      final tasks = TaskData();
      await tester.pumpAndSettle();
      tasks.deleteAllTasks();
      await tester.pumpAndSettle();
      final task = Task(
        name: 'Revisar integrales',
        dueDate: DateTime(2026, 8, 15),
      );
      tasks.addTask(task);
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        _app(
          child: ChangeNotifierProvider<TaskData>.value(
            value: tasks,
            child: const Scaffold(body: TasksList()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      expect(task.isDone, isTrue);

      await tester.longPress(find.text('Revisar integrales'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Tarea: Revisar integrales'), findsOneWidget);
      expect(find.textContaining('2026-08-15'), findsOneWidget);

      await tester.tap(find.text('Cerrar'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    },
  );

  testWidgets(
    'favorite removal keeps the formula until the user confirms the destructive dialog',
    (tester) async {
      final favorites = FavoritesNotifier();
      final favorite = Favorite(
        title: 'Ley de Ampere',
        widgetName: kWidgetTeoremaDelRotacional,
      );
      favorites.addFavorite(favorite);

      await tester.pumpWidget(
        _app(
          child: ChangeNotifierProvider<FavoritesNotifier>.value(
            value: favorites,
            child: const FavoritesScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Eliminar'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(favorites.activeFolder.favorites, contains(favorite));

      await tester.tap(find.byTooltip('Eliminar'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Eliminar'));
      await tester.pumpAndSettle();
      expect(favorites.activeFolder.favorites, isEmpty);
    },
  );

  testWidgets(
    'custom folders survive cancellation and are removed only after confirmation',
    (tester) async {
      final favorites = FavoritesNotifier();
      favorites.createFolder('Examen final');

      await tester.pumpWidget(
        _app(
          child: ChangeNotifierProvider<FavoritesNotifier>.value(
            value: favorites,
            child: const FavoritesScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(
        favorites.folders.map((folder) => folder.name),
        contains('Examen final'),
      );

      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Eliminar'));
      await tester.pumpAndSettle();
      expect(
        favorites.folders.map((folder) => folder.name),
        isNot(contains('Examen final')),
      );
    },
  );

  testWidgets(
    'favorite move dialog transfers a formula to the chosen destination folder',
    (tester) async {
      final favorites = FavoritesNotifier();
      final favorite = Favorite(
        title: 'Campo eléctrico',
        widgetName: kWidgetTeoremaDelRotacional,
      );
      favorites.addFavorite(favorite);
      favorites.createFolder('Física');
      final physicsFolder = favorites.activeFolder;
      favorites.setActiveFolder(FavoritesNotifier.defaultFolderId);

      await tester.pumpWidget(
        _app(
          child: ChangeNotifierProvider<FavoritesNotifier>.value(
            value: favorites,
            child: const FavoritesScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.drive_file_move_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Física').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Guardar'));
      await tester.pumpAndSettle();

      expect(physicsFolder.favorites, contains(favorite));
      expect(favorites.folders.first.favorites, isEmpty);
    },
  );

  testWidgets(
    'PDF download screen gives the user a retry action after an invalid URL fails',
    (tester) async {
      await tester.pumpWidget(
        _app(child: const VerPDFNuevo(pdfUrl: 'not-a-valid-pdf-url')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Intentar de nuevo'), findsOneWidget);
      await tester.tap(find.text('Intentar de nuevo'));
      await tester.pumpAndSettle();
      expect(find.text('Intentar de nuevo'), findsOneWidget);
    },
  );

  testWidgets('drawer routes the FAQ action through its named destination', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    await tester.pumpWidget(
      _app(
        routes: {
          '/preguntasFrecuentes': (_) =>
              const Scaffold(body: Text('FAQ destination')),
        },
        child: const Scaffold(drawer: DrawerPersonalizado(0)),
      ),
    );
    final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffold.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Preguntas frecuentes'));
    await tester.pumpAndSettle();
    expect(find.text('FAQ destination'), findsOneWidget);
  });
}

Widget _app({required Widget child, Map<String, WidgetBuilder>? routes}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    locale: const Locale('es'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: L10n.all,
    routes: routes ?? const {},
    home: child,
  );
}
