import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/ads/admob_config.dart';
import 'package:formulae/busqueda/busqueda.dart';
import 'package:formulae/busqueda/search_delegate.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/models/task_data.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/widgets_personalizados/app_bar_busqueda.dart';
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

  test('removeDiacritics strips accents', () {
    final search = DataSearch(buscarFormula: 'Buscar');
    expect(search.removeDiacritics('Álgebra'), 'Algebra');
    expect(search.removeDiacritics('ecuación'), 'ecuacion');
    expect(search.searchFieldLabel, 'Buscar');
  });

  testWidgets('getSearchResults and getSearchResultss build full catalogs',
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
    _expectNoWidgetException(tester, 'search catalog harness');

    final search = DataSearch(buscarFormula: 'Buscar fórmula');
    final results = search.getSearchResults(captured);
    final routes = search.getSearchResultss(captured);

    expect(results, isNotEmpty);
    expect(results.length, greaterThan(200));
    expect(routes, isNotEmpty);
    expect(routes.length, greaterThan(200));
    expect(search.appBarTheme(captured), isA<ThemeData>());
  });

  testWidgets('DataSearch buildSuggestions/buildResults execute',
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
    _expectNoWidgetException(tester, 'DataSearch harness');

    final search = DataSearch(buscarFormula: 'Buscar');
    search.query = '';
    final empty = search.buildSuggestions(captured);
    expect(empty, isA<Widget>());

    search.query = 'algebra';
    final suggestions = search.buildSuggestions(captured);
    final results = search.buildResults(captured);
    expect(suggestions, isA<Widget>());
    expect(results, isA<Widget>());
    expect(search.buildActions(captured), isNotEmpty);
    expect(search.buildLeading(captured), isA<Widget>());

    await tester.pumpWidget(
      _harness(
        home: Scaffold(body: results),
      ),
    );
    await tester.pump();
    _expectNoWidgetException(tester, 'DataSearch results');
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('Busqueda menu list mounts', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 2400));
    await tester.pumpWidget(
      _harness(home: const Scaffold(body: Busqueda())),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 16));
    _expectNoWidgetException(tester, 'Busqueda menu');
    expect(find.byType(Busqueda), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);
  });

  testWidgets('AppBarBusqueda builds without throwing', (tester) async {
    await tester.pumpWidget(
      _harness(
        home: const Scaffold(appBar: AppBarBusqueda(), body: SizedBox.shrink()),
      ),
    );
    await tester.pump();
    // Post-frame showSearch may replace the route, but must not throw.
    await tester.pump(const Duration(milliseconds: 50));
    _expectNoWidgetException(tester, 'AppBarBusqueda post-frame search');
    expect(find.byType(MaterialApp), findsOneWidget);
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
