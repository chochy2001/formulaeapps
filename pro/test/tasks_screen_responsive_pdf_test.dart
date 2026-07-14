import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/widgets_personalizados/todo/export_options.dart';
import 'package:formulae/widgets_personalizados/todo/task.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:formulae/widgets_personalizados/todo/tasks_screen.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Tasks screen fits mobile through desktop widths',
      (tester) async {
    addTearDown(() => tester.binding.setSurfaceSize(null));

    for (final width in [320.0, 600.0, 900.0, 1440.0]) {
      await tester.binding.setSurfaceSize(Size(width, 900));
      await tester.pumpWidget(_tasksHarness(TaskData()));
      await tester.pump(const Duration(milliseconds: 250));

      expect(
        tester.takeException(),
        isNull,
        reason: 'Tasks screen must fit $width px without a render exception',
      );
    }
  });

  testWidgets('task PDF paginates a long list without dropping generation',
      (tester) async {
    final localizations =
        await AppLocalizations.delegate.load(const Locale('en'));
    final tasks = List.generate(
      180,
      (index) => Task(
        name: 'Task $index with enough text to occupy a complete PDF row.',
        isDone: index.isEven,
        reminderDateTime: DateTime(2026, 7, 13, 10, 30),
        dueDate: DateTime(2026, 7, 20, 17, 45),
      ),
    );

    final printed = <String>[];
    final document = await runZoned<Future<pw.Document>>(
      () => TasksScreen.buildTasksPdfDocument(
        tasks: tasks,
        options: ExportOptions(
          includeDueDate: true,
          includeReminderDate: true,
          includeTaskStatus: true,
        ),
        localizations: localizations,
      ),
      zoneSpecification: ZoneSpecification(
        print: (_, __, ___, line) => printed.add(line),
      ),
    );

    expect(document.document.pdfPageList.pages.length, greaterThan(1));
    final bytes = await document.save();
    expect(String.fromCharCodes(bytes.take(4)), '%PDF');
    expect(
      printed.where((line) => line.contains('Unable to find a font to draw')),
      isEmpty,
    );
  });
}

Widget _tasksHarness(TaskData taskData) {
  return ChangeNotifierProvider<TaskData>.value(
    value: taskData,
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
