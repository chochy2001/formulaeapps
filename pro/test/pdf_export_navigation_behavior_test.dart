import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/Favorites/favorites_pdf_generator.dart';
import 'package:formulae/Favorites/favorites_screen.dart';
import 'package:formulae/constantes/constantes_favoritos.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/widgets_personalizados/todo/add_task_screen.dart';
import 'package:formulae/widgets_personalizados/todo/export_options.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:formulae/widgets_personalizados/todo/tasks_screen.dart';
import 'package:formulae/widgets_personalizados/ver_pdf.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets(
    'PDF preview preserves headings, text, and uncaptured formulas while '
    'changing the selected formula size',
    (tester) async {
      const content = FavoriteFormulaContent(
        title: 'Ley de Ohm',
        blocks: [
          FormulaPdfBlock(type: FormulaPdfBlockType.heading, text: 'Resumen'),
          FormulaPdfBlock(
            type: FormulaPdfBlockType.text,
            text: 'El voltaje es proporcional a la corriente.',
          ),
          FormulaPdfBlock(
            type: FormulaPdfBlockType.formula,
            text: r'V = I \cdot R',
          ),
        ],
      );

      await tester.pumpWidget(
        _app(
          child: VerPDFGenerado(
            title: content.title,
            previewContents: const [content],
          ),
        ),
      );

      expect(find.text('Ley de Ohm'), findsNWidgets(2));
      expect(find.text('Resumen'), findsOneWidget);
      expect(
        find.text('El voltaje es proporcional a la corriente.'),
        findsOneWidget,
      );
      expect(find.text(r'V = I \cdot R'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.format_size_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PopupMenuItem<PdfFormulaSize>).last);
      await tester.pumpAndSettle();

      expect(
        await FavoritesPdfGenerator.loadFormulaSize(),
        PdfFormulaSize.large,
      );
      expect(find.text(r'V = I \cdot R'), findsOneWidget);
    },
  );

  testWidgets(
    'PDF preview keeps an empty formula page readable using its title',
    (tester) async {
      const content = FavoriteFormulaContent(
        title: 'Contenido sin bloques',
        blocks: [],
      );

      await tester.pumpWidget(
        _app(
          child: VerPDFGenerado(
            title: content.title,
            previewContents: const [content],
          ),
        ),
      );

      // The preview supplies the title as body content rather than rendering a
      // blank page when extraction produced no individual blocks.
      expect(find.text('Contenido sin bloques'), findsNWidgets(3));
    },
  );

  testWidgets(
    'PDF preview separates multiple formulas and does not repeat its title heading',
    (tester) async {
      const first = FavoriteFormulaContent(
        title: 'Primera formula',
        blocks: [
          FormulaPdfBlock(
            type: FormulaPdfBlockType.heading,
            text: 'Primera formula',
          ),
          FormulaPdfBlock(
            type: FormulaPdfBlockType.text,
            text: 'El encabezado repetido se omite.',
          ),
        ],
      );
      const second = FavoriteFormulaContent(
        title: 'Segunda formula',
        blocks: [
          FormulaPdfBlock(
            type: FormulaPdfBlockType.heading,
            text: 'Desarrollo',
          ),
          FormulaPdfBlock(
            type: FormulaPdfBlockType.formula,
            text: r'a^2 + b^2 = c^2',
          ),
        ],
      );

      await tester.pumpWidget(
        _app(
          child: VerPDFGenerado(
            title: first.title,
            previewContents: const [first, second],
          ),
        ),
      );

      expect(find.text('Primera formula'), findsNWidgets(2));
      expect(find.text('Segunda formula'), findsOneWidget);
      expect(find.text('Desarrollo'), findsOneWidget);
      expect(find.text(r'a^2 + b^2 = c^2'), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget);
    },
  );

  testWidgets('task export options return every selected field to the caller', (
    tester,
  ) async {
    late Future<ExportOptions?> result;
    await tester.pumpWidget(
      _app(
        child: Builder(
          builder: (context) => TextButton(
            onPressed: () {
              result = showDialog<ExportOptions>(
                context: context,
                builder: (_) => const ExportOptionsDialog(),
              );
            },
            child: const Text('Configure export'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Configure export'));
    await tester.pumpAndSettle();
    for (final checkbox in find.byType(CheckboxListTile).evaluate()) {
      await tester.tap(find.byWidget(checkbox.widget));
      await tester.pump();
    }
    await tester.tap(find.text('Aceptar'));
    await tester.pumpAndSettle();

    final options = await result;
    expect(options, isNotNull);
    expect(options!.includeDueDate, isTrue);
    expect(options.includeReminderDate, isTrue);
    expect(options.includeTaskStatus, isTrue);
  });

  testWidgets(
    'task screen opens the add-task sheet and export dialog from user actions',
    (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<TaskData>(
          create: (_) => TaskData(),
          child: _app(child: const TasksScreen()),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.byType(AddTaskScreen), findsOneWidget);

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.share));
      await tester.pumpAndSettle();
      expect(find.byType(ExportOptionsDialog), findsOneWidget);

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(find.byType(ExportOptionsDialog), findsNothing);
      expect(find.byType(TasksScreen), findsOneWidget);
    },
  );

  testWidgets('task screen confirms before clearing every existing task', (
    tester,
  ) async {
    final taskData = TaskData();
    taskData.addTask(Task(name: 'Preparar parcial'));
    taskData.addTask(Task(name: 'Repasar derivadas'));
    final expectedTaskCount = taskData.taskCount;

    await tester.pumpWidget(
      ChangeNotifierProvider<TaskData>.value(
        value: taskData,
        child: _app(child: const TasksScreen()),
      ),
    );

    await tester.longPress(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(expectedTaskCount, greaterThan(0));
    expect(taskData.taskCount, expectedTaskCount);

    await tester.tap(find.text('Eliminar'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(taskData.taskCount, 0);
  });

  testWidgets(
    'favorites creates a folder, moves a saved formula, and opens it',
    (tester) async {
      final favorites = FavoritesNotifier();
      final favorite = Favorite(
        title: 'Teorema del rotacional',
        widgetName: kWidgetTeoremaDelRotacional,
      );
      favorites.addFavorite(favorite);

      await tester.pumpWidget(
        ChangeNotifierProvider<FavoritesNotifier>.value(
          value: favorites,
          child: _app(child: const FavoritesScreen()),
        ),
      );

      expect(find.text('Teorema del rotacional'), findsOneWidget);
      await tester.tap(find.text('Crear carpeta'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Examen');
      await tester.tap(find.text('Guardar'));
      await tester.pumpAndSettle();

      expect(favorites.activeFolder.name, 'Examen');
      expect(favorites.activeFolder.favorites, isEmpty);

      favorites.moveFavoriteToFolder(favorite, favorites.activeFolderId);
      await tester.pumpAndSettle();
      expect(find.text('Teorema del rotacional'), findsOneWidget);

      await tester.tap(find.text('Teorema del rotacional'));
      await tester.pumpAndSettle();
      expect(find.byType(FavoritesScreen), findsNothing);
    },
  );

  testWidgets('favorites explains why moving requires another folder', (
    tester,
  ) async {
    final favorites = FavoritesNotifier();
    favorites.addFavorite(
      Favorite(title: 'Ley de Gauss', widgetName: kWidgetTeoremaDelRotacional),
    );

    await tester.pumpWidget(
      ChangeNotifierProvider<FavoritesNotifier>.value(
        value: favorites,
        child: _app(child: const FavoritesScreen()),
      ),
    );

    await tester.tap(find.byIcon(Icons.drive_file_move_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(favorites.activeFolder.favorites, hasLength(1));
  });

  testWidgets(
    'favorites only clear after the destructive action is confirmed',
    (tester) async {
      final favorites = FavoritesNotifier();
      favorites.addFavorite(
        Favorite(
          title: 'Ley de Faraday',
          widgetName: kWidgetTeoremaDelRotacional,
        ),
      );

      await tester.pumpWidget(
        ChangeNotifierProvider<FavoritesNotifier>.value(
          value: favorites,
          child: _app(child: const FavoritesScreen()),
        ),
      );

      await tester.tap(find.byIcon(Icons.delete_forever));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(favorites.favorites, hasLength(1));

      await tester.tap(find.text('Eliminar'));
      await tester.pumpAndSettle();
      expect(favorites.favorites, isEmpty);
    },
  );
}

Widget _app({required Widget child}) {
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
    home: Scaffold(body: child),
  );
}
