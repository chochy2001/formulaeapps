import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:formulae/widgets_personalizados/task_tile.dart';

void main() {
  testWidgets('TaskTile renders title and checkbox state', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskTile(
            isChecked: false,
            taskTitle: 'Solve quadratic',
            checkboxCallback: (_) {},
            longPressCallback: () {},
          ),
        ),
      ),
    );

    expect(find.text('Solve quadratic'), findsOneWidget);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);
  });

  testWidgets('TaskTile forwards checkbox taps', (tester) async {
    bool? toggled;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskTile(
            isChecked: true,
            taskTitle: 'Review limits',
            checkboxCallback: (value) => toggled = value,
            longPressCallback: () {},
          ),
        ),
      ),
    );

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    expect(toggled, isFalse);
  });

  testWidgets('TaskTile shows strike-through when checked', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskTile(
            isChecked: true,
            taskTitle: 'Done task',
            checkboxCallback: (_) {},
            longPressCallback: () {},
          ),
        ),
      ),
    );

    final text = tester.widget<Text>(find.text('Done task'));
    expect(text.style?.decoration, TextDecoration.lineThrough);
  });
}
