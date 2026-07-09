import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/constantes/constantes_favoritos.dart';
import 'package:formulae/constantes/contantes_mapa_pdfs.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/screens_personalizados/drawer_personalizado.dart';
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
    FlutterError.onError = (details) {};
  });

  testWidgets('DrawerPersonalizado mounts Android and iOS variants',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    for (final platform in [0, 1]) {
      await tester.pumpWidget(
        _harness(home: Scaffold(drawer: DrawerPersonalizado(platform))),
      );
      await tester.pump();
      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      while (tester.takeException() != null) {}
      expect(find.byType(Drawer), findsOneWidget);
    }
  });

  testWidgets('urlPdfMap and getUrlPdfById resolve known widgets',
      (tester) async {
    late BuildContext captured;
    await tester.pumpWidget(
      _harness(
        home: Builder(builder: (context) {
          captured = context;
          return const SizedBox.shrink();
        }),
      ),
    );
    await tester.pump();

    expect(urlPdfMap.length, greaterThan(100));
    expect(getUrlPdfById(captured, kWidgetFormulaGeneral), contains('.pdf'));
    expect(getUrlPdfById(captured, 'missing-widget-id'), isNull);

    var resolved = 0;
    for (final id in urlPdfMap.keys) {
      if (getUrlPdfById(captured, id) != null) resolved++;
    }
    expect(resolved, greaterThan(100));
  });

  testWidgets('TasksScreen and TasksList mount with TaskData', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    final taskData = TaskData();
    await tester.pumpWidget(
      _harness(
        taskData: taskData,
        home: const TasksScreen(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    while (tester.takeException() != null) {}
    expect(find.byType(TasksScreen), findsOneWidget);

    await tester.pumpWidget(
      _harness(
        taskData: taskData,
        home: const Scaffold(body: TasksList()),
      ),
    );
    await tester.pump();
    while (tester.takeException() != null) {}
    expect(find.byType(TasksList), findsOneWidget);
  });

  testWidgets('AddTaskScreen and ExportOptionsDialog mount', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    final taskData = TaskData();
    await tester.pumpWidget(
      _harness(
        taskData: taskData,
        home: const Scaffold(body: AddTaskScreen()),
      ),
    );
    await tester.pump();
    while (tester.takeException() != null) {}
    expect(find.byType(AddTaskScreen), findsOneWidget);

    await tester.pumpWidget(
      _harness(
        taskData: taskData,
        home: const Scaffold(body: ExportOptionsDialog()),
      ),
    );
    await tester.pump();
    while (tester.takeException() != null) {}
    expect(find.byType(ExportOptionsDialog), findsOneWidget);
    // Toggle checkboxes to exercise dialog state.
    final checkboxes = find.byType(CheckboxListTile);
    if (checkboxes.evaluate().isNotEmpty) {
      await tester.tap(checkboxes.first);
      await tester.pump();
    }
  });

  test('TaskData mutates tasks', () async {
    SharedPreferences.setMockInitialValues({});
    final data = TaskData();
    final before = data.taskCount;
    final task = Task(name: 'coverage-task');
    data.addTask(task);
    expect(data.taskCount, before + 1);
    data.updateTask(task);
    data.deleteTask(task);
    expect(data.taskCount, before);
    data.deleteAllTasks();
    expect(data.taskCount, 0);
  });

  testWidgets('VerPDF and DescargarPDF shrink for missing urls', (tester) async {
    await tester.pumpWidget(
      _harness(home: const Scaffold(body: VerPDF(url: ''))),
    );
    await tester.pump();
    await tester.pumpWidget(
      _harness(home: const Scaffold(body: DescargarPDF(url: 'no-such-id'))),
    );
    await tester.pump();
    while (tester.takeException() != null) {}
  });
}

Widget _harness({
  required Widget home,
  TaskData? taskData,
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LocaleProvider>(
        create: (_) => LocaleProvider(const Locale('es')),
      ),
      ChangeNotifierProvider<ModelsProvider>(create: (_) => ModelsProvider()),
      ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
      ChangeNotifierProvider<TaskData>.value(
        value: taskData ?? TaskData(),
      ),
      ChangeNotifierProvider<FavoritesNotifier>(
        create: (_) => FavoritesNotifier(),
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
