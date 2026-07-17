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
    'task export options return every selected field to the caller',
    (tester) async {
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
    },
  );

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
