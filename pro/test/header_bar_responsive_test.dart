import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/widgets_personalizados/app_bar_home.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('the Pro app bar scales its brand mark on narrow screens',
      (tester) async {
    addTearDown(() => tester.binding.setSurfaceSize(null));

    for (final width in [320.0, 600.0, 900.0, 1440.0]) {
      await tester.binding.setSurfaceSize(Size(width, 800));
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(appBar: AppBarHome(), body: SizedBox.shrink()),
        ),
      );
      await tester.pump();
      expect(
        tester.takeException(),
        isNull,
        reason: 'Formulae Pro app bar must fit $width px',
      );
    }
  });
}
