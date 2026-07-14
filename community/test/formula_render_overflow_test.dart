import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/ads/admob_config.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/models/task_data.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/secciones_app/algebra/ecuaciones/ecuaciones_primer_grado.dart';
import 'package:formulae/widgets_personalizados/textos_personalizados.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    AdMobConfig.adsEnabled = false;
  });

  tearDown(() {
    AdMobConfig.adsEnabled = true;
  });

  testWidgets(
    'first-degree equations keep dynamic formulas scrollable at narrow and desktop widths',
    (tester) async {
      addTearDown(() => tester.binding.setSurfaceSize(null));

      for (final width in [320.0, 900.0]) {
        await tester.binding.setSurfaceSize(Size(width, 1600));
        await tester.pumpWidget(
          _harness(EcuacionesDePrimerGrado(key: ValueKey(width))),
        );
        await tester.pump();

        expect(
          tester.takeException(),
          isNull,
          reason: 'initial formulas must fit at $width px',
        );
        final initialFormulas =
            tester.widgetList<Latex>(find.byType(Latex)).map((latex) {
          return latex.formulaText;
        }).toList();
        expect(
          initialFormulas,
          contains('0.0 x+0.0=0.0'),
          reason: 'the equation shown to the learner must be preserved',
        );

        final fields = find.byType(TextField);
        expect(fields, findsNWidgets(3));
        await tester.enterText(fields.at(0), '5');
        await tester.enterText(fields.at(1), '2');
        await tester.enterText(fields.at(2), '12');
        await tester.pump();

        expect(
          tester.takeException(),
          isNull,
          reason: 'updated formulas must fit at $width px',
        );
        final updatedFormulas =
            tester.widgetList<Latex>(find.byType(Latex)).map((latex) {
          return latex.formulaText;
        }).toList();
        expect(
          updatedFormulas,
          contains('5.0 x+2.0=12.0'),
          reason: 'input values must still reach the displayed equation',
        );

        final horizontalScrollables = tester
            .widgetList<Scrollable>(find.byType(Scrollable))
            .where((scrollable) => scrollable.axis == Axis.horizontal);
        expect(
          horizontalScrollables,
          isNotEmpty,
          reason: 'long formulas must remain reachable by horizontal scroll',
        );
      }
    },
  );
}

Widget _harness(Widget home) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LocaleProvider>(
        create: (_) => LocaleProvider(const Locale('es')),
      ),
      ChangeNotifierProvider<ModelsProvider>(create: (_) => ModelsProvider()),
      ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
      ChangeNotifierProvider<TaskData>(create: (_) => TaskData()),
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
