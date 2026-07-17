import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/Favorites/favorites_pdf_generator.dart';
import 'package:formulae/Favorites/favorites_screen.dart';
import 'package:formulae/constantes/constantes_favoritos.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/screens_personalizados/drawer_personalizado.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:formulae/widgets_personalizados/todo/tasks_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets(
    'task list edits a task name through its slide action without losing dates',
    (tester) async {
      final tasks = TaskData();
      await tester.pumpAndSettle();
      tasks.deleteAllTasks();
      final task = Task(
        name: 'Nombre original',
        reminderDateTime: DateTime(2026, 8, 10, 9),
        dueDate: DateTime(2026, 8, 15),
      );
      tasks.addTask(task);

      await tester.pumpWidget(
        _app(
          child: ChangeNotifierProvider<TaskData>.value(
            value: tasks,
            child: const Scaffold(body: TasksList()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Slidable), const Offset(500, 0));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Editar'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'Nombre actualizado');
      await tester.tap(find.text('Guardar'));
      await tester.pumpAndSettle();

      expect(tasks.tasks, hasLength(1));
      expect(tasks.tasks.single.name, 'Nombre actualizado');
      expect(tasks.tasks.single.reminderDateTime, task.reminderDateTime);
      expect(tasks.tasks.single.dueDate, task.dueDate);
    },
  );

  testWidgets(
    'iOS drawer routes the FAQ action through its named destination',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _app(
          routes: {
            '/preguntasFrecuentes': (_) =>
                const Scaffold(body: Text('iOS FAQ destination')),
          },
          child: const Scaffold(drawer: DrawerPersonalizado(1)),
        ),
      );
      final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffold.openDrawer();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Preguntas frecuentes'));
      await tester.pumpAndSettle();
      expect(find.text('iOS FAQ destination'), findsOneWidget);
    },
  );

  testWidgets(
    'favorites switches folders and persists the formula export size selected by the user',
    (tester) async {
      final favorites = FavoritesNotifier();
      favorites.addFavorite(
        Favorite(
          title: 'Ley de Coulomb',
          widgetName: kWidgetTeoremaDelRotacional,
        ),
      );
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

      await tester.tap(find.text('Física'));
      await tester.pumpAndSettle();
      expect(favorites.activeFolder, same(physicsFolder));
      expect(find.byIcon(Icons.folder_off_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.format_size_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PopupMenuItem<PdfFormulaSize>).last);
      await tester.pumpAndSettle();

      expect(
        await FavoritesPdfGenerator.loadFormulaSize(),
        PdfFormulaSize.large,
      );
    },
  );

  testWidgets(
    'favorites export and clear actions stay disabled when the active folder is empty',
    (tester) async {
      await tester.pumpWidget(
        _app(
          child: ChangeNotifierProvider<FavoritesNotifier>(
            create: (_) => FavoritesNotifier(),
            child: const FavoritesScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final buttons = tester.widgetList<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(buttons.where((button) => button.onPressed == null), isNotEmpty);
      expect(find.byIcon(Icons.folder_off_rounded), findsOneWidget);
    },
  );
}

Widget _app({
  required Widget child,
  Map<String, WidgetBuilder>? routes,
}) {
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
