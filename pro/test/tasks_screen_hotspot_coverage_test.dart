import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/widgets_personalizados/todo/export_options.dart';
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

  test(
    'buildTasksPdfBytes encodes status, reminder and due-date options',
    () async {
      final localizations = await AppLocalizations.delegate.load(
        const Locale('es'),
      );
      final tasks = [
        Task(
          name: 'Con fechas',
          isDone: true,
          reminderDateTime: DateTime(2026, 8, 10, 9, 30),
          dueDate: DateTime(2026, 8, 15, 18),
        ),
        Task(name: 'Sin fechas', isDone: false),
      ];

      final bytes = await TasksScreen.buildTasksPdfBytes(
        tasks: tasks,
        options: ExportOptions(
          includeTaskStatus: true,
          includeReminderDate: true,
          includeDueDate: true,
        ),
        localizations: localizations,
      );

      expect(bytes, isNotEmpty);
      expect(String.fromCharCodes(bytes.take(4)), '%PDF');
    },
  );

  test(
    'buildTasksPdfBytes keeps unchecked tasks when status is omitted',
    () async {
      final localizations = await AppLocalizations.delegate.load(
        const Locale('es'),
      );
      final bytes = await TasksScreen.buildTasksPdfBytes(
        tasks: [Task(name: 'Solo nombre')],
        options: ExportOptions(
          includeDueDate: false,
          includeReminderDate: false,
          includeTaskStatus: false,
        ),
        localizations: localizations,
      );
      expect(String.fromCharCodes(bytes.take(4)), '%PDF');
    },
  );

  test('buildTasksPdfDocument paginates content for many tasks', () async {
    final localizations = await AppLocalizations.delegate.load(
      const Locale('es'),
    );
    final tasks = List.generate(
      40,
      (index) => Task(
        name: 'Tarea $index con texto largo para forzar renglones',
        isDone: index.isEven,
        reminderDateTime: DateTime(2026, 11, 1, 9),
        dueDate: DateTime(2026, 11, 2),
      ),
    );

    final document = await TasksScreen.buildTasksPdfDocument(
      tasks: tasks,
      options: ExportOptions(
        includeTaskStatus: true,
        includeReminderDate: true,
        includeDueDate: true,
      ),
      localizations: localizations,
    );
    final bytes = await document.save();
    expect(String.fromCharCodes(bytes.take(4)), '%PDF');
    expect(document.document.pdfPageList.pages, isNotEmpty);
  });

  testWidgets(
    'ExportOptionsDialog returns the selected flags when accepted and null on cancel',
    (tester) async {
      late Future<ExportOptions?> accepted;
      late Future<ExportOptions?> cancelled;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('es'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        accepted = showDialog<ExportOptions>(
                          context: context,
                          builder: (_) => const ExportOptionsDialog(),
                        );
                      },
                      child: const Text('accept-flow'),
                    ),
                    TextButton(
                      onPressed: () {
                        cancelled = showDialog<ExportOptions>(
                          context: context,
                          builder: (_) => const ExportOptionsDialog(),
                        );
                      },
                      child: const Text('cancel-flow'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('accept-flow'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Incluir Estado'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Incluir Recordatorio'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Aceptar'));
      await tester.pumpAndSettle();

      final options = await accepted;
      expect(options, isNotNull);
      expect(options!.includeTaskStatus, isTrue);
      expect(options.includeReminderDate, isTrue);
      expect(options.includeDueDate, isFalse);

      await tester.tap(find.text('cancel-flow'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(await cancelled, isNull);
    },
  );

  testWidgets(
    'generatePdfAndSave delivers PDF bytes through the download seam',
    (tester) async {
      final downloads = <({Uint8List bytes, String fileName})>[];
      TasksScreen.debugDownloadOverride = (bytes, fileName) async {
        downloads.add((bytes: bytes, fileName: fileName));
      };
      addTearDown(() {
        TasksScreen.debugDownloadOverride = null;
      });

      late BuildContext capturedContext;
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('es'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                capturedContext = context;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      await const TasksScreen().generatePdfAndSave(
        [
          Task(
            name: 'Exportar lista',
            isDone: true,
            reminderDateTime: DateTime(2026, 10, 1, 12),
            dueDate: DateTime(2026, 10, 2),
          ),
        ],
        capturedContext,
        ExportOptions(
          includeTaskStatus: true,
          includeReminderDate: true,
          includeDueDate: true,
        ),
      );

      expect(downloads, hasLength(1));
      expect(String.fromCharCodes(downloads.single.bytes.take(4)), '%PDF');
      expect(downloads.single.fileName, isNotEmpty);
    },
  );

  testWidgets(
    'Compartir Todo formats status/reminder/due text through the share seam',
    (tester) async {
      final shared = <String>[];
      TasksScreen.debugShareTextOverride = (text) async {
        shared.add(text);
      };
      addTearDown(() {
        TasksScreen.debugShareTextOverride = null;
      });

      final tasks = TaskData();
      await tester.pump();
      tasks.deleteAllTasks();
      tasks.addTask(
        Task(
          name: 'Con fechas',
          isDone: true,
          reminderDateTime: DateTime(2026, 8, 10, 9, 30),
          dueDate: DateTime(2026, 8, 15, 18),
        ),
      );
      tasks.addTask(Task(name: 'Sin fechas', isDone: false));

      await tester.pumpWidget(_tasksApp(tasks));
      await tester.pump(const Duration(milliseconds: 200));

      await tester.tap(find.text('Compartir Todo'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Incluir Estado'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Incluir Recordatorio'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Incluir Fecha de Entrega'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Aceptar'));
      await tester.pumpAndSettle();

      expect(shared, hasLength(1));
      expect(shared.single, contains('Con fechas'));
      expect(shared.single, contains('✅'));
      expect(shared.single, contains('Sin fechas'));
      expect(shared.single, contains('❌'));
      expect(shared.single, contains('2026-08-10'));
      expect(shared.single, contains('2026-08-15'));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Compartir Todo cancel leaves tasks untouched', (tester) async {
    var shareCalls = 0;
    TasksScreen.debugShareTextOverride = (_) async {
      shareCalls++;
    };
    addTearDown(() {
      TasksScreen.debugShareTextOverride = null;
    });

    final tasks = TaskData();
    await tester.pump();
    tasks.deleteAllTasks();
    tasks.addTask(Task(name: 'Cancelable'));

    await tester.pumpWidget(_tasksApp(tasks));
    await tester.pump(const Duration(milliseconds: 200));

    await tester.tap(find.text('Compartir Todo'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    expect(shareCalls, 0);
    expect(tasks.tasks, hasLength(1));
  });

  testWidgets(
    'long-press share exports PDF through the download seam',
    (tester) async {
      final downloads = <({Uint8List bytes, String fileName})>[];
      TasksScreen.debugDownloadOverride = (bytes, fileName) async {
        downloads.add((bytes: bytes, fileName: fileName));
      };
      addTearDown(() {
        TasksScreen.debugDownloadOverride = null;
      });

      final tasks = TaskData();
      await tester.pump();
      tasks.deleteAllTasks();
      tasks.addTask(
        Task(
          name: 'PDF export',
          isDone: false,
          reminderDateTime: DateTime(2026, 9, 1, 8),
          dueDate: DateTime(2026, 9, 2),
        ),
      );

      await tester.pumpWidget(_tasksApp(tasks));
      await tester.pump(const Duration(milliseconds: 200));

      await tester.longPress(find.text('Compartir Todo'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Incluir Estado'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Aceptar'));
      await tester.pumpAndSettle();

      expect(downloads, hasLength(1));
      expect(String.fromCharCodes(downloads.single.bytes.take(4)), '%PDF');
      expect(find.text('PDF generado'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'long-press share cancel skips PDF export',
    (tester) async {
      var downloadCalls = 0;
      TasksScreen.debugDownloadOverride = (_, __) async {
        downloadCalls++;
      };
      addTearDown(() {
        TasksScreen.debugDownloadOverride = null;
      });

      final tasks = TaskData();
      await tester.pump();
      tasks.deleteAllTasks();
      tasks.addTask(Task(name: 'Sin export'));

      await tester.pumpWidget(_tasksApp(tasks));
      await tester.pump(const Duration(milliseconds: 200));

      await tester.longPress(find.text('Compartir Todo'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      expect(downloadCalls, 0);
      expect(find.text('PDF generado'), findsNothing);
    },
  );
}

Widget _tasksApp(TaskData tasks) {
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
