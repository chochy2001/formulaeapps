import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:formulae/widgets_personalizados/todo/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets(
    'task screen keeps tasks when clear-all is cancelled and removes them only after confirmation',
    (tester) async {
      final tasks = TaskData();
      await tester.pump();
      tasks.deleteAllTasks();
      tasks.addTask(Task(name: 'Entregar proyecto'));

      await tester.pumpWidget(_app(tasks));
      await tester.pump(const Duration(milliseconds: 200));

      await tester.longPress(find.text('Agregar'));
      await tester.pumpAndSettle();
      expect(find.text('Eliminar todas las tareas'), findsOneWidget);

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(tasks.tasks.single.name, 'Entregar proyecto');

      await tester.longPress(find.text('Agregar'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Eliminar'));
      await tester.pumpAndSettle();

      expect(tasks.tasks, isEmpty);
    },
  );

  testWidgets('task screen opens the add-task sheet from its primary action', (
    tester,
  ) async {
    final tasks = TaskData();
    await tester.pump();
    tasks.deleteAllTasks();

    await tester.pumpWidget(_app(tasks));
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.text('Agregar'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets(
    'adding a task can skip optional reminder and due dates without losing its name',
    (tester) async {
      final tasks = TaskData();
      await tester.pump();
      tasks.deleteAllTasks();

      await tester.pumpWidget(_app(tasks));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.tap(find.text('Agregar'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Preparar examen');
      await tester.tap(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(TextButton),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);

      await tester.tap(find.text('Saltar'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);

      await tester.tap(find.text('Saltar'));
      await tester.pumpAndSettle();

      expect(tasks.tasks, hasLength(1));
      expect(tasks.tasks.single.name, 'Preparar examen');
      expect(tasks.tasks.single.reminderDateTime, isNull);
      expect(tasks.tasks.single.dueDate, isNull);
      expect(find.byType(BottomSheet), findsNothing);
    },
  );
}

Widget _app(TaskData tasks) {
  return ChangeNotifierProvider<TaskData>.value(
    value: tasks,
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
      home: const TasksScreen(),
    ),
  );
}
