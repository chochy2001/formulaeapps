import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/widgets_personalizados/alerts_dialogs.dart';
import 'package:formulae/widgets_personalizados/boton_pistas.dart';
import 'package:formulae/widgets_personalizados/task_tile.dart';

void main() {
  Widget localizedHarness({required Locale locale, required Widget child}) {
    return MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  testWidgets('hint and answer buttons follow the active locale', (
    tester,
  ) async {
    await tester.pumpWidget(
      localizedHarness(
        locale: const Locale('en'),
        child: const Column(
          children: [BotonVerPistas(SizedBox()), BotonVerRespuesta(SizedBox())],
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(ElevatedButton, 'Hint'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Answer'), findsOneWidget);

    await tester.pumpWidget(
      localizedHarness(
        locale: const Locale('es'),
        child: const Column(
          children: [BotonVerPistas(SizedBox()), BotonVerRespuesta(SizedBox())],
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(ElevatedButton, 'Pista'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Respuesta'), findsOneWidget);
  });

  testWidgets('task deletion dialog uses English labels and keeps deletion', (
    tester,
  ) async {
    var deleted = false;
    await tester.pumpWidget(
      localizedHarness(
        locale: const Locale('en'),
        child: TaskTile(
          isChecked: false,
          taskTitle: 'Review derivatives',
          checkboxCallback: (_) {},
          longPressCallback: () => deleted = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.longPress(find.byType(TaskTile));
    await tester.pumpAndSettle();

    expect(find.text('Delete task'), findsOneWidget);
    expect(
      find.text('Are you sure you want to delete the task?'),
      findsOneWidget,
    );
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Remove'), findsOneWidget);

    await tester.tap(find.text('Remove'));
    await tester.pumpAndSettle();
    expect(deleted, isTrue);
  });

  testWidgets('task deletion dialog uses Spanish labels', (tester) async {
    await tester.pumpWidget(
      localizedHarness(
        locale: const Locale('es'),
        child: TaskTile(
          isChecked: false,
          taskTitle: 'Repasar derivadas',
          checkboxCallback: (_) {},
          longPressCallback: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.longPress(find.byType(TaskTile));
    await tester.pumpAndSettle();

    expect(find.text('Eliminar tarea'), findsOneWidget);
    expect(
      find.text('¿Está seguro que desea eliminar la tarea?'),
      findsOneWidget,
    );
    expect(find.text('Cancelar'), findsOneWidget);
    expect(find.text('Eliminar'), findsOneWidget);
  });

  testWidgets('information dialog localizes its close action', (tester) async {
    await tester.pumpWidget(
      localizedHarness(
        locale: const Locale('en'),
        child: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => mostrarInfo(context, 'Information'),
            child: const Text('Open'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open'));
    await tester.pump();

    expect(find.text('Close'), findsOneWidget);
    await tester.tap(find.text('Close'));
    await tester.pump();
    expect(find.text('Close'), findsNothing);
  });
}
