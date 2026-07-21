import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:formulae/widgets_personalizados/todo/tasks_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  tzdata.initializeTimeZones();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    _mockSharePlus();
    _mockLocalNotifications();
  });

  testWidgets(
    'empty task list shows the add-task illustration instead of rows',
    (tester) async {
      final tasks = TaskData();
      await tester.pump();
      tasks.deleteAllTasks();

      await tester.pumpWidget(_app(tasks));
      await tester.pumpAndSettle();

      expect(find.byType(Slidable), findsNothing);
      expect(find.byType(ListView), findsNothing);
    },
  );

  testWidgets('share slide action completes without mutating the shared task', (
    tester,
  ) async {
    final tasks = TaskData();
    await tester.pump();
    tasks.deleteAllTasks();
    final task = Task(name: 'Compartir parcial', isDone: true);
    tasks.addTask(task);

    await tester.pumpWidget(_app(tasks));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(Slidable), const Offset(500, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Compartir'));
    await tester.pumpAndSettle();

    expect(tasks.tasks, hasLength(1));
    expect(tasks.tasks.single.name, 'Compartir parcial');
    expect(tasks.tasks.single.isDone, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'share slide action includes unfinished status without mutating the task',
    (tester) async {
      final tasks = TaskData();
      await tester.pump();
      tasks.deleteAllTasks();
      final task = Task(name: 'Pendiente por compartir', isDone: false);
      tasks.addTask(task);

      await tester.pumpWidget(_app(tasks));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Slidable), const Offset(500, 0));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Compartir'));
      await tester.pumpAndSettle();

      expect(tasks.tasks.single.isDone, isFalse);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('edit dialog cancel keeps the original task name', (
    tester,
  ) async {
    final tasks = TaskData();
    await tester.pump();
    tasks.deleteAllTasks();
    final task = Task(name: 'Nombre estable', isDone: false);
    tasks.addTask(task);

    await tester.pumpWidget(_app(tasks));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(Slidable), const Offset(500, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Editar'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'No debe guardarse');
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    expect(tasks.tasks.single.name, 'Nombre estable');
  });

  testWidgets(
    'reminder dialog cancel closes without assigning a reminder date',
    (tester) async {
      final tasks = TaskData();
      await tester.pump();
      tasks.deleteAllTasks();
      final task = Task(name: 'Sin recordatorio');
      tasks.addTask(task);

      await tester.pumpWidget(_app(tasks));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Slidable), const Offset(-500, 0));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Recordatorio'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      expect(task.reminderDateTime, isNull);
      expect(find.byType(AlertDialog), findsNothing);
    },
  );

  testWidgets(
    'reminder date/time picker opens Material pickers from the DateTimeField',
    (tester) async {
      final tasks = TaskData();
      await tester.pump();
      tasks.deleteAllTasks();
      final task = Task(name: 'Con recordatorio');
      tasks.addTask(task);

      await tester.pumpWidget(_app(tasks));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Slidable), const Offset(-500, 0));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Recordatorio'));
      await tester.pumpAndSettle();

      expect(find.byType(DateTimeField), findsOneWidget);
      await tester.tap(find.byType(DateTimeField));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsOneWidget);
      await tester.tap(
        find
            .descendant(
              of: find.byType(DatePickerDialog),
              matching: find.byType(TextButton),
            )
            .last,
      );
      await tester.pumpAndSettle();

      if (find.byType(TimePickerDialog).evaluate().isNotEmpty) {
        await tester.tap(
          find
              .descendant(
                of: find.byType(TimePickerDialog),
                matching: find.byType(TextButton),
              )
              .last,
        );
        await tester.pumpAndSettle();
      }

      await tester.tap(find.text('Guardar Recordatorio'));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'incomplete task details dialog reports unfinished state and missing dates',
    (tester) async {
      final tasks = TaskData();
      await tester.pump();
      tasks.deleteAllTasks();
      tasks.addTask(Task(name: 'Pendiente de detalle'));

      await tester.pumpWidget(_app(tasks));
      await tester.pumpAndSettle();

      await tester.longPress(find.text('Pendiente de detalle'));
      await tester.pumpAndSettle();

      expect(find.textContaining('❌'), findsOneWidget);
      expect(find.textContaining('No Asignado'), findsWidgets);

      await tester.tap(find.text('Cerrar'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    },
  );
}

void _mockSharePlus() {
  const channel = MethodChannel('dev.fluttercommunity.plus/share');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (call) async {
        return 'shared';
      });
}

void _mockLocalNotifications() {
  const channel = MethodChannel('dexterous.com/flutter/local_notifications');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (call) async {
        return null;
      });
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
      home: const Scaffold(body: TasksList()),
    ),
  );
}
