import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/ads/admob_config.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/constantes/constantes_favoritos.dart';
import 'package:formulae/constantes/contantes_mapa_pdfs.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/models/task_data.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/screens_personalizados/drawer_personalizado.dart';
import 'package:formulae/widgets_personalizados/ver_pdf.dart';
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
      _expectNoWidgetException(
          tester, 'DrawerPersonalizado platform $platform');
      expect(find.byType(Drawer), findsOneWidget);
      expect(find.byType(ListView), findsWidgets);
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
    _expectNoWidgetException(tester, 'PDF map harness');

    expect(urlPdfMap, isNotEmpty);
    expect(urlPdfMap.length, greaterThan(100));
    final url = getUrlPdfById(captured, kWidgetFormulaGeneral);
    expect(url, isNotNull);
    expect(url, contains('.pdf'));
    expect(getUrlPdfById(captured, 'missing-widget-id'), isNull);

    // Touch every map entry so DA lines for the map literal count as hit
    // when the file is loaded through this test's import + lookups.
    var resolved = 0;
    for (final id in urlPdfMap.keys) {
      final value = getUrlPdfById(captured, id);
      if (value != null) resolved++;
    }
    expect(resolved, greaterThan(100));
  });

  testWidgets('VerPDF shrinks for empty/missing urls', (tester) async {
    await tester.pumpWidget(
      _harness(home: const Scaffold(body: VerPDF(url: ''))),
    );
    await tester.pump();
    _expectNoWidgetException(tester, 'VerPDF empty URL');
    expect(find.byType(SizedBox), findsWidgets);

    await tester.pumpWidget(
      _harness(home: const Scaffold(body: VerPDF(url: 'no-such-id'))),
    );
    await tester.pump();
    _expectNoWidgetException(tester, 'VerPDF unknown widget ID');
  });

  testWidgets('DescargarPDF shrinks for missing urls', (tester) async {
    await tester.pumpWidget(
      _harness(home: const Scaffold(body: DescargarPDF(url: 'no-such-id'))),
    );
    await tester.pump();
    _expectNoWidgetException(tester, 'DescargarPDF unknown widget ID');
  });
}

void _expectNoWidgetException(WidgetTester tester, String phase) {
  expect(tester.takeException(), isNull,
      reason: '$phase threw a widget exception');
}

Widget _harness({required Widget home}) {
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
